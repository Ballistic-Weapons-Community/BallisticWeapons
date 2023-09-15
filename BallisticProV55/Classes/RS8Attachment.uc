//=============================================================================
// RS8Attachment.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RS8Attachment extends HandgunAttachment;

var   bool					bHasKnife;	//shank?
var   bool					bLaserOn;	//Is laser currently active
var   bool					bOldLaserOn;//Old bLaserOn
var   LaserActor			Laser;		//The laser actor
var   Rotator				LaserRot;
var	  BallisticWeapon		myWeap;

replication
{
	reliable if ( Role==ROLE_Authority )
		bLaserOn, bHasKnife;
	unreliable if ( Role==ROLE_Authority )
		LaserRot;
}

function InitFor(Inventory I)
{
	Super.InitFor(I);

	if (BallisticWeapon(I) != None)
		myWeap = BallisticWeapon(I);
	if (RS8Pistol(I) != None && RS8Pistol(I).bHasKnife)
	{
		bHasKnife=true;
	}
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

simulated function InstantFireEffects(byte Mode)
{
	if (FiringMode != 0)
		MeleeFireEffects();
	else
		Super.InstantFireEffects(FiringMode);
}

// Do trace to find impact info and then spawn the effect
simulated function MeleeFireEffects()
{
	local Vector HitLocation, Dir, Start;
	local Material HitMat;

	if (mHitLocation == vect(0,0,0))
		return;

	if (Level.NetMode == NM_Client)
	{
		mHitActor = None;
		Start = Instigator.Location + Instigator.EyePosition();
		Dir = Normal(mHitLocation - Start);
		mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir*10, mHitLocation - Dir*10, false,, HitMat);
		if (mHitActor == None || (!mHitActor.bWorldGeometry))
			return;

		if (HitMat == None)
			mHitSurf = int(mHitActor.SurfaceType);
		else
			mHitSurf = int(HitMat.SurfaceType);
	}
	else
		HitLocation = mHitLocation;
	if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && Vehicle(mHitActor) == None))
		return;
	if (!bHasKnife)
		class'IM_GunHit'.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
	else 
		class'IM_Knife'.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, Instigator);
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
	WeaponClass=class'RS8Pistol'
	MuzzleFlashClass=class'XK2FlashEmitter'
	AltMuzzleFlashClass=class'XK2SilencedFlash'
	ImpactManager=class'IM_Bullet'
	AltFlashBone="tip2"
	BrassClass=class'Brass_Pistol'
	InstantMode=MU_Both
	TrackAnimMode=MU_Secondary
	TracerClass=class'TraceEmitter_Default'
	TracerMix=-3
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
	ReloadAnim="Reload_Pistol"
	CockingAnim="Cock_RearPull"
	ReloadAnimRate=1.400000
	bRapidFire=True
	bAltRapidFire=True
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.RS8_TPm'
	DrawScale=0.150000
}
