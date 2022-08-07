//=============================================================================
// XM20Carbine.
//
// Automatic laser rifle with low recoil and good control.
// Secondary fire is a chargeable laser. Can be charged at low or high power
// Has a good mid-range scope
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
// Modified by Marc 'Sergeant Kelly' Moylan
// Scope code by Kaboodles
//=============================================================================
class XM20BCarbine extends BallisticWeapon;


var float		HeatLevel;			// Current Heat level, duh...
var() Sound		DoubleVentSound;	//Sound for double fire's vent
var() Sound		OverHeatSound;		// Sound to play when it overheats

var float		lastModeChangeTime;

var() Sound			ModeCycleSound;

//Screen vars
var	int	NumpadYOffset1; //Ammo tens
var	int	NumpadYOffset2; //Ammo ones
var	int	NumpadYOffset3; //Reserve Ammo hundreds
var	int	NumpadYOffset4; //Reserve Ammo tens
var	int	NumpadYOffset5; //Reserve Ammo ones
var int NumpadXPosOnes; //X location reserve ammo ones
var int NumpadXPosTens; //X location reserve ammo tens
var int NumpadXScaleHunreds; //Used to hide sub 100 reserve digits

var() ScriptedTexture WeaponScreen; //Scripted texture to write on
var() Material	WeaponScreenShader; //Scripted Texture with self illum applied
var() Material	ScreenTex; //holding var for RenderOverlays
var() Material	ScreenTexBase1; //Norm
var() Material	ScreenTexBase2; //Overcharged
var() Material	ScreenRedBar; //Red crap for the heat bar
var() Material	Numbers;
var protected const color MyFontColor; //If you forget to set this you get a black screen! RIP a couple hours of my life

//Effects
var actor HeatSteam;
var actor VentCore;
var actor VentBarrel;
var actor CoverGlow;
var Actor	Glow1;				// Laser charge effect

//Laser junk
var   bool			bLaserOn;
var   LaserActor	Laser;
var   Emitter		LaserBlast;
var   Emitter		LaserDot;
var   bool			bBigLaser;
var   bool			bIsCharging;
var   bool 			bOvercharged;
var   float ChargeRate, ChargeRateOvercharge;
var()     float Heat, CoolRate;

var float X1, X2, X3, X4, Y1, Y2, Y3, Y4;

replication
{
	reliable if (Role == ROLE_Authority)
		ClientSetHeat, ClientScreenStart, bLaserOn, bOvercharged, ChargeRate, ChargeRateOvercharge;
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
	Skins[1] = WeaponScreenShader; //Set up scripted texture.
	UpdateScreen();//Give it some numbers n shit
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Revision++;
}

simulated event RenderTexture( ScriptedTexture Tex )
{
	local float rLaserCharge;
	rLaserCharge = 512*XM20BSecondaryFire(FireMode[1]).LaserCharge;
	
	//Quick Note: X1,Y1 are start pos, X2,Y2 are size, X3,Y4 are subtexture start, X4,Y4 are subtexture size
	Tex.DrawTile(0,0,512,512,0,0,512,512,ScreenTex, MyFontColor); //Basic Screen

//	Tex.DrawTile(X1,Y1,X2,Y2,X3,Y3,X4,Y4,ScreenRedBar, MyFontColor);
	Tex.DrawTile(0,512-rLaserCharge,512,rLaserCharge,0,512-rLaserCharge,512,rLaserCharge,ScreenRedBar, MyFontColor); //Charge Bar

	if (!bNoMag)
	{
		Tex.DrawTile(80,65,250,250,45,NumpadYOffset1,50,50,Numbers, MyFontColor); //Ammo
		Tex.DrawTile(220,65,250,250,45,NumpadYOffset2,50,50,Numbers, MyFontColor);
	}
	Tex.DrawTile(140,300,NumpadXScaleHunreds,120,45,NumpadYOffset3,50,50,Numbers, MyFontColor); //Reserve Ammo
	Tex.DrawTile(NumpadXPosTens,300,120,120,45,NumpadYOffset4,50,50,Numbers, MyFontColor);
	Tex.DrawTile(NumpadXPosOnes,300,120,120,45,NumpadYOffset5,50,50,Numbers, MyFontColor);
	
}
	
