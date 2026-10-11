//------------------------------------------
//INIQUITOUS 2011 D:
//------------------------------------------
// Loads the classes of the match's weapons on the client before they are met in play.
// A weapon class brings its meshes, animations, effects and fire modes with it, and loading
// those from disk in the middle of a fight is what stutters. Textures stay on demand
// unless the server asks for them as well.
class BallisticPreloadInteraction extends Interaction;

var() float FontScaleX, FontScaleY;
var() float TextOnePosX, TextOnePosY;
var() float BarWidth, BarHeight;

var() int WeaponNumber;			// Next entry of the list
var() int MaxLoadsPerFrame;		// Most weapons loaded in one frame while the player is not in the game yet
var() float LoadFrameTime;		// A frame that loads should take about this long while the player is not in the game yet
var() float RestFactor;			// In the game, a frame that loaded is followed by this many times its length without loading
var() float NameTimeout;		// Seconds to wait for a name that does not arrive

var() Font MessagesFont;
var() BallisticPreloadReplicationInfo MyRI;
var() Actor PreloadMeshActor;

var int NumLoaded;				// Entries there was something to do for
var int LoadsPerFrame;
var bool bLoadedLastFrame;
var float LoadStamp, RestUntil;
var int ShownFrames;
var float WaitStart;

var bool bDisplayDebugText;

event Initialized()
{
	WeaponNumber = 0;
}

simulated function Finish()
{
	if (PreloadMeshActor != None)
		PreloadMeshActor.Destroy();
	PreloadMeshActor = None;
	// The list is the weapons of the inventory mode and, after them, the killstreak rewards
	if (NumLoaded > 0)
		Log("BW Preload: Loaded"@NumLoaded@"of"@MyRI.PreloadNum@"weapons ("$(MyRI.PreloadNum - MyRI.RewardNum)@"from the game's weapon list,"@MyRI.RewardNum@"killstreak rewards)");
	MyRI = None;
	Master.RemoveInteraction(Self);
}

// Draws a mesh into a corner of the screen, which sends its buffers and skins to the video card
simulated function PrecacheMesh(Canvas C, Mesh M)
{
	local PlayerController PC;

	if (M == None)
		return;
	PC = ViewportOwner.Actor;
	if (PreloadMeshActor == None)
		PreloadMeshActor = PC.Spawn(class'BallisticPreloadMesh', PC);
	if (PreloadMeshActor == None)
		return;
	PreloadMeshActor.SetLocation(PC.CalcViewLocation + vector(PC.CalcViewRotation) * 256);
	PreloadMeshActor.LinkMesh(M, false);
	C.DrawActorClipped(PreloadMeshActor, false, 0, 0, 2, 2);
}

simulated function PrecacheMaterialName(LevelInfo L, string MaterialName)
{
	if (MaterialName != "")
		L.AddPrecacheMaterial(Material(DynamicLoadObject(MaterialName, class'Material', True)));
}

// What a weapon shows in the hands, on a player and on the ground
simulated function PrecacheWeapon(Canvas C, class<Weapon> WeaponClass)
{
	local LevelInfo L;
	local class<BallisticWeapon> BWClass;
	local class<BallisticWeaponParams> ParamsClass;
	local int j, k;

	L = ViewportOwner.Actor.Level;
	BWClass = class<BallisticWeapon>(WeaponClass);
	if (BWClass != None && BWClass.default.ParamsClasses.Length > class'BallisticReplicationInfo'.default.GameStyle)
		ParamsClass = BWClass.static.GetParams();

	if (MyRI.bEnableTextureLoading)
	{
		for (j = 0; j < WeaponClass.default.Skins.Length; j++)
			L.AddPrecacheMaterial(WeaponClass.default.Skins[j]);
		L.AddPrecacheMaterial(WeaponClass.default.IconMaterial);
		PrecacheMesh(C, WeaponClass.default.Mesh);

		if (WeaponClass.default.AttachmentClass != None)
		{
			for (j = 0; j < WeaponClass.default.AttachmentClass.default.Skins.Length; j++)
				L.AddPrecacheMaterial(WeaponClass.default.AttachmentClass.default.Skins[j]);
			PrecacheMesh(C, WeaponClass.default.AttachmentClass.default.Mesh);
		}

		if (WeaponClass.default.PickupClass != None)
		{
			WeaponClass.default.PickupClass.static.StaticPrecache(L);
			L.AddPrecacheStaticMesh(WeaponClass.default.PickupClass.default.StaticMesh);
		}

		if (BWClass != None)
			L.AddPrecacheMaterial(BWClass.default.BigIconMaterial);
	}

	if (ParamsClass == None)
		return;

	// Camo skins
	if (MyRI.bEnableCamoLoading)
		for (j = 0; j < ParamsClass.default.Camos.Length; j++)
			if (ParamsClass.default.Camos[j] != None)
				for (k = 0; k < ParamsClass.default.Camos[j].WeaponMaterialSwaps.Length; k++)
					PrecacheMaterialName(L, ParamsClass.default.Camos[j].WeaponMaterialSwaps[k].MaterialName);

	// Gun augments and layout-specific attachment assets
	if (MyRI.bEnableTextureLoading)
		for (j = 0; j < ParamsClass.default.Layouts.Length; j++)
		{
			for (k = 0; k < ParamsClass.default.Layouts[j].GunAugments.Length; k++)
				if (ParamsClass.default.Layouts[j].GunAugments[k].GunAugmentClass != None)
					L.AddPrecacheStaticMesh(ParamsClass.default.Layouts[j].GunAugments[k].GunAugmentClass.default.StaticMesh);

			PrecacheMesh(C, ParamsClass.default.Layouts[j].AttachmentMesh);

			for (k = 0; k < ParamsClass.default.Layouts[j].AttachmentMaterialSwaps.Length; k++)
				PrecacheMaterialName(L, ParamsClass.default.Layouts[j].AttachmentMaterialSwaps[k].MaterialName);
		}
}

