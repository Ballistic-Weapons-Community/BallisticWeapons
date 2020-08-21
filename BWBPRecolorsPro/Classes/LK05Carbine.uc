//=============================================================================
// LK05Carbine
//
// An accurate and controllable carbine that is absolutely tricked out.
// Has a holosight, laser, silencer, and flashlight!
//
// Uses sledgehammer rounds that slow down enemies. Comes with low ammo and low
// reserve ammo.
//
// Has less range and power than long barreled rifles.
// Has better accuracy and control than fellow long barrel rifles.
//
// by Sarge.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LK05Carbine extends BallisticWeapon;

var   byte		GearStatus;

var   bool		bLaserOn, bOldLaserOn;
var   LaserActor	Laser;
var() Sound		LaserOnSound;
var() Sound		LaserOffSound;
var   Emitter		LaserDot;
var() float			LaserAimSpread;

var   bool		bSilenced;				// Silencer on. Silenced
var() name		SilencerBone;			// Bone to use for hiding silencer
var() name		SilencerBone2;			// Bone to use for hiding silencer
var() sound		SilencerOnSound;		// Silencer stuck on sound
var() sound		SilencerOffSound;		//
var() name		SilencerOnAnim;			// Think hard about this one...
var() name		SilencerOffAnim;		//

var Projector		FlashLightProj;
var Emitter		FlashLightEmitter;
var bool		bLightsOn;
var bool		bFirstDraw;
var vector		TorchOffset;
var() Sound		TorchOnSound;
var() Sound		TorchOffSound;

var() name		ScopeBone;			// Bone to use for hiding scope


replication
{
	reliable if (Role < ROLE_Authority)
		ServerFlashLight, ServerSwitchSilencer;
	reliable if (Role == ROLE_Authority)
		bLaserOn;
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	//Do not use default to save postnetreceived shit
	if (bLaserOn != bOldLaserOn)
	{
		if (bLaserOn)
			AimAdjustTime = default.AimAdjustTime * 1.5;
		else
			AimAdjustTime = default.AimAdjustTime;
		bOldLaserOn = bLaserOn;
	}
	Super.PostNetReceive();
}

//=================================
//Silencer Code
//=================================

function ServerSwitchSilencer(bool bNewValue)
{
	if (!Instigator.IsLocallyControlled())
		LK05PrimaryFire(FireMode[0]).SwitchSilencerMode(bNewValue);

	LK05Attachment(ThirdPersonActor).bSilenced=bNewValue;	
	PlaySuppressorAttachment(bNewValue);
	bSilenced = bNewValue;
	BFireMode[0].bAISilent = bSilenced;
}