simulated function UpdateScreen()
{

	if (Instigator != None && AIController(Instigator.Controller) != None) //Bots cannot update your screen
		return;

	if (Instigator.IsLocallyControlled())
	{
			WeaponScreen.Revision++;
	}
}
	
// Consume ammo from one of the possible sources depending on various factors
simulated function bool ConsumeMagAmmo(int Mode, float Load, optional bool bAmountNeededIsMax)
{
	local bool bSuper;

	bSuper = super.ConsumeMagAmmo(Mode, Load, bAmountNeededIsMax);
	UpdateScreen();

	return bSuper;
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipIn()
{
	super.Notify_ClipIn();
	UpdateScreen();
}

//=====================================================================

//===========================================================================
// ManageHeatInteraction
//
// Called from primary fire when hitting a target. Objects don't like having iterators used within them
// and may crash servers otherwise.
//===========================================================================
function int ManageHeatInteraction(Pawn P, int HeatPerShot)
{
	local XM20BHeatManager HM;
	local int HeatBonus;
	
	foreach P.BasedActors(class'XM20BHeatManager', HM)
		break;
	if (HM == None)
	{
		HM = Spawn(class'XM20BHeatManager',P,,P.Location + vect(0,0,-30));
		HM.SetBase(P);
	}
	
	if (HM != None)
	{
		HeatBonus = HM.Heat;
		if (Vehicle(P) != None)
			HM.AddHeat(HeatPerShot/4);
		else HM.AddHeat(HeatPerShot);
	}
	
	return heatBonus;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	if (Instigator != None && AIController(Instigator.Controller) == None) //Player Screen ON
	{
		ScreenStart();
		if (!Instigator.IsLocallyControlled())
			ClientScreenStart();
	}
	
	if (Instigator != None && Laser == None && AIController(Instigator.Controller) == None)
	{
		Laser = Spawn(class'BWBP_SKC_Pro.LaserActor_XM20BRed');
	}
		
}

// Heat Junk
simulated event Tick (float DT)
{
	super.Tick(DT);
	if (FireMode[1].bIsFiring)
	{
		CoolRate = 0;
		bIsCharging = true;
	}
	else 
	{
		CoolRate = default.CoolRate;
		bIsCharging = false;
	}
    Heat = FMax(0, Heat - CoolRate*DT);

   	if (level.Netmode == NM_DedicatedServer)
		Heat = 0;

}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (Firemode[1].bIsFiring && MagAmmo != 0)
	{
		class'bUtil'.static.InitMuzzleFlash(Glow1, class'HMCBarrelGlowRed', DrawScale, self, 'tip');
		class'BUtil'.static.InitMuzzleFlash (CoverGlow, class'XM20BGlowFX', DrawScale, self, 'CoreGlowL');
	}
	else
	{
		if (Glow1 != None)	Glow1.Destroy();
		if (CoverGlow != None)	CoverGlow.Destroy();
	}
}

simulated function Overheat(float Amount)
{
	Heat += Amount;
	if (Heat > 1.0 && Heat < 1.2)
	{
		Heat = 1.4;
//		PlaySound(OverHeatSound,,6.7,,64);
	}
}

simulated function ClientSetHeat(float NewHeat)
{
	HeatLevel = NewHeat;
}

simulated function ServerSwitchWeaponMode (byte NewMode)
{
    if (Firemode[1].bIsFiring || Heat > 0)
        return;

	PlaySound(ModeCycleSound,,4.7,,32);
		
	super.ServerSwitchWeaponMode(NewMode);
	
	if (!Instigator.IsLocallyControlled())
		XM20BSecondaryFire(FireMode[1]).SwitchLaserMode(CurrentWeaponMode);

	ClientSwitchLaserMode (CurrentWeaponMode);
}

simulated function ClientSwitchLaserMode (byte newMode)
{
	XM20BSecondaryFire(FireMode[1]).SwitchLaserMode(newMode);
	if (newMode == 2)
	{
		bBigLaser=True;
		if (ThirdPersonActor != None)
			XM20BAttachment(ThirdPersonActor).bBigLaser=true;
	}
	else
	{
		bBigLaser=False;
		if (ThirdPersonActor != None)
			XM20BAttachment(ThirdPersonActor).bBigLaser=false;
	}	
	UpdateScreen();
}


