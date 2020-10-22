//=============================================================================
// AS50Rifle.
//
// This is actually not an AS50 so don't get excited.
// Fires bullets that are weaker than the X83, but are more sexy and glowy.
//
// For the record, this gun is even BIGGER than the X83. It's freaking huge.
//
// Uses new code by Azarael to not freeze when using IR view
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AS50Rifle extends BallisticWeapon;

var() name		ScopeBone;			// Bone to use for hiding scope
var name			BulletBone; //What it says on the tin

var() BUtil.FullSound	ThermalOnSound;	// Sound when activating thermal mode
var() BUtil.FullSound	ThermalOffSound;// Sound when deactivating thermal mode
var   Array<Pawn>		PawnList;		// A list of all the potential pawns to view in thermal mode
var() material			WallVisionSkin;	// Texture to assign to players when theyare viewed with Thermal mode
var   bool				bThermal;		// Is thermal mode active?
var   bool				bUpdatePawns;	// Should viewable pawn list be updated
var   Pawn				UpdatedPawns[16];// List of pawns to view in thermal scope
var() material			Flaretex;		// Texture to use to obscure vision when viewing enemies directly through the thermal scope
var() float				ThermalRange;	// Maximum range at which it is possible to see enemies through walls
var   ColorModifier		ColorMod;
var   actor			NVLight;
var   float				NextPawnListUpdateTime;
var() Texture ScopeViewTexThermal;



var	int	NumpadYOffset1; //Ammo tens
var	int	NumpadYOffset2; //Ammo ones
var() ScriptedTexture WeaponScreen;

var() Material	Screen;
var() Material	ScreenBaseX;
var() Material	ScreenBase1; //Norm
var() Material	ScreenBase2; //Stabilized
var() Material	ScreenBase3; //Empty
var() Material	ScreenBase4; //Stabilized + Empty
var() Material	Numbers;
var protected const color MyFontColor; //Why do I even need this?

replication
{
	// functions on server, called by client
   	reliable if( Role<ROLE_Authority )
		ServerAdjustThermal;
	reliable if(Role == ROLE_Authority)
		ClientScreenStart;
}

//========================== AMMO COUNTER NON-STATIC TEXTURE ============

simulated function ClientScreenStart()
{
	ScreenStart();
}
// Called on clients from camera when it gets to postnetbegin
simulated function ScreenStart()
{
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Client = self;
	Skins[5] = Screen;
	UpdateScreen();//Give it some numbers n shit
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Revision++;
}

simulated event Destroyed()
{
	if (Instigator != None && AIController(Instigator.Controller) == None)
		WeaponScreen.client=None;

	if (ColorMod != None)
	{
		Level.ObjectPool.FreeObject(ColorMod);
		ColorMod = None;
	}
	AdjustThermalView(false);

	if (NVLight != None)
		NVLight.Destroy();
		
	Super.Destroyed();
	
}

simulated event RenderTexture( ScriptedTexture Tex )
{
	Tex.DrawTile(0,0,256,128,0,0,256,128,ScreenBaseX, MyFontColor);
	Tex.DrawTile(0,45,70,70,45,NumpadYOffset1,50,50,Numbers, MyFontColor); //Ammo
	Tex.DrawTile(20,45,70,70,40,NumpadYOffset2,50,50,Numbers, MyFontColor);
}
	
simulated function UpdateScreen()
{
	if (Instigator != None && AIController(Instigator.Controller) != None) //Bots cannot update your screen
		return;

	if (Instigator.IsLocallyControlled())
		WeaponScreen.Revision++;
}
	
// Consume ammo from one of the possible sources depending on various factors
simulated function bool ConsumeMagAmmo(int Mode, float Load, optional bool bAmountNeededIsMax)
{
	if (bNoMag || (BFireMode[Mode] != None && BFireMode[Mode].bUseWeaponMag == false))
		ConsumeAmmo(Mode, Load, bAmountNeededIsMax);
	else
	{
		if (MagAmmo < Load)
			MagAmmo = 0;
		else
			MagAmmo -= Load;
	}
	UpdateScreen();
	return true;
}