exec simulated function SwitchSilencer() 
{
	if (ReloadState != RS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;

	bSilenced = !bSilenced;
	ServerSwitchSilencer(bSilenced);
	PlaySuppressorAttachment(bSilenced);
	LK05PrimaryFire(FireMode[0]).SwitchSilencerMode(bSilenced);
	LK05Attachment(ThirdPersonActor).IAOverride(bSilenced);
}

simulated function PlaySuppressorAttachment(bool bSuppressed)
{
	if (Role == ROLE_Authority)
		bServerReloading=True;
	ReloadState = RS_GearSwitch;
	
	if (bSuppressed)
		PlayAnim(SilencerOnAnim);
	else
		PlayAnim(SilencerOffAnim);
}

simulated function Notify_SilencerOn()
{
	PlaySound(SilencerOnSound,,0.5);
}

simulated function Notify_SilencerOff()
{
	PlaySound(SilencerOffSound,,0.5);
	SetBoneScale (0, 0.0, SilencerBone);
	SetBoneScale (1, 1.0, SilencerBone2);
}

simulated function Notify_SilencerShow()
{
	SetBoneScale (0, 1.0, SilencerBone);
	SetBoneScale (1, 0.0, SilencerBone2);
}

simulated function PlayReload()
{
	super.PlayReload();

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}

//=================================
// Flashlight + Laser Code
//=================================
exec simulated function WeaponSpecial(optional byte i)
{
	GearStatus++;
	if (GearStatus > 4)
		GearStatus = 1;

	if (bool(GearStatus & 1))  //Flashlight
	{
		bLightsOn = !bLightsOn;
		ServerFlashLight(bLightsOn);
		if (bLightsOn)
		{
			PlaySound(TorchOnSound,,0.7,,32);
			if (FlashLightEmitter == None)
				FlashLightEmitter = Spawn(class'MRS138TorchEffect',self,,location);
			class'BallisticEmitter'.static.ScaleEmitter(FlashLightEmitter, DrawScale);
			StartProjector();
		}
		else
		{
			PlaySound(TorchOffSound,,0.7,,32);
			if (FlashLightEmitter != None)
				FlashLightEmitter.Destroy();
			KillProjector();
		}
	}
	else //Laser
	{
		bLaserOn = !bLaserOn;
		ServerSwitchLaser(bLaserOn);
		if (bLaserOn)
		{
			SpawnLaserDot();
			PlaySound(LaserOnSound,,0.7,,32);
			AimSpread = LaserAimSpread;
			BFireMode[0].FireChaos *= 0.8;
		}
		else
		{
			KillLaserDot();
			PlaySound(LaserOffSound,,0.7,,32);
			AimSpread = default.AimSpread;
			BFireMode[0].FireChaos = BFireMode[0].default.FireChaos;
		}

		PlayIdle();
		bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
	}
}


//=================================
// Flashlight
//=================================
function ServerFlashLight (bool bNew)
{
	bLightsOn = bNew;
	LK05Attachment(ThirdPersonActor).bLightsOn = bLightsOn;
}

simulated function StartProjector()
{
	if (FlashLightProj == None)
		FlashLightProj = Spawn(class'MRS138TorchProjector',self,,location);
	AttachToBone(FlashLightProj, 'tip4');
	FlashLightProj.SetRelativeLocation(TorchOffset);
}
simulated function KillProjector()
{
	if (FlashLightProj != None)
		FlashLightProj.Destroy();
}

simulated event Tick(float DT)
{
	super.Tick(DT);

	if (!bLightsOn || ClientState != WS_ReadyToFire)
		return;
	if (!Instigator.IsFirstPerson())
		KillProjector();
	else if (FlashLightProj == None)
		StartProjector();
}


simulated event RenderOverlays( Canvas Canvas )
{
	local Vector TazLoc;
	local Rotator TazRot;
	super.RenderOverlays(Canvas);
	if (!IsInState('Lowered'))
		DrawLaserSight(Canvas);
	if (bLightsOn)
	{
		TazLoc = GetBoneCoords('tip4').Origin;
		TazRot = GetBoneRotation('tip4');
		if (FlashLightEmitter != None)
		{
			FlashLightEmitter.SetLocation(TazLoc);
			FlashLightEmitter.SetRotation(TazRot);
			Canvas.DrawActor(FlashLightEmitter, false, false, DisplayFOV);
		}
	}
}


//=================================
// Laser
//=================================
function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
	if (ThirdPersonActor!=None)
		LK05Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
	if (bLaserOn)
	{
		AimAdjustTime = default.AimAdjustTime * 1.5;
		//AimSpread = LaserAimSpread;
		BFireMode[0].FireChaos *= 0.8;
	}
	else
	{
		AimAdjustTime = default.AimAdjustTime;
		//AimSpread = default.AimSpread;
		BFireMode[0].FireChaos = BFireMode[0].default.FireChaos;
	}
}


simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.Kill();
		LaserDot = None;
	}
}
simulated function SpawnLaserDot(optional vector Loc)
{
	if (LaserDot == None)
		LaserDot = Spawn(class'MD24LaserDot',,,Loc);
}