// End Heat Junk
simulated function PlayIdle()
{
	super.PlayIdle();

	if (!bLaserOn || bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}



function ServerSwitchLaser(bool bNewLaserOn)
{
	if (bLaserOn == bNewLaserOn)
		return;
	bLaserOn = bNewLaserOn;
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
	if (ThirdPersonActor != None)
		XM20BAttachment(ThirdPersonActor).bLaserOn = bLaserOn;
    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
}

simulated function ClientSwitchLaser()
{
	if (!bLaserOn)
		KillLaserDot();
	PlayIdle();
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
}

simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.bHidden=false;
		LaserDot.Kill();
		LaserDot = None;
	}
}
simulated function SpawnLaserDot(vector Loc)
{
	if (LaserDot == None)
		LaserDot = Spawn(class'BWBP_SKC_Pro.IE_XM20BImpact',,,Loc);
}





simulated function bool PutDown()
{
	if (super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			XM20BAttachment(ThirdPersonActor).bLaserOn = false;
		if (Glow1 != None)	Glow1.Destroy();
		if (CoverGlow != None)	CoverGlow.Destroy();
	}
	return false;
}


simulated function Destroyed()
{
	if (Instigator != None && AIController(Instigator.Controller) == None)
		WeaponScreen.client=None;
	if (Glow1 != None)	Glow1.Destroy();
	if (CoverGlow != None)	CoverGlow.Destroy();
	if (Laser != None)	Laser.Destroy();
	if (LaserDot != None)	LaserDot.Destroy();
	super.Destroyed();
}

// Draw a laser beam and dot to show exact path of bullets before they're fired
simulated function DrawLaserSight ( Canvas Canvas )
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator AimDir;
	local Actor Other;
    local bool bAimAligned;

	if (ClientState == WS_Hidden || !bLaserOn)
		return;

	AimDir = BallisticFire(FireMode[0]).GetFireAim(Start);
	if (bScopeView)
		Loc = Instigator.Location + vect(0,0,1)*(Instigator.EyeHeight-8);
	else
		Loc = GetBoneCoords('tip').Origin;

	End = Start + Normal(Vector(AimDir))*3000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire)
		bAimAligned = true;

	if (bAimAligned && Other != None)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
	{
		LaserDot.SetLocation(HitLocation);
		LaserDot.SetRotation(rotator(HitNormal));
		LaserDot.Emitters[1].AutomaticInitialSpawning = Other.bWorldGeometry;
		LaserDot.Emitters[5].AutomaticInitialSpawning = Other.bWorldGeometry;
		Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);
	}

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = ConvertFOVs(End, Instigator.Controller.FovAngle, DisplayFOV, 400);
	if (bAimAligned)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('tip');
		Laser.SetRotation(AimDir);
	}

	Scale3D.X = VSize(HitLocation-Loc)/128;
	if (!bBigLaser)
	{
		Scale3D.Y = 4;
		Scale3D.Z = 4;
	}
	else
	{
		Scale3D.Y = 9;
		Scale3D.Z = 9;
	}
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}

