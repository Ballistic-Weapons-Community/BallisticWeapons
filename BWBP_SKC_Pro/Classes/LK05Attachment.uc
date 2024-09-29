//=============================================================================
// LK05Attachment.
//
// 3rd person weapon attachment for LK05 Tactical Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LK05Attachment extends BallisticAttachment;

var   bool					bLaserOn;	//Is laser currently active
var   bool					bOldLaserOn;//Old bLaserOn
var   LaserActor			Laser;		//The laser actor
var   Rotator				LaserRot;
var	  BallisticWeapon		myWeap;
var() Material	InvisTex;

var bool		bLightsOn, bLightsOnOld;
var Projector	FlashLightProj;
var Emitter		FlashLightEmitter;
var bool		bSilenced;
var bool		bOldSilenced;


replication
{
	reliable if ( Role==ROLE_Authority )
		bLightsOn, bLaserOn, bSilenced;
	reliable if ( Role==ROLE_Authority )
		LaserRot;
}

simulated event PostNetReceive()
{
	if (bSilenced != bOldSilenced)
	{
		bOldSilenced = bSilenced;
		if (bSilenced)
			SetBoneScale (0, 1.0, 'SantasFrozenSphinctre');
		else
			SetBoneScale (0, 0.0, 'SantasFrozenSphinctre');
	}
	Super.PostNetReceive();
}


function IAOverride(bool bSilenced)
{
	if (bSilenced)
		SetBoneScale (0, 1.0, 'SantasFrozenSphinctre');
	else
		SetBoneScale (0, 0.0, 'SantasFrozenSphinctre');
}

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneScale (0, 0.0, 'SantasFrozenSphinctre');
}

simulated function Hide(bool NewbHidden)
{
	super.Hide(NewbHidden);
	SwitchFlashLight();
	if (NewbHidden)
	{
		KillProjector();
		if (FlashLightEmitter!=None)
			FlashLightEmitter.Destroy();
	}
	else if (bLightsOn)
		SwitchFlashLight();
}

simulated function StartProjector()
{
	if (FlashLightProj == None)
		FlashLightProj = Spawn(class'MRS138TorchProjector',self,,location);
	AttachToBone(FlashLightProj, 'tip4');
	FlashLightProj.SetRelativeLocation(vect(-32,0,0));
}
simulated function KillProjector()
{
	if (FlashLightProj != None)
	{
		FlashLightProj.Destroy();
		FlashLightProj = None;
	}
}

simulated function SwitchFlashLight ()
{
	if (bLightsOn)
	{
		if (FlashLightEmitter == None)
		{
			FlashLightEmitter = Spawn(class'MRS138TorchEffect',self,,location);
			class'BallisticEmitter'.static.ScaleEmitter(FlashLightEmitter, DrawScale);
			AttachToBone(FlashLightEmitter, 'tip4');
			FlashLightEmitter.bHidden = false;
			FlashLightEmitter.bCorona = true;
		}
		if (!Instigator.IsFirstPerson())
			StartProjector();
	}
	else
	{
		FlashLightEmitter.Destroy();
		KillProjector();
	}
}

function InitFor(Inventory I)
{
	Super.InitFor(I);

	if (BallisticWeapon(I) != None)
		myWeap = BallisticWeapon(I);
}

simulated function Tick(float DT)
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator X;
	local Actor Other;

	Super.Tick(DT);

	if (bLaserOn && Role == ROLE_Authority && myWeap != None)
	{
		LaserRot = Instigator.GetViewRotation();
		LaserRot += myWeap.GetAimPivot();
		LaserRot += myWeap.GetRecoilPivot();
	}

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (bLightsOn != bLightsOnOld)
	{
		SwitchFlashLight();
		bLightsOnOld = bLightsOn;	
	}
	
	if (bLightsOn)
	{
		if (Instigator.IsFirstPerson())
		{
			KillProjector();
			if (FlashLightEmitter != None && FlashLightEmitter.bCorona)
				FlashLightEmitter.bCorona = false;
		}
		else
		{
			if (FlashLightProj == None)
				StartProjector();
			if (FlashLightEmitter != None && !FlashLightEmitter.bCorona)
				FlashLightEmitter.bCorona = true;
		}
	}

	if (Laser == None)
		Laser = Spawn(class'LaserActor_Third',,,Location);

	if (bLaserOn != bOldLaserOn)
		bOldLaserOn = bLaserOn;

	if (!bLaserOn || Instigator == None || Instigator.IsFirstPerson() || Instigator.DrivenVehicle != None)
	{
		if (!Laser.bHidden)
			Laser.bHidden = true;
		return;
	}
	else
	{
		if (Laser.bHidden)
			Laser.bHidden = false;
	}

	if (Instigator != None)
		Start = Instigator.Location + Instigator.EyePosition();
	else
		Start = Location;
	X = LaserRot;

//	Loc = GetModeTipLocation();
	Loc = GetBoneCoords('tip3').Origin;

	End = Start + (Vector(X)*5000);
	Other = Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	Laser.SetLocation(Loc);
	Laser.SetRotation(Rotator(HitLocation - Loc));
	Scale3D.X = VSize(HitLocation-Laser.Location)/128;
	Scale3D.Y = 1;
	Scale3D.Z = 1;
	Laser.SetDrawScale3D(Scale3D);
}

simulated function Destroyed()
{
	if (Laser != None)
		Laser.Destroy();
	if (FlashLightEmitter != None)
		FlashLightEmitter.Destroy();
	KillProjector();
	Super.Destroyed();
}

defaultproperties
{
	WeaponClass=class'LK05Carbine'
	MuzzleFlashClass=class'M50FlashEmitter'
	AltMuzzleFlashClass=Class'BWBP_SKC_Pro.LK05SilencedFlash'
	ImpactManager=class'IM_Bullet'
	AltFlashBone="tip2"
	BrassClass=class'Brass_Rifle'
	InstantMode=MU_Both
	FlashMode=MU_Both
	LightMode=MU_Both
	TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_MARS'
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	WaterTracerMode=MU_Both
	FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
	ReloadAnim="Reload_AR"
	ReloadAnimRate=1.200000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.LK05_TPm'
	RelativeRotation=(Pitch=32768)
	PrePivot=(X=1.000000,Z=-3.000000)
}