// Draw a laser beam and dot to show exact path of bullets before they're fired
simulated function DrawLaserSight ( Canvas Canvas )
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator AimDir;
	local Actor Other;

	if ((ClientState == WS_Hidden) || (!bLaserOn) || Instigator == None || Instigator.Controller == None || Laser==None)
		return;

	AimDir = BallisticFire(FireMode[0]).GetFireAim(Start);
	Loc = GetBoneCoords('tip3').Origin;

	End = Start + Normal(Vector(AimDir))*5000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
		LaserDot.SetLocation(HitLocation);
	Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = class'BUtil'.static.ConvertFOVs(Instigator.Location + Instigator.EyePosition(), Instigator.GetViewRotation(), End, Instigator.Controller.FovAngle, DisplayFOV, 400);

	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && 
	   ((FireMode[0].IsFiring() && Level.TimeSeconds - FireMode[0].NextFireTime > -0.05) || (!FireMode[0].IsFiring() && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)))
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('tip3');
		Laser.SetRotation(AimDir);
	}
	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 1;
	Scale3D.Z = 1;
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}

//=================================
// Destroy Cleanup
//=================================
simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			LK05Attachment(ThirdPersonActor).bLaserOn = false;
		KillProjector();
		if (FlashLightEmitter != None)
			FlashLightEmitter.Destroy();

		Instigator.AmbientSound = UsedAmbientSound;
		Instigator.SoundVolume = default.SoundVolume;
		Instigator.SoundPitch = default.SoundPitch;
		Instigator.SoundRadius = default.SoundRadius;
		Instigator.bFullVolume = false;
		return true;
	}
	return false;
}

simulated function Destroyed ()
{
	default.bLaserOn = false;
	if (Laser != None)
		Laser.Destroy();
	if (LaserDot != None)
		LaserDot.Destroy();
	if (FlashLightEmitter != None)
		FlashLightEmitter.Destroy();
	KillProjector();

	if(Instigator != None)
	{
		Instigator.AmbientSound = UsedAmbientSound;
		Instigator.SoundVolume = default.SoundVolume;
		Instigator.SoundPitch = default.SoundPitch;
		Instigator.SoundRadius = default.SoundRadius;
		Instigator.bFullVolume = false;
	}

	Super.Destroyed();
}


//=================================
// Sights and custom anim support
//=================================
simulated function BringUp(optional Weapon PrevWeapon)
{
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'OpenIdle';
		ReloadAnim = 'ReloadEmpty';
	}
	
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
	}

	Super.BringUp(PrevWeapon);
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'LaserActor');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();
	if (Instigator != None && AIController(Instigator.Controller) != None)
	{
		ServerSwitchLaser(FRand() > 0.5);
		ServerFlashlight(FRand() > 0.5);
	}

	if (AIController(Instigator.Controller) != None)
		bSilenced = (FRand() > 0.5);

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);

	if ( ThirdPersonActor != None )
		LK05Attachment(ThirdPersonActor).bLaserOn = bLaserOn;


	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = true;
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'OpenFire' || Anim == 'Pullout' || Anim == 'PulloutFancy' || Anim == 'Fire' || Anim == 'SightFire' || Anim == 'OpenSightFire' ||Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'OpenIdle';
			ReloadAnim = 'ReloadEmpty';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
		}
	}
	Super.AnimEnd(Channel);
}