simulated event RenderOverlays( Canvas C )
{
	local float	ScaleFactor;//, XL, XY;

	if (CurrentWeaponMode == 1)
	{
		ScreenTex=ScreenTexBase1;
	}
	else
	{
		ScreenTex=ScreenTexBase2;
	}
	
	NumpadYOffset1=(5+(MagAmmo/10)*49);
	NumpadYOffset2=(5+(MagAmmo%10)*49);
	
	NumpadYOffset3=(5+(Ammo[0].AmmoAmount/100)*49); //Hundreds place
	NumpadYOffset4=(5+(Ammo[0].AmmoAmount/10 % 10)*49);  //Tens place
	NumpadYOffset5=(5+((Ammo[0].AmmoAmount%100)%10)*49);  //Ones place
	if (Ammo[0].AmmoAmount >= 100 )
	{
		NumpadXScaleHunreds=120; //Show hundreds
		NumpadXPosTens=200; //Tens X coord
		NumpadXPosOnes=260; //Ones X coord
	}
	else
	{
		NumpadXScaleHunreds=0; //Hide hundreds
		NumpadXPosTens=170; //Tens X coord
		NumpadXPosOnes=230; //Ones X coord
	}

    if (!bScopeView)
	{
		if (Instigator.IsLocallyControlled())
		{
			WeaponScreen.Revision++;
		}
		super.RenderOverlays(C);
		if (!IsInState('Lowered'))
			DrawLaserSight(C);
		return;
	}

    SetLocation(Instigator.Location + Instigator.CalcDrawOffset(self));
	SetRotation(Instigator.GetViewRotation());
    ScaleFactor = C.ClipY / 1200;


    if (ScopeViewTex != None)
    {
        C.SetDrawColor(255,255,255,255);

        C.SetPos(C.OrgX, C.OrgY);
    	C.DrawTile(ScopeViewTex, (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1);

        C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
        C.DrawTile(ScopeViewTex, C.SizeY, C.SizeY, 0, 0, 1024, 1024);

        C.SetPos(C.SizeX - (C.SizeX - C.SizeY)/2, C.OrgY);
        C.DrawTile(ScopeViewTex, (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1);
	}
			DrawLaserSight(C);
}

simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
	return CurrentRating;
}
// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result, Height, Dist, VDot;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;
	else if (MagAmmo < 1)
		return 1;

	if (CurrentWeaponMode != 2)
		CurrentWeaponMode = 2;
	Dist = VSize(B.Enemy.Location - Instigator.Location);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;
	VDot = Normal(B.Enemy.Velocity) Dot Normal(Instigator.Location - B.Enemy.Location);

	Result = FRand()-0.3;
	// Too far for grenade
	if (Dist > 800)
		Result -= (Dist-800) / 2000;
	// Too close for grenade
	if (Dist < 500 &&  VDot > 0.3)
		result -= (500-Dist) / 1000;
	if (VSize(B.Enemy.Velocity) > 50)
	{
		// Straight lines
		if (Abs(VDot) > 0.8)
			Result += 0.1;
		// Enemy running away
		if (VDot < 0)
			Result -= 0.2;
		else
			Result += 0.2;
	}


	// Higher than enemy
//	if (Height < 0)
//		Result += 0.1;
	// Improve grenade acording to height, but temper using horizontal distance (bots really like grenades when right above you)
	Dist = VSize(B.Enemy.Location*vect(1,1,0) - Instigator.Location*vect(1,1,0));
	if (Height < -100)
		Result += Abs((Height/2) / Dist);

	if (Result > 0.5)
		return 1;
	return 0;
}


function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = Super.GetAIRating();
	if (Dist < 500)
		Result -= 1-Dist/500;
	else if (Dist < 3000)
		Result += (Dist-1000) / 2000;
	else
		Result = (Result + 0.66) - (Dist-3000) / 2500;

	return Result;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.8;	}
// End AI Stuff =====

simulated function float ChargeBar()
{
    return FMin(XM20BSecondaryFire(FireMode[1]).LaserCharge, XM20BSecondaryFire(FireMode[1]).MaxCharge);
    //return FMin((Heat + XM20BSecondaryFire(FireMode[1]).LaserCharge), 1);
}

