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
var	  bool					bHasCombatLaser; //We big burnin
var   LaserActor			Laser;		//The laser actor
var   Rotator				LaserRot;
var   BallisticWeapon		myWeap;
var   vector				PreviousHitLoc;
var   Emitter				LaserDot;
var   float                 LaserSizeAdjust;

replication
{
	reliable if ( Role==ROLE_Authority )
		bLaserOn, bHasCombatLaser;
	unreliable if ( Role==ROLE_Authority )
		LaserRot,LaserSizeAdjust;
}

function InitFor(Inventory I)
{
	Super.InitFor(I);

	if (BallisticWeapon(I) != None)
		myWeap = BallisticWeapon(I);
	if (SARAssaultRifle(I) != None && SARAssaultRifle(I).bHasCombatLaser)
	{
		bHasCombatLaser=true;
	}
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
	{
		LaserDot = Spawn(class'IE_GRS9LaserHit',,,Loc);
		laserDot.bHidden=false;
	}
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
	{
		if (bHasCombatLaser)
			Laser = Spawn(class'LaserActor_GRSNine',,,Location);
		else
			Laser = Spawn(class'LaserActor_Third',,,Location);
	}

	if (bLaserOn != bOldLaserOn)
		bOldLaserOn = bLaserOn;

	if (!bLaserOn || Instigator == None || Instigator.IsFirstPerson() || Instigator.DrivenVehicle != None)
	{
		if (!Laser.bHidden)
			Laser.bHidden = true;
		if (LaserDot != None)
			KillLaserDot();
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

	if (bHasCombatLaser)
	{
		if (LaserDot == None && Other != None)
			SpawnLaserDot(HitLocation);
		else if (LaserDot != None && Other == None)
			KilllaserDot();
		if (LaserDot != None)
		{
			LaserDot.SetLocation(HitLocation);
			LaserDot.SetRotation(rotator(HitNormal));
		}
	}

	Laser.SetLocation(Loc);
	Laser.SetRotation(Rotator(HitLocation - Loc));
	Scale3D.X = VSize(HitLocation-Laser.Location)/128;
	if (bHasCombatLaser)
	{
		Scale3D.Y = 3.0 * (1 + 4*FMax(0, LaserSizeAdjust - 0.5));
		Scale3D.Z = Scale3D.Y;
	}
	else
	{
		Scale3D.Y = 1;
		Scale3D.Z = 1;
	}
	Laser.SetDrawScale3D(Scale3D);
}

simulated function Destroyed()
{
	if (Laser != None)
		Laser.Destroy();
	KillLaserDot();
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
	if (bHasCombatLaser && Mode == 1)
	{
		if (VSize(PreviousHitLoc - mHitLocation) < 2)
			return;
		PreviousHitLoc = mHitLocation;
		ImpactManager = class'IM_GRS9Laser';
		super.InstantFireEffects(Mode);
		return;
	}

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
	MuzzleFlashClass=class'XK2FlashEmitter'
	ImpactManager=class'IM_Bullet'
	FlashScale=2.000000
	BrassClass=class'Brass_SAR'
	BrassMode=MU_Primary
	InstantMode=MU_Both
	FlashMode=MU_Both
	TracerClass=class'TraceEmitter_Default'
	TracerMix=-3
	WaterTracerClass=class'TraceEmitter_WaterBullet'
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