//=================================
// Bot crap
//=================================
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
     ManualLines(0)="5.56 fire. Higher DPS than comparable weapons, but awkward recoil and highly visible tracers."
     ManualLines(1)="Attaches or remvoes the suppressor. When active, the suppressor reduces recoil and noise output and hides the muzzle flash, but reduces range."
     ManualLines(2)="The Weapon Function key, when used, first cycles between the weapon's laser sight and flashlight, and then activates both at once. Activate again to disable both. The laser sight reduces the spread of the hipfire, but compromises stealth.||Effective at close and medium range."
     LaserOnSound=Sound'BallisticSounds2.M806.M806LSight'
     LaserOffSound=Sound'BallisticSounds2.M806.M806LSight'
     LaserAimSpread=64.000000
     SilencerBone="Silencer"
     SilencerBone2="Silencer2"
     SilencerOnSound=Sound'BWBP3-Sounds.SRS900.SRS-SilencerOn'
     SilencerOffSound=Sound'BWBP3-Sounds.SRS900.SRS-SilencerOff'
     SilencerOnAnim="SilencerOn"
     SilencerOffAnim="SilencerOff"
     TorchOffset=(X=-50.000000)
     TorchOnSound=Sound'BWAddPack-RS-Sounds.MRS38.RSS-FlashClick'
     TorchOffSound=Sound'BWAddPack-RS-Sounds.MRS38.RSS-FlashClick'
     ScopeBone="EOTech"
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticRecolors4TexPro.LK05.BigIcon_LK05'
     BigIconCoords=(Y1=36,Y2=225)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     SpecialInfo(0)=(Info="240.0;25.0;0.9;80.0;0.7;0.7;0.4")
     BringUpSound=(Sound=Sound'PackageSounds4Pro.MJ51.MJ51-PullOut',Volume=2.200000)
     PutDownSound=(Sound=Sound'PackageSounds4Pro.MJ51.MJ51-Putaway',Volume=2.200000)
     MagAmmo=25
     CockSound=(Sound=Sound'PackageSounds4ProExp.LK05.LK05-Cock',Volume=2.200000)
     ClipOutSound=(Sound=Sound'PackageSounds4ProExp.LK05.LK05-MagOut',Volume=2.400000)
     ClipInSound=(Sound=Sound'PackageSounds4ProExp.LK05.LK05-MagIn',Volume=2.400000)
     ClipInFrame=0.650000
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(1)=(Value=4.000000)
     WeaponModes(3)=(bUnavailable=True)
     bNoCrosshairInScope=True
     SightOffset=(X=10.000000,Y=-8.550000,Z=24.660000)
     SightDisplayFOV=25.000000
     SightingTime=0.300000
     SprintOffSet=(Pitch=-3072,Yaw=-4096)
	 
     AimSpread=16
     ChaosDeclineTime=0.5
     ChaosSpeedThreshold=15000.000000
     ChaosAimSpread=768
	 
	 ViewRecoilFactor=0.35
     RecoilXCurve=(Points=(,(InVal=0.1,OutVal=0.12),(InVal=0.2,OutVal=0.18),(InVal=0.35,OutVal=0.22),(InVal=0.5,OutVal=0.3),(InVal=0.7,OutVal=0.45),(InVal=0.85,OutVal=0.6),(InVal=1.000000,OutVal=0.66)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.050000
     RecoilYFactor=0.050000
     RecoilDeclineTime=0.4
     RecoilDeclineDelay=0.200000
	 
     FireModeClass(0)=Class'BWBPRecolorsPro.LK05PrimaryFire'
     FireModeClass(1)=Class'BWBPRecolorsPro.LK05SecondaryFire'
     IdleAnimRate=0.500000
     SelectAnimRate=1.660000
     PutDownAnimRate=1.330000
     PutDownTime=0.400000
     BringUpTime=0.450000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.70000
     CurrentRating=0.700000
     Priority=41
     HudColor=(B=24,G=48)
	 bCockOnEmpty=True
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
     PickupClass=Class'BWBPRecolorsPro.LK05Pickup'
     PlayerViewOffset=(X=-6.000000,Y=12.000000,Z=-17.000000)
     BobDamping=2.000000
     AttachmentClass=Class'BWBPRecolorsPro.LK05Attachment'
     IconMaterial=Texture'BallisticRecolors4TexPro.LK05.SmallIcon_LK05'
     IconCoords=(X2=127,Y2=31)
     ItemName="LK-05 Advanced Carbine"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticRecolors4AnimProExp.LK05_FP'
     DrawScale=0.300000
}