function ServerSwitchWeaponMode(byte NewMode)
{
	super.ServerSwitchWeaponMode(NewMode);
	UpdateScreen();
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipUp()
{
	SetBoneScale(1,1.0,BulletBone);
}

simulated function Notify_ClipOut()
{
	Super.Notify_ClipOut();

	if(MagAmmo < 2)
		SetBoneScale(1,0.0,BulletBone);
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipIn()
{
	local int AmmoNeeded;

	if (ReloadState == RS_None)
		return;
	ReloadState = RS_PostClipIn;
	PlayOwnedSound(ClipInSound.Sound,ClipInSound.Slot,ClipInSound.Volume,ClipInSound.bNoOverride,ClipInSound.Radius,ClipInSound.Pitch,ClipInSound.bAtten);
	if (level.NetMode != NM_Client)
	{
		AmmoNeeded = default.MagAmmo-MagAmmo;
		if (AmmoNeeded > Ammo[0].AmmoAmount)
			MagAmmo+=Ammo[0].AmmoAmount;
		else
			MagAmmo = default.MagAmmo;
		Ammo[0].UseAmmo (AmmoNeeded, True);
	}
	UpdateScreen();
}

///==============================================================
/// Infa Red Scope View
///==============================================================

simulated function OnScopeViewChanged()
{
	super.OnScopeViewChanged();
		
	if (!bScopeView)
	{
		if (Level.NetMode == NM_Client)
			AdjustThermalView(false);
		else ServerAdjustThermal(false);
	}
	else if (bThermal)
	{
		if (Level.NetMode == NM_Client)
			AdjustThermalView(true);
		else ServerAdjustThermal(true);
	}	
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (Instigator != None && AIController(Instigator.Controller) == None) //Player Screen ON
	{
		ScreenStart();
		if (!Instigator.IsLocallyControlled())
			ClientScreenStart();
	}
	
	super.BringUp(PrevWeapon);
	if (ColorMod != None)
		return;
	ColorMod = ColorModifier(Level.ObjectPool.AllocateObject(class'ColorModifier'));
	if ( ColorMod != None )
	{
		ColorMod.Material = FinalBlend'BallisticEffects.M75.OrangeFinal';
		ColorMod.Color.R = 255;
		ColorMod.Color.G = 255;
		ColorMod.Color.B = 255;
		ColorMod.Color.A = 255;
		ColorMod.AlphaBlend = false;
		ColorMod.RenderTwoSided=True;
	}
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		if (Level.NetMode == NM_Client)
			AdjustThermalView(false);
		else ServerAdjustThermal(false);

		return true;
	}
	return false;
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (ClientState != WS_ReadyToFire || ReloadState != RS_None)
		return;
		
	bThermal = !bThermal;
	if (bThermal)
	{
    	class'BUtil'.static.PlayFullSound(self, ThermalOnSound);
    	ServerWeaponSpecial(1);
    }
	else
	{
    	class'BUtil'.static.PlayFullSound(self, ThermalOffSound);
    	ServerWeaponSpecial(0);
    }
    
    AdjustThermalView(bThermal);
}

function ServerWeaponSpecial(optional byte i)
{
	bThermal = bool(i);
	ServerAdjustThermal(bThermal);
}

simulated function AdjustThermalView(bool bNewValue)
{
	if (AIController(Instigator.Controller) != None)
		return;
	if (!bNewValue)
	{
		bUpdatePawns = false;
	}
	else
	{
		bUpdatePawns = true;
		UpdatePawnList();
		NextPawnListUpdateTime = Level.TimeSeconds + 1;
	}
}

function ServerAdjustThermal(bool bNewValue)
{
	local int i;
	
	if (bNewValue)
	{
		bUpdatePawns = true;
		UpdatePawnList();
		NextPawnListUpdateTime = Level.TimeSeconds + 1;
	}
	else
	{
		bUpdatePawns = false;
		for (i=0;i<ArrayCount(UpdatedPawns);i++)
		{
			if (UpdatedPawns[i] != None)
				UpdatedPawns[i].bAlwaysRelevant = false;
		}
	}
}

//Moved here because Timer broke the weapon
simulated function WeaponTick (float DeltaTime)
{
	local actor T;
	local vector HitLoc, HitNorm, Start, End;

	Super.WeaponTick(DeltaTime);

	if (Level.TimeSeconds >= NextPawnListUpdateTime)
		UpdatePawnList();

	if (!Instigator.IsLocallyControlled())
		return;

	if (bThermal && bScopeView)
	{
		SetNVLight(true);

		Start = Instigator.Location+Instigator.EyePosition();
		End = Start+vector(Instigator.GetViewRotation())*1500;
		T = Trace(HitLoc, HitNorm, End, Start, true, vect(16,16,16));
		if (T==None)
			HitLoc = End;

		if (VSize(HitLoc-Start) > 400)
			NVLight.SetLocation(Start + (HitLoc-Start)*0.5);
		else
			NVLight.SetLocation(HitLoc + HitNorm*30);
	}
	else
		SetNVLight(false);

}


simulated event RenderOverlays (Canvas C)
{
	local Vector X, Y, Z;
	if (CurrentWeaponMode == 0)
	{
		if (MagAmmo == 0)
			ScreenBaseX=ScreenBase4;
		else
			ScreenBaseX=ScreenBase2;
	}
	else
	{
		if (MagAmmo == 0)
			ScreenBaseX=ScreenBase3;
		else
			ScreenBaseX=ScreenBase1;
	}
	
	NumpadYOffset1=(5+(MagAmmo/10)*49);
	NumpadYOffset2=(5+(MagAmmo%10)*49);


	if (Instigator.IsLocallyControlled())
	{
		WeaponScreen.Revision++;
	}

	if (!bScopeView)
	{
		Super.RenderOverlays(C);
		if (SightFX != None)
			RenderSightFX(C);
		return;
	}
	
	C.ColorModulate.W = 1;
	if (bThermal)
	{
		DrawThermalMode(C);
	}
	if (!bNoMeshInScope)
	{
		Super.RenderOverlays(C);
		if (SightFX != None)
			RenderSightFX(C);
	}
	else
	{
		GetViewAxes(X, Y, Z);
		if (BFireMode[0].MuzzleFlash != None)
		{
			BFireMode[0].MuzzleFlash.SetLocation(Instigator.Location + Instigator.EyePosition() + X * SMuzzleFlashOffset.X + Z * SMuzzleFlashOffset.Z);
			BFireMode[0].MuzzleFlash.SetRotation(Instigator.GetViewRotation());
			C.DrawActor(BFireMode[0].MuzzleFlash, false, false, DisplayFOV);
		}
		if (BFireMode[1].MuzzleFlash != None)
		{
			BFireMode[1].MuzzleFlash.SetLocation(Instigator.Location + Instigator.EyePosition() + X * SMuzzleFlashOffset.X + Z * SMuzzleFlashOffset.Z);
			BFireMode[1].MuzzleFlash.SetRotation(Instigator.GetViewRotation());
			C.DrawActor(BFireMode[1].MuzzleFlash, false, false, DisplayFOV);
		}
		SetLocation(Instigator.Location + Instigator.CalcDrawOffset(self));
		SetRotation(Instigator.GetViewRotation());
	}

	C.SetDrawColor(255,255,255,255);
	C.SetPos(C.OrgX, C.OrgY);
	C.Style = ERenderStyle.STY_Alpha;

	if (bThermal)
	{
    		C.DrawTile(ScopeViewTexThermal, (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1024);

        	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
        	C.DrawTile(ScopeViewTexThermal, C.SizeY, C.SizeY, 0, 0, 1024, 1024);

        	C.SetPos(C.SizeX - (C.SizeX - C.SizeY)/2, C.OrgY);
        	C.DrawTile(ScopeViewTexThermal, (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1024);
	}
	else
    	{

    		C.DrawTile(ScopeViewTex, (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1024);

        	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
        	C.DrawTile(ScopeViewTex, C.SizeY, C.SizeY, 0, 0, 1024, 1024);

        	C.SetPos(C.SizeX - (C.SizeX - C.SizeY)/2, C.OrgY);
        	C.DrawTile(ScopeViewTex, (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1024);
		
	}

}


simulated function UpdatePawnList()
{
	local Pawn P;
	local int i;
	local float Dist;

	PawnList.Length=0;
	ForEach DynamicActors( class 'Pawn', P)
	{
		PawnList[PawnList.length] = P;
		Dist = VSize(P.Location - Instigator.Location);
		if (Dist <= ThermalRange &&
			( Normal(P.Location-(Instigator.Location+Instigator.EyePosition())) Dot Vector(Instigator.GetViewRotation()) > 1-((Instigator.Controller.FovAngle*0.9)/180) ) &&
			((Instigator.LineOfSightTo(P)) || Normal(P.Location - Instigator.Location) Dot Vector(Instigator.GetViewRotation()) > 0.985 + 0.015 * (Dist/ThermalRange)))
		{
			if (!Instigator.IsLocallyControlled())
			{
				P.NetUpdateTime = Level.TimeSeconds - 1;
				P.bAlwaysRelevant = true;
			}
			UpdatedPawns[i]=P;
			i++;
		}
	}
}


// Draws players through walls and all the other Thermal Mode stuff
simulated event DrawThermalMode (Canvas C)
{
	local Pawn P;
	local int i, j;
	local float Dist, DotP, ImageScaleRatio;//, OtherRatio;
	local Array<Material>	OldSkins;
	local int OldSkinCount;
	local bool bLOS, bFocused;
	local vector Start;
	local Array<Material>	AttOldSkins0;
	local Array<Material>	AttOldSkins1;

	ImageScaleRatio = 1.3333333;

	C.Style = ERenderStyle.STY_Modulated;
	// Draw Spinning Sweeper thing
	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
	C.SetDrawColor(255,255,255,255);
	C.DrawTile(FinalBlend'BallisticRecolors3TexPro.FSG50.FSGIRFinal', C.SizeY, C.SizeY, 0, 0, 1024, 1024);
	// Draw some panning lines 
	C.SetPos(C.OrgX, C.OrgY);
	C.DrawTile(FinalBlend'BallisticRecolors3TexPro.SKAR.SKAR-StaticFinal', C.SizeX, C.SizeY, 0, 0, 512, 512); 

	if (ColorMod == None)
		return;
	// Draw the players with an orange effect
	C.Style = ERenderStyle.STY_Alpha;
	Start = Instigator.Location + Instigator.EyePosition();
	for (j=0;j<PawnList.length;j++)
	{
		if (PawnList[j] != None && PawnList[j] != Level.GetLocalPlayerController().Pawn)
		{
			P = PawnList[j];
			bFocused=false;
			bLos=false;
			ThermalRange = default.ThermalRange + 2000 * FMin(1, VSize(P.Velocity) / 450);
			Dist = VSize(P.Location - Instigator.Location);
			if (Dist > ThermalRange)
				continue;
			DotP = Normal(P.Location - Start) Dot Vector(Instigator.GetViewRotation());
			if ( DotP < Cos((Instigator.Controller.FovAngle/1.7) * 0.017453) )
				continue;
			// If we have a clear LOS then they can be drawn
			if (Instigator.LineOfSightTo(P))
				bLOS=true;
			if (bLOS)
			{
				DotP = (DotP-0.6) / 0.4;

				DotP = FMax(DotP, 0);

				if (Dist < 500)
					ColorMod.Color.R = DotP * 255.0;
				else
					ColorMod.Color.R = DotP * ( 255 - FClamp((Dist-500)/((ThermalRange-500)*0.8), 0, 1) * 255 );

				// Remember old skins, set new skins, turn on unlit...
				OldSkinCount = P.Skins.length;
				for (i=0;i<Max(2, OldSkinCount);i++)
				{	if (OldSkinCount > i) OldSkins[i] = P.Skins[i]; else OldSkins[i]=None;	P.Skins[i] = ColorMod;	}
				P.bUnlit=true;

				for (i=0;i<P.Attached.length;i++)
					if (P.Attached[i] != None)
					{
						if (Pawn(P.Attached[i]) != None || ONSWeapon(P.Attached[i]) != None/* || InventoryAttachment(P.Attached[i])!= None*/)
						{
							if (P.Attached[i].Skins.length > 0)
							{	AttOldSkins0[i] = P.Attached[i].Skins[0];	P.Attached[i].Skins[0] = ColorMod;	}
							else
							{	AttOldSkins0[i] = None;	P.Attached[i].Skins[0] = ColorMod;	}
							if (P.Attached[i].Skins.length > 1)
							{	AttOldSkins1[i] = P.Attached[i].Skins[1];	P.Attached[i].Skins[1] = ColorMod;	}
							if (P.Attached[i].Skins.length > 1)
							{	AttOldSkins1[i] = None;	P.Attached[i].Skins[1] = ColorMod;	}
						}
						else
							P.Attached[i].SetDrawType(DT_None);
					}

				C.DrawActor(P, false, true);

				// Set old skins back, Unlit off
				P.Skins.length = OldSkinCount;
				for (i=0;i<P.Skins.length;i++)
					P.Skins[i] = OldSkins[i];
				P.bUnlit=false;

				for (i=0;i<P.Attached.length;i++)
					if (P.Attached[i] != None)
					{
						if (Pawn(P.Attached[i]) != None || ONSWeapon(P.Attached[i]) != None/* || InventoryAttachment(P.Attached[i])!= None*/)
						{
							if (AttOldSkins1[i] == None)
							{
								if (AttOldSkins0[i] == None)
									P.Attached[i].Skins.length = 0;
								else
								{
									P.Attached[i].Skins.length = 1;
									P.Attached[i].Skins[0] = AttOldSkins0[i];
								}
							}
							else
							{
								P.Attached[i].Skins[0] = AttOldSkins0[i];
								P.Attached[i].Skins[1] = AttOldSkins1[i];
							}
						}
						else
							P.Attached[i].SetDrawType(P.Attached[i].default.DrawType);
					}
				AttOldSkins0.length = 0;
				AttOldSkins1.length = 0;
			}
			else
				continue;
		}
	}
}

simulated function SetNVLight(bool bOn)
{
	if (!Instigator.IsLocallyControlled())
		return;
	if (bOn)
	{
		if (NVLight == None)
		{
			NVLight = Spawn(class'HKARNVLight',,,Instigator.location);
			NVLight.SetBase(Instigator);
		}
		NVLight.bDynamicLight = true;
	}
	else if (NVLight != None)
		NVLight.bDynamicLight = false;
}

///================================================
///
///================================================

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_50IncMag';
}


simulated function bool HasAmmo()
{
	//First Check the magazine
	if (FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}



// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (B.Skill > Rand(6))
	{
		if (AimComponent.GetChaos() < 0.1 || AimComponent.GetChaos() < 0.5 && VSize(B.Enemy.Location - Instigator.Location) > 500)
			return 1;
	}
	else if (FRand() > 0.75)
		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.5, Dist, 2048, 3072); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.7;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.7;	}

defaultproperties
{
	ScopeBone="Scope"
	BulletBone="Bullet"
	ThermalOnSound=(Sound=Sound'BallisticSounds2.M75.M75ThermalOn',Volume=0.500000,Pitch=1.000000)
	ThermalOffSound=(Sound=Sound'BallisticSounds2.M75.M75ThermalOff',Volume=0.500000,Pitch=1.000000)
	WallVisionSkin=FinalBlend'BallisticEffects.M75.OrangeFinal'
	Flaretex=FinalBlend'BallisticEffects.M75.OrangeFlareFinal'
	ThermalRange=4500.000000
	ScopeViewTexThermal=Texture'BallisticRecolors3TexPro.FSG50.FSG-ScopeViewThermal'
	WeaponScreen=ScriptedTexture'BallisticRecolors3TexPro.FSG50.FSG50-ScriptLCD'
	screen=Shader'BallisticRecolors3TexPro.FSG50.FSG50-ScriptLCD-SD'
	ScreenBase1=Texture'BallisticRecolors3TexPro.FG50.FG50-Screen'
	ScreenBase2=Texture'BallisticRecolors3TexPro.FG50.FG50-Screen2'
	ScreenBase3=Texture'BallisticRecolors3TexPro.FG50.FG50-Screen3'
	ScreenBase4=Texture'BallisticRecolors3TexPro.FG50.FG50-Screen4'
	Numbers=Texture'BallisticRecolors3TexPro.PUMA.PUMA-Numbers'
	MyFontColor=(B=255,G=255,R=255,A=255)
	PlayerSpeedFactor=0.850000
	PlayerJumpFactor=0.850000
	TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BallisticRecolors3TexPro.FSG50.BigIcon_FSG50'
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	ManualLines(0)="Semi-automatic .50 cal fire. Extremely unpredictable recoil, but good damage per shot and excellent theoretical sustained damage output."
	ManualLines(1)="Incendiary shot. Deals moderate damage and ignites struck targets, causing them to burn brightly, emit smoke, suffer view flash and take damage over time. Further hits extend the duration of this effect."
	ManualLines(2)="The Weapon Function key toggles the IR component of the weapon's scope. This is useful for highlighting enemies through environmental features like water or trees, or through smoke.||The FSSG-50 is heavy and burdens the player, reducing movement speed and jump height. It takes time to aim.||The FSSG-50 is effective at long range."
	SpecialInfo(0)=(Info="360.0;35.0;1.0;90.0;10.0;0.0;0.1")
	BringUpSound=(Sound=Sound'BWBP4-Sounds.MRL.MRL-BigOn')
	PutDownSound=(Sound=Sound'BWBP4-Sounds.MRL.MRL-BigOff')
	MagAmmo=8
	CockAnimPostReload="Cock"
	CockAnimRate=1.350000
	CockSound=(Sound=Sound'PackageSounds4Pro.AS50.FG50-Cock',Volume=2.500000,Radius=32.000000)
	ReloadAnimRate=1.250000
	ClipOutSound=(Sound=Sound'PackageSounds4Pro.AS50.FG50-MagOut',Volume=1.500000,Radius=32.000000)
	ClipInSound=(Sound=Sound'PackageSounds4Pro.AS50.FG50-MagIn',Volume=1.500000,Radius=32.000000)
	ClipInFrame=0.850000
	bCockOnEmpty=True
	bAltTriggerReload=True
	WeaponModes(1)=(bUnavailable=True)
	CurrentWeaponMode=0
	ZoomType=ZT_Logarithmic
	ScopeViewTex=Texture'BallisticRecolors3TexPro.FSG50.FSG-ScopeView'
	ZoomInSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	FullZoomFOV=15.000000
	bNoMeshInScope=True
	bNoCrosshairInScope=True
	SightOffset=(X=-5.000000,Y=25.000000,Z=10.300000)
	SightingTime=0.650000
	MinZoom=4.000000
	MaxZoom=16.000000
	ZoomStages=2
	GunLength=80.000000

	Begin Object Class=RecoilParams Name=FSSG50RecoilParams
		ViewBindFactor=0.15
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.500000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.350000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.15
		YRandFactor=0.15
		MinRandFactor=0.15
		DeclineTime=1.500000
		DeclineDelay=0.500000
		CrouchMultiplier=0.650000
	End Object
	RecoilParamsList(0)=RecoilParams'FSSG50RecoilParams'

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=1024)
		ADSMultiplier=0.15
		SprintOffset=(Pitch=-3000,Yaw=-4096)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		AimAdjustTime=0.600000
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=350.000000
	End Object
	AimParamsList(0)=AimParams'ArenaAimParams'
	 
	FireModeClass(0)=Class'BWBPRecolorsPro.AS50PrimaryFire'
	FireModeClass(1)=Class'BWBPRecolorsPro.AS50SecondaryFire'
	IdleAnimRate=0.600000
	PutDownTime=0.600000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.80000
	CurrentRating=0.800000
	bSniping=True
	Description="[ Fallschirmj�gerscharfsch�tzengewehr] FSsG-50 is the name given to high-performance FG50 machineguns that are then equipped with match-grade barrels and high-quality custom marksman stocks. FG-50s with exceptional target groupings and perfect reliability ratings are the primary candidates for the FSsG upgrade, though some production plants with extremely tight tolerances and quality control specifically produce the FSsG variant. The result is a very accurate sniper rifle with a muzzle velocity far higher than its standard cousin. These elite rifles are very rarely mounted on vehicle platforms and are often utilized by sharpshooters equipped with enhanced scopes and match-grade N6-BMG rounds for hard target interdiction. This FSSG-50 is firing the mass produced N1-Incendiary round and has an Aeris Mark 2 Suresight scope attached."
	DisplayFOV=55.000000
	Priority=207
	HudColor=(G=50)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=9
	PickupClass=Class'BWBPRecolorsPro.AS50Pickup'
	PlayerViewOffset=(X=5.000000,Y=-7.000000,Z=-8.000000)
	BobDamping=1.800000
	AttachmentClass=Class'BWBPRecolorsPro.AS50Attachment'
	IconMaterial=Texture'BallisticRecolors3TexPro.FSG50.SmallIcon_FSG50'
	IconCoords=(X2=127,Y2=31)
	ItemName="FSSG-50 Marksman Rifle"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=5.000000
	Mesh=SkeletalMesh'BallisticRecolors4AnimPro.FSG-50_FP'
	DrawScale=0.500000
	Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	Skins(1)=Texture'BallisticRecolors3TexPro.FSG50.FSG-Main'
	Skins(2)=Texture'BallisticRecolors3TexPro.FSG50.FSG-Misc'
	Skins(3)=Texture'BallisticRecolors3TexPro.FSG50.FSG-Stock'
	Skins(4)=Texture'BallisticRecolors3TexPro.FSG50.FSG-Scope'
	Skins(5)=Texture'BallisticRecolors3TexPro.FG50.FG50-Screen'
}