// Returns whether there was anything to do for this entry
simulated function bool PreloadWeapon(Canvas C, string ClassName)
{
	local class<Weapon> WeaponClass;

	// The host of a game has the classes in memory already, and so has a client for the weapons it has met
	if (!MyRI.bEnableTextureLoading && !MyRI.bEnableCamoLoading && FindObject(ClassName, class'Class') != None)
		return false;

	WeaponClass = class<Weapon>(DynamicLoadObject(ClassName, class'Class', True));
	if (WeaponClass != None && (MyRI.bEnableTextureLoading || MyRI.bEnableCamoLoading))
		PrecacheWeapon(C, WeaponClass);
	NumLoaded++;
	return true;
}

simulated function DrawProgress(Canvas C)
{
	local float X, Y, W;

	X = C.ClipX * TextOnePosX;
	Y = C.ClipY * TextOnePosY;
	W = C.ClipX * BarWidth;

	C.Font = MessagesFont;
	C.FontScaleX = FontScaleX;
	C.FontScaleY = FontScaleY;
	C.Style = 5;
	C.SetDrawColor(255, 255, 0, 255);
	C.SetPos(X, Y);
	C.DrawTextClipped("Loading weapons" @ WeaponNumber $ "/" $ MyRI.PreloadNum);

	Y += C.ClipY * 0.035;
	C.SetDrawColor(64, 64, 64, 160);
	C.SetPos(X, Y);
	C.DrawTile(Texture'Engine.WhiteSquareTexture', W, BarHeight, 0, 0, 1, 1);
	C.SetDrawColor(255, 255, 0, 255);
	C.SetPos(X, Y);
	C.DrawTile(Texture'Engine.WhiteSquareTexture', W * WeaponNumber / MyRI.PreloadNum, BarHeight, 0, 0, 1, 1);
	C.Reset();
}

simulated function PostRender(Canvas Canvas)
{
	local PlayerController PC;
	local BallisticPreloadReplicationInfo RI;
	local int Limit, Done;
	local float Now, Cost;

	PC = ViewportOwner.Actor;
	if (PC == None)
		return;

	// Find the replication info as soon as it's available - doesn't need a Pawn
	if (MyRI == None)
	{
		foreach PC.DynamicActors(class'BallisticPreloadReplicationInfo', RI)
		{
			if (RI != None)
				MyRI = RI;
		}
		return;
	}

	// Wait for replicated data to arrive before starting
	if (MyRI.PreloadNum == 0)
		return;

	// Done. A negative count is the server saying there is nothing to load
	if (WeaponNumber >= MyRI.PreloadNum)
	{
		Finish();
		return;
	}

	Now = PC.Level.TimeSeconds;
	if (bLoadedLastFrame)
	{
		// How long the frame that loaded took decides how hard to go on, whatever the machine
		bLoadedLastFrame = false;
		Cost = Now - LoadStamp;
		RestUntil = Now + Cost * RestFactor;
		if (Cost < LoadFrameTime)
			LoadsPerFrame = Min(LoadsPerFrame + 1, MaxLoadsPerFrame);
		else
			LoadsPerFrame = Max(LoadsPerFrame - 1, 1);
	}

	// In the game every load is a hitch: one at a time, with a rest after each. Before that there is nothing to disturb.
	if (PC.Pawn == None)
		Limit = LoadsPerFrame;
	else if (Now >= RestUntil)
		Limit = 1;

	while (Done < Limit && WeaponNumber < MyRI.PreloadNum)
	{
		if (MyRI.CurrentName[WeaponNumber] == "")
		{
			// The names come in over a few ticks. One that never comes is passed over.
			if (WaitStart == 0)
				WaitStart = Now;
			else if (Now - WaitStart > NameTimeout)
			{
				WaitStart = 0;
				WeaponNumber++;
			}
			break;
		}
		WaitStart = 0;
		if (PreloadWeapon(Canvas, MyRI.CurrentName[WeaponNumber]))
			Done++;
		WeaponNumber++;
	}

	if (Done > 0)
	{
		bLoadedLastFrame = true;
		LoadStamp = Now;
	}

	// Nothing is shown when the list is done at once, as it is for the host of a game
	if (NumLoaded > 0)
		ShownFrames++;
	if (bDisplayDebugText && ShownFrames > 2 && WeaponNumber < MyRI.PreloadNum)
		DrawProgress(Canvas);
}

simulated function NotifyLevelChange()
{
	PreloadMeshActor = None;
	MyRI = None;
	Master.RemoveInteraction(Self);
}

defaultproperties
{
	 bDisplayDebugText=True
	 LoadsPerFrame=1
	 MaxLoadsPerFrame=8
	 LoadFrameTime=0.050000
	 RestFactor=1.000000
	 NameTimeout=5.000000
     FontScaleX=0.500000
     FontScaleY=0.500000
     TextOnePosX=0.350000
     TextOnePosY=0.850000
     BarWidth=0.300000
     BarHeight=4.000000
     MessagesFont=Font'2k4Fonts.Verdana24'
     bVisible=True
     bRequiresTick=True
}
