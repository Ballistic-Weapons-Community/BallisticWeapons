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

var   bool		    bLaserOn, bOldLaserOn;
var   LaserActor    Laser;
var() Sound		    LaserOnSound;
var() Sound		    LaserOffSound;
var   Emitter	    LaserDot;
var() float		    LaserAimSpread;

var   bool		    bSilenced;				// Silencer on. Silenced
var() name		    SilencerBone;			// Bone to use for hiding silencer
var() name		    SilencerBone2;			// Bone to use for hiding silencer
var() sound		    SilencerOnSound;		// Silencer stuck on sound
var() sound		    SilencerOffSound;		//
var() name		    SilencerOnAnim;			// Think hard about this one...
var() name		    SilencerOffAnim;		//

var Projector	    FlashLightProj;
var Emitter		    FlashLightEmitter;
var bool		    bLightsOn;
var bool		    bFirstDraw;
var vector		    TorchOffset;
var() Sound		    TorchOnSound;
var() Sound		    TorchOffSound;

var() name		    ScopeBone;			// Bone to use for hiding scope


replication
{
	reliable if (Role < ROLE_Authority)
		ServerFlashLight, ServerSwitchSilencer, ServerSwitchLaser;
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
		OnLaserSwitched();

		bOldLaserOn = bLaserOn;
        ClientSwitchLaser();
	}
	Super.PostNetReceive();
}

simulated function OnAimParamsChanged()
{
	Super.OnAimParamsChanged();

	if (bSilenced)
		ApplySuppressorAim();
	if (bLaserOn)
		ApplyLaserAim();
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
	if (ReloadState != RS_None || SightingState != SS_None)
		return;
	if (ClientState != WS_ReadyToFire)
		return;

	bSilenced = !bSilenced;
	ServerSwitchSilencer(bSilenced);
	PlaySuppressorAttachment(bSilenced);
	OnSuppressorSwitched();
	LK05PrimaryFire(FireMode[0]).SwitchSilencerMode(bSilenced);
	LK05Attachment(ThirdPersonActor).IAOverride(bSilenced);
}

simulated function OnSuppressorSwitched()
{
	if (bSilenced)
		ApplySuppressorAim();
	else
		AimComponent.Recalculate();
}

simulated function ApplySuppressorAim()
{
	AimComponent.AimSpread.Min *= 1.2;
	AimComponent.AimSpread.Max *= 1.2;
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
		ServerSwitchLaser(!bLaserOn);
		PlayIdle();
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

simulated function OnLaserSwitched()
{
	if (bLaserOn)
		ApplyLaserAim();
	else
		AimComponent.Recalculate();
}

simulated function ApplyLaserAim()
{
	AimComponent.AimAdjustTime *= 1.5;
	AimComponent.AimSpread.Max *= 0.8;
}

function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
	
	if (ThirdPersonActor!=None)
		LK05Attachment(ThirdPersonActor).bLaserOn = bLaserOn;

	OnLaserSwitched();

    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
}

simulated function ClientSwitchLaser()
{
	OnLaserSwitched();

	if (bLaserOn)
	{
		SpawnLaserDot();
		PlaySound(LaserOnSound,,0.7,,32);
	}
	else
	{
		KillLaserDot();
		PlaySound(LaserOffSound,,0.7,,32);
	}

	PlayIdle();
}

simulated function SpawnLaserDot(optional vector Loc)
{
	if (LaserDot == None)
		LaserDot = Spawn(class'MD24LaserDot',,,Loc);
}

simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.Kill();
		LaserDot = None;
	}
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticInstantFire(BFireMode[0]).DecayRange.Min, BallisticInstantFire(BFireMode[0]).DecayRange.Max); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
	ManualLines(0)="5.56 fire. Higher DPS than comparable weapons, but awkward recoil and highly visible tracers."
	ManualLines(1)="Attaches or removes the suppressor. When active, the suppressor reduces recoil and hides the muzzle flash. It also affects the rounds fired, reducing their velocity (and therefore, damage) and disabling their tracers."
	ManualLines(2)="The Weapon Function key, when used, first cycles between the weapon's laser sight and flashlight, and then activates both at once. Activate again to disable both. The laser sight provides a clear indication of where the barrel is pointing, which is useful when the weapon is suppressed, but compromises stealth.||Effective at close and medium range."
	LaserOnSound=Sound'BW_Core_WeaponSound.M806.M806LSight'
	LaserOffSound=Sound'BW_Core_WeaponSound.M806.M806LSight'
	LaserAimSpread=64.000000
	SilencerBone="Silencer"
	SilencerBone2="Silencer2"
	SilencerOnSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOn'
	SilencerOffSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOff'
	SilencerOnAnim="SilencerOn"
	SilencerOffAnim="SilencerOff"
	TorchOffset=(X=-50.000000)
	TorchOnSound=Sound'BW_Core_WeaponSound.MRS38.RSS-FlashClick'
	TorchOffSound=Sound'BW_Core_WeaponSound.MRS38.RSS-FlashClick'
	ScopeBone="EOTech"
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP_SKC_Tex.LK05.BigIcon_LK05'
	BigIconCoords=(Y1=36,Y2=225)
	
	bWT_Bullet=True
    bNetNotify=True
    bCockOnEmpty=False
	SpecialInfo(0)=(Info="240.0;25.0;0.9;80.0;0.7;0.7;0.4")
	BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-PullOut',Volume=1.600000)
	PutDownSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-Putaway',Volume=1.600000)
	CockSound=(Sound=Sound'BWBP_SKC_Sounds.LK05.LK05-Cock',Volume=1.200000)
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.LK05.LK05-MagOut',Volume=1.400000)
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.LK05.LK05-MagIn',Volume=1.400000)
	ClipInFrame=0.650000
	WeaponModes(0)=(bUnavailable=True)
	WeaponModes(1)=(Value=4.000000)
	WeaponModes(3)=(bUnavailable=True)
	bNoCrosshairInScope=True
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M50Out',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50In',Color1=(A=158),StartSize1=75,StartSize2=72)
	ParamsClasses(0)=Class'LK05WeaponParamsComp'
	ParamsClasses(1)=Class'LK05WeaponParamsClassic'
	ParamsClasses(2)=Class'LK05WeaponParamsRealistic'
    ParamsClasses(3)=Class'LK05WeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_SKC_Pro.LK05PrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.LK05SecondaryFire'
	IdleAnimRate=0.500000
	SelectAnimRate=1.660000
	PutDownAnimRate=1.330000
	PutDownTime=0.400000
	BringUpTime=0.450000
	CockingBringUpTime=1.100000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.70000
	CurrentRating=0.700000
	Priority=41
	HudColor=(B=24,G=48)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=4
	PickupClass=Class'BWBP_SKC_Pro.LK05Pickup'

	PlayerViewOffset=(X=6.00,Y=3.50,Z=-2.00)
	SightOffset=(X=1.5,Y=0,Z=2.16)
	SightAnimScale=0.5

	AttachmentClass=Class'BWBP_SKC_Pro.LK05Attachment'
	IconMaterial=Texture'BWBP_SKC_Tex.LK05.SmallIcon_LK05'
	IconCoords=(X2=127,Y2=31)
	ItemName="LK-05 Advanced Carbine"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_LK05'
	DrawScale=0.300000
}
