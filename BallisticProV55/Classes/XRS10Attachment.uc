//=============================================================================
// XRS10Attachment.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class XRS10Attachment extends HandgunAttachment;

var   bool					bLaserOn;	//Is laser currently active
var   bool					bOldLaserOn;//Old bLaserOn
var   LaserActor			Laser;		//The laser actor
var   Rotator				LaserRot;

replication
{
	reliable if ( Role==ROLE_Authority )
		bLaserOn;
	unreliable if ( Role==ROLE_Authority )
		LaserRot;
}

simulated function Tick(float DT)
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator X;
	local Actor Other;

	Super.Tick(DT);

	if (bLaserOn && Role == ROLE_Authority && Handgun != None)
	{
		LaserRot = Instigator.GetViewRotation() + Handgun.GetFireRot();
	}

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (Laser == None)
		Laser = Spawn(class'LaserActor_RSBlueThird',,,Location);

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

	Start = Instigator.Location + Instigator.EyePosition();
	X = LaserRot;

	Loc = GetBoneCoords('tip3').Origin;

	End = Start + (Vector(X)*5000);
	Other = Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	Laser.SetLocation(Loc);
	Laser.SetRotation(Rotator(HitLocation - Loc));
	Scale3D.X = VSize(HitLocation-Laser.Location)/128;
	Scale3D.Y = 1.5;
	Scale3D.Z = 1.5;
	Laser.SetDrawScale3D(Scale3D);
}

simulated function Destroyed()
{
	if (Laser != None)
		Laser.Destroy();
	Super.Destroyed();
}


simulated event ThirdPersonEffects()
{
    if ( Level.NetMode != NM_DedicatedServer && Instigator != None)
	{
		if (FiringMode == 1)
			SetBoneScale (0, 1.0, 'Silencer');
		else
			SetBoneScale (0, 0.0, 'Silencer');
    }
	super.ThirdPersonEffects();
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     AltFlashBone="tip2"
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     TracerMix=-3
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.650000
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.XRS10_TPm'
     DrawScale=0.100000
}