defaultproperties
{
	 ChargeRate=2.400000
	 ChargeRateOvercharge=0.600000
	 MyFontColor=(R=255,G=255,B=255,A=255)
     WeaponScreen=ScriptedTexture'BWBP_SKC_Tex.XM20B.XM20-ScriptLCD'
     WeaponScreenShader=Shader'BWBP_SKC_Tex.XM20B.XM20-ScriptLCD-SD'
	 Numbers=Texture'BWBP_SKC_Tex.XM20B.XM20-Numbers'
	 ScreenTex=Texture'BWBP_SKC_Tex.XM20B.XM20-ScreenBase'
	 ScreenTexBase1=Texture'BWBP_SKC_Tex.XM20B.XM20-ScreenBase'
	 ScreenTexBase2=Texture'BWBP_SKC_Tex.XM20B.XM20-ScreenBaseCharged'
	 ScreenRedBar=Texture'BWBP_SKC_Tex.XM20B.XM20-DisplayBars'
	 
	 CoolRate=1.0
     ModeCycleSound=Sound'BWBP_SKC_Sounds.AH104.AH104-ModeCycle'
     PlayerSpeedFactor=1.100000
     PlayerJumpFactor=1.100000
     PutDownAnimRate=1.500000
     PutDownTime=1.000000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=0)
     BigIconMaterial=Texture'BWBP_SKC_Tex.XM20.BigIcon_XM20'
     InventoryGroup=5
	 GroupOffset=8
     bWT_Bullet=True
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Projectile=True
     bWT_Energy=True
     bNoCrosshairInScope=true;
     SpecialInfo(0)=(Info="240.0;15.0;1.1;90.0;1.0;0.0;0.3")
	 HudColor=(B=25,G=0,R=150)
     BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.XM20.XM20-Deploy')
     PutDownSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-Deselect')
     CockSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Cock')
     ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-ClipHit')
     ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-ClipOut')
     ClipInSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-ClipIn')
     ClipInFrame=0.650000
     bNeedCock=False
     WeaponModes(0)=(ModeName="Laser Beam",bUnavailable=True)
     WeaponModes(1)=(ModeName="Laser: Quick Charge",ModeID="WM_FullAuto")
     WeaponModes(2)=(ModeName="Laser: Overcharge",ModeID="WM_FullAuto")
	 CurrentWeaponMode=1
	 BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     ScopeViewTex=Texture'BWBP_SKC_Tex.XM20.XM20-ScopeView'
     ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
     ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
     FullZoomFOV=40.000000
     SightPivot=(Pitch=600)
     SightOffset=(X=-10.000000,Y=11.7500000,Z=22.500000)
	 ParamsClasses(0)=Class'XM20BWeaponParams'
	 ParamsClasses(1)=Class'XM20BWeaponParamsClassic'
	 ParamsClasses(2)=Class'XM20BWeaponParamsRealistic'
     FireModeClass(0)=Class'BWBP_SKC_Pro.XM20BPrimaryFire'
     FireModeClass(1)=Class'BWBP_SKC_Pro.XM20BSecondaryFire'
     BringUpTime=0.800000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     bSniping=True
     bShowChargingBar=True
     Description="XM-20 Laser Carbine||Manufacturer: UTC Defense Tech|Primary: Laser Blasts|Secondary: Laser Stream||The XM-20 is an experimental laser weapon that has been designed to bypass the Skrith shielding technology that rendered most UTC energy weapons obsolete. Unlike earlier designs, the XM20 emits variable wavelength photons from an automated phase splitter which rapidly pulses Skrith shields. Fields tests have shown it to be effective so far, and UTC command has ordered this weapon into widespread phase 2 testing. An advanced version of the LS14 laser controller has been installed into this weapon, allowing it to switch between laser pulses or a sustained laser beam. The high powered beam is known to turn Cryon ballistic armor to slag with relative ease!"
     Priority=194
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     PickupClass=Class'BWBP_SKC_Pro.XM20BPickup'
     PlayerViewOffset=(X=6.000000,Y=1.000000,Z=-15.000000)
     BobDamping=1.800000
     AttachmentClass=Class'BWBP_SKC_Pro.XM20BAttachment'
     IconMaterial=Texture'BWBP_SKC_Tex.XM20B.SmallIcon_XM20'
     IconCoords=(X2=127,Y2=31)
     ItemName="XM20 Laser Carbine"
	 MagAmmo=40
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_XM20'
     DrawScale=0.350000
     UsedAmbientSound=Sound'BWBP_SKC_Sounds.XM20.XM20-Idle'
     bFullVolume=True
     SoundVolume=255
     SoundRadius=256.000000
     Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
     //Skins(1)=Combiner'BWBP_SKC_Tex.M30A2.M30A2-GunScope'
     Skins(2)=Shader'BWBP_SKC_Tex.XM20B.XM20-Final'
     Skins(3)=Texture'BWBP_SKC_Tex.XM20B.XM20-Misc'
     Skins(4)=Texture'ONSstructureTextures.CoreGroup.Invisible' //The outermost one
}
