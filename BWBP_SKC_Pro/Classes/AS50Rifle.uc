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

simulated event PreBeginPlay()
{
	super.PreBeginPlay();
	if (class'BallisticReplicationInfo'.static.IsClassic())
	{
		FireModeClass[0]=Class'BWBP_SKC_Pro.AS50SecondaryFire';
		FireModeClass[1]=Class'BCoreProV55.BallisticScopeFire';
	}
	if (class'BallisticReplicationInfo'.static.IsRealism())
	{
		FireModeClass[0]=Class'BWBP_SKC_Pro.AS50SecondaryFire';
		FireModeClass[1]=Class'BWBP_SKC_Pro.AS50DeployFire';
	}
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

function Notify_Deploy()
{
	local vector HitLoc, HitNorm, Start, End;
	local actor T;
	local Rotator CompressedEq;
    local BallisticTurret Turret;
    local float Forward;

	if (Role < ROLE_Authority)
		return;
	if (Instigator.HeadVolume.bWaterVolume)
		return;
	// Trace forward and then down. make sure turret is being deployed:
	//   on world geometry, at least 30 units away, on level ground, not on the other side of an obstacle
	Start = Instigator.Location + Instigator.EyePosition();
	for (Forward=75;Forward>=45;Forward-=15)
	{
		End = Start + vector(Instigator.Rotation) * Forward;
		T = Trace(HitLoc, HitNorm, End, Start, true, vect(6,6,6));
		if (T != None && VSize(HitLoc - Start) < 30)
			return;
		if (T == None)
			HitLoc = End;
		End = HitLoc - vect(0,0,100);
		T = Trace(HitLoc, HitNorm, End, HitLoc, true, vect(6,6,6));
		if (T != None && HitLoc.Z <= Start.Z - class'BallisticTurret'.default.MinTurretEyeDepth - 4 && (T.bWorldGeometry && (Sandbag(T) == None || Sandbag(T).AttachedWeapon == None)) && HitNorm.Z >= 0.9 && FastTrace(HitLoc, Start))
			break;
		if (Forward <= 45)
			return;
	}

	FireMode[1].bIsFiring = false;
   	FireMode[1].StopFiring();

	if(Sandbag(T) != None)
	{
		HitLoc = T.Location;
		HitLoc.Z += class'AS50Turret'.default.CollisionHeight + T.CollisionHeight  * 0.75;
	}
	
	else
	{
		HitLoc.Z += class'AS50Turret'.default.CollisionHeight - 9;
	}

	CompressedEq = Instigator.Rotation;
		
	//Rotator compression causes disparity between server and client rotations,
	//which then plays hob with the turret's aim.
	//Do the compression first then use that to spawn the turret.
	
	CompressedEq.Pitch = (CompressedEq.Pitch >> 8) & 255;
	CompressedEq.Yaw = (CompressedEq.Yaw >> 8) & 255;
	CompressedEq.Pitch = (CompressedEq.Pitch << 8);
	CompressedEq.Yaw = (CompressedEq.Yaw << 8);

    Turret = Spawn(class'AS50Turret', None,, HitLoc, Instigator.Rotation);

    if (Turret != None)
    {
    	if (Sandbag(T) != None)
			Sandbag(T).AttachedWeapon = Turret;
		Turret.InitDeployedTurretFor(self);
		Turret.TryToDrive(Instigator);
		Destroy();
    }
    else
		log("Notify_Deploy: Could not spawn turret for AS50 AMR.");
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
		ColorMod.Material = Texture'Engine.MenuWhite';
		ColorMod.Color.R = 255;
		ColorMod.Color.G = 0;
		ColorMod.Color.B = 0;
		ColorMod.Color.A = 0;
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
				UpdatedPawns[i].bAlwaysRelevant = UpdatedPawns[i].default.bAlwaysRelevant;
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

simulated final function SetScreenMode()
{
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
}

simulated function RenderOverlays(Canvas C)
{
    SetScreenMode();

	Super.RenderOverlays(C);
}

simulated function DrawScopeOverlays(Canvas C)
{
	if (bThermal)
	{
		DrawThermalMode(C);
        ScopeViewTex = ScopeViewTexThermal;
	}
    else 
	{
        ScopeViewTex = default.ScopeViewTex;
	}

	Super.DrawScopeOverlays(C);
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
	local Pawn              P;
	local int               i, j;
	local float             Dist, DotP;
	local Array<Material>	OldSkins;
	local int               OldSkinCount;
	local bool              bFocused;
	local vector            Start;
	local Array<Material>	AttOldSkins0;
	local Array<Material>	AttOldSkins1;

	C.ColorModulate.W = 1;

	C.Style = ERenderStyle.STY_Modulated;

	// Draw Spinning Sweeper thing
	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
	C.SetDrawColor(255,255,255,255);
	C.DrawTile(FinalBlend'BWBP_SKC_Tex.FSG50.FSGIRFinal', C.SizeY, C.SizeY, 0, 0, 1024, 1024);
	// Draw some panning lines 
	C.SetPos(C.OrgX, C.OrgY);
	C.DrawTile(FinalBlend'BWBP_SKC_Tex.SKAR.SKAR-StaticFinal', C.SizeX, C.SizeY, 0, 0, 512, 512); 

	if (ColorMod == None)
		return;

	// Draw the players with a red effect
	C.Style = ERenderStyle.STY_Alpha;
	Start = Instigator.Location + Instigator.EyePosition();

	for (j=0;j<PawnList.length;j++)
	{
		if (PawnList[j] != None && PawnList[j] != Level.GetLocalPlayerController().Pawn)
		{
			P = PawnList[j];
			bFocused=false;

            // Check player in range
			ThermalRange = default.ThermalRange;

			Dist = VSize(P.Location - Instigator.Location);
			if (Dist > ThermalRange)
				continue;

            // Check appropriate angle
			DotP = Normal(P.Location - Start) Dot Vector(Instigator.GetViewRotation());
			if ( DotP < Cos((Instigator.Controller.FovAngle/1.7) * 0.25) )
				continue;

            // Check visibility to target
            if (!FastTrace(P.Location, Instigator.Location))
                continue;

            /*
            DotP = (DotP-0.6) / 0.4;

            DotP = FMax(DotP, 0);

            if (Dist < 500)
                ColorMod.Color.R = DotP * 255.0;
            else
                ColorMod.Color.R = DotP * ( 255 - FClamp((Dist-500)/((ThermalRange-500)*0.8), 0, 1) * 255 );
            */

            // Remember old skins, set new skins, turn on unlit...
            OldSkinCount = P.Skins.length;

            for (i=0;i<Max(2, OldSkinCount);i++)
            {	
                if (OldSkinCount > i) 
                    OldSkins[i] = P.Skins[i]; 
                else 
                    OldSkins[i]=None;	
                
                P.Skins[i] = ColorMod;	
            }
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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.75, Dist, 1024, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.7;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.7;	}

defaultproperties
{
	ScopeBone="Scope"
	BulletBone="Bullet"
	ThermalOnSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75ThermalOn',Volume=0.500000,Pitch=1.000000)
	ThermalOffSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75ThermalOff',Volume=0.500000,Pitch=1.000000)
	WallVisionSkin=FinalBlend'BW_Core_WeaponTex.M75.OrangeFinal'
	Flaretex=FinalBlend'BW_Core_WeaponTex.M75.OrangeFlareFinal'
	ThermalRange=9000.000000
	ScopeViewTexThermal=Texture'BWBP_SKC_Tex.FSG50.FSG-ScopeViewThermal'
	WeaponScreen=ScriptedTexture'BWBP_SKC_Tex.FSG50.FSG50-ScriptLCD'
	screen=Shader'BWBP_SKC_Tex.FSG50.FSG50-ScriptLCD-SD'
	ScreenBase1=Texture'BWBP_SKC_Tex.FG50.FG50-Screen'
	ScreenBase2=Texture'BWBP_SKC_Tex.FG50.FG50-Screen2'
	ScreenBase3=Texture'BWBP_SKC_Tex.FG50.FG50-Screen3'
	ScreenBase4=Texture'BWBP_SKC_Tex.FG50.FG50-Screen4'
	Numbers=Texture'BWBP_SKC_Tex.PUMA.PUMA-Numbers'
	MyFontColor=(B=255,G=255,R=255,A=255)
	MeleeFireClass=Class'BWBP_SKC_Pro.AS50MeleeFire'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BWBP_SKC_Tex.FSG50.BigIcon_FSG50'
	
	bWT_Bullet=True
	ManualLines(0)="Semi-automatic .50 cal fire. Extremely unpredictable recoil, but good damage per shot and excellent theoretical sustained damage output."
	ManualLines(1)="Incendiary shot. Deals moderate damage and ignites struck targets, causing them to burn brightly, emit smoke, suffer view flash and take damage over time. Further hits extend the duration of this effect."
	ManualLines(2)="The Weapon Function key toggles the IR component of the weapon's scope. This is useful for highlighting enemies through environmental features like water or trees, or through smoke.||The FSSG-50 is heavy and burdens the player, reducing movement speed and jump height. It takes time to aim.||The FSSG-50 is effective at long range."
	SpecialInfo(0)=(Info="360.0;35.0;1.0;90.0;10.0;0.0;0.1")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.MRL.MRL-BigOn',Volume=0.210000)
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.MRL.MRL-BigOff',Volume=0.215000)
	MagAmmo=8
	CockAnimPostReload="Cock"
	CockSound=(Sound=Sound'BWBP_SKC_Sounds.AS50.FG50-Cock',Volume=2.500000,Radius=32.000000)
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.AS50.FG50-MagOut',Volume=1.500000,Radius=32.000000)
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.AS50.FG50-MagIn',Volume=1.500000,Radius=32.000000)
	ClipInFrame=0.850000
	bCockOnEmpty=True
	bAltTriggerReload=True
	WeaponModes(1)=(bUnavailable=True)
	CurrentWeaponMode=0
	ScopeViewTex=Texture'BWBP_SKC_Tex.FSG50.FSG-ScopeView'
	ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	FullZoomFOV=15.000000
	bNoCrosshairInScope=True
	MinZoom=4.000000
	MaxZoom=16.000000
	ZoomStages=2
	GunLength=80.000000
	ParamsClasses(0)=Class'AS50WeaponParamsComp'	 
	ParamsClasses(1)=Class'AS50WeaponParamsClassic'	 
	ParamsClasses(2)=Class'AS50WeaponParamsRealistic'	 
    ParamsClasses(3)=Class'AS50WeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_SKC_Pro.AS50PrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.AS50SecondaryFire'
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Cross4',pic2=Texture'BW_Core_WeaponTex.Crosshairs.M353OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=0,G=255,R=0,A=153),Color2=(B=0,G=0,R=0,A=255),StartSize1=22,StartSize2=61)
    IdleAnimRate=0.600000
	PutDownTime=0.600000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.80000
	CurrentRating=0.800000
	bSniping=True
	Description="[ Fallschirmjägerscharfschútzengewehr] FSsG-50 is the name given to high-performance FG50 machineguns that are then equipped with match-grade barrels and high-quality custom marksman stocks. FG-50s with exceptional target groupings and perfect reliability ratings are the primary candidates for the FSsG upgrade, though some production plants with extremely tight tolerances and quality control specifically produce the FSsG variant. The result is a very accurate sniper rifle with a muzzle velocity far higher than its standard cousin. These elite rifles are very rarely mounted on vehicle platforms and are often utilized by sharpshooters equipped with enhanced scopes and match-grade N6-BMG rounds for hard target interdiction. This FSSG-50 is firing the mass produced N1-Incendiary round and has an Aeris Mark 2 Suresight scope attached."
	Priority=207
	HudColor=(G=50)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=9
	PickupClass=Class'BWBP_SKC_Pro.AS50Pickup'

	PlayerViewOffset=(X=4.00,Y=4.00,Z=-5.00)
	SightOffset=(X=3.00,Y=0.00,Z=3.70)

	AttachmentClass=Class'BWBP_SKC_Pro.AS50Attachment'
	IconMaterial=Texture'BWBP_SKC_Tex.FSG50.SmallIcon_FSG50'
	IconCoords=(X2=127,Y2=31)
	ItemName="FSSG-50 Marksman Rifle"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=5.000000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FSSG-50_FPm'
	DrawScale=0.300000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Texture'BWBP_SKC_Tex.FSG50.FSG-Main'
	Skins(2)=Texture'BWBP_SKC_Tex.FSG50.FSG-Misc'
	Skins(3)=Texture'BWBP_SKC_Tex.FSG50.FSG-Stock'
	Skins(4)=Texture'BWBP_SKC_Tex.FSG50.FSG-Scope'
	Skins(5)=Texture'BWBP_SKC_Tex.FG50.FG50-Screen'
}
