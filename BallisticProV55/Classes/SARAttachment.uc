//=============================================================================
// SARAttachment.
//
// 3rd person weapon attachment for SAR Assault
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class SARAttachment extends BallisticAttachment;

var   bool					bLaserOn;	//Is laser currently active
var   bool					bOldLaserOn;//Old bLaserOn
var   LaserActor			Laser;		//The laser actor
var   Rotator				LaserRot;
var   BallisticWeapon		myWeap;

replication
{
	reliable if ( Role==ROLE_Authority )
		bLaserOn;
	unreliable if ( Role==ROLE_Authority )
		LaserRot;
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
		LaserRot = Instigator.GetViewRotation() + myWeap.GetFireRot();
	}

	if (Level.NetMode == NM_DedicatedServer)
		return;

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
	Loc = GetBoneCoords('tip2').Origin;

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
	Super.Destroyed();
}

simulated function InstantFireEffects(byte Mode)
{
	local vector L, Dir;

	if (Mode == 0)
	{
		super.InstantFireEffects(Mode);
		return;
	}
//	L = GetModeTipLocation();
	L = Instigator.Location + Instigator.EyePosition();
	Dir = Normal(mHitLocation - L);

	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		Spawn(class'AM67FlashProjector',Instigator,,L+Dir*25,rotator(Dir));
	else
		Spawn(class'AM67FlashProjector',Instigator,,GetModeTipLocation(),rotator(Dir));
}

defaultproperties
{
	WeaponClass=class'SARAssaultRifle'
	MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
	ImpactManager=Class'BallisticProV55.IM_Bullet'
	FlashScale=2.000000
	BrassClass=Class'BallisticProV55.Brass_SAR'
	BrassMode=MU_Both
	InstantMode=MU_Both
	FlashMode=MU_Both
	TracerClass=Class'BallisticProV55.TraceEmitter_Default'
	TracerMix=-3
	WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
	WaterTracerMode=MU_Both
	FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
	ReloadAnim="Reload_AR"
	ReloadAnimRate=1.100000
	bHeavy=True
	bRapidFire=True
	bAltRapidFire=True
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.SAR12_TPm'
	DrawScale=0.100000
	SoundRadius=256.000000
}
