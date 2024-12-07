//=============================================================================
// E5Attachment.
//
// 3rd person weapon attachment for E5 Plasma Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class E5Attachment extends BallisticAttachment;

var   bool					bLaserOn;	//Is laser currently active
var   bool					bOldLaserOn;//Old bLaserOn
var   LaserActor			Laser;		//The laser actor
var   Rotator				LaserRot;
var   vector				PreviousHitLoc;
var   Emitter				LaserDot;
var	  BallisticWeapon		myWeap;

replication
{
	reliable if ( Role==ROLE_Authority )
		bLaserOn;
	unreliable if ( Role==ROLE_Authority )
		LaserRot;
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
		LaserDot = Spawn(class'IE_VPRLaserHit',,,Loc);
		laserDot.bHidden=false;
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
		LaserRot = Instigator.GetViewRotation() + myWeap.GetFireRot();
	}

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (Laser == None)
		Laser = Spawn(class'LaserActor_VPR',,,Location);

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

	Loc = GetModeTipLocation();
	if (AIController(Instigator.Controller)!=None)
	{
		HitLocation = mHitLocation;
	}
	else
	{
		End = Start + (Vector(X)*3000);
		Other = Trace (HitLocation, HitNormal, End, Start, true);
		if (Other == None)
			HitLocation = End;
	}

	if (LaserDot == None && Other != None)
		SpawnLaserDot(HitLocation);
	else if (LaserDot != None && Other == None)
		KilllaserDot();
	if (LaserDot != None)
	{
		LaserDot.SetLocation(HitLocation);
		LaserDot.SetRotation(rotator(HitNormal));
		LaserDot.Emitters[5].AutomaticInitialSpawning = Other.bWorldGeometry;
	}

	Laser.SetLocation(Loc);
	Laser.SetRotation(Rotator(HitLocation - Loc));
	Scale3D.X = VSize(HitLocation-Laser.Location)/128;

	Scale3D.Y = 4;
	Scale3D.Z = 4;

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
	if (InstantMode == MU_None || (InstantMode == MU_Secondary && Mode == 0) || (InstantMode == MU_Primary && Mode != 0))
		return;
	if (mHitLocation == vect(0,0,0))
		return;
	if (Instigator == none)
		return;

	if (VSize(PreviousHitLoc - mHitLocation) < 2)
		return;
	PreviousHitLoc = mHitLocation;
	ImpactManager = class'IM_VPRLaser';

	super.InstantFireEffects(Mode);
}

simulated function FlashMuzzleFlash(byte Mode)
{
	if (Mode == 0)
		super.FlashMuzzleFlash(Mode);
	else if (AltMuzzleFlash == None && AltMuzzleFlashClass != None)
		class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
}

simulated function Timer()
{
	super.Timer();

	if (AltMuzzleFlash != None)
	{
		Emitter(AltMuzzleFlash).Kill();
		AltMuzzleFlash = None;
	}
}

defaultproperties
{
	WeaponClass=class'E5PlasmaRifle'
    MuzzleFlashClass=Class'BWBP_APC_Pro.E5FlashEmitter'
    AltMuzzleFlashClass=Class'BWBP_APC_Pro.E5LaserFlashEmitter'
    TracerMode=MU_None
    InstantMode=MU_Secondary
    FlashMode=MU_Both
    LightMode=MU_Both
    ReloadAnim="Reload_AR"
    bRapidFire=True
	FlashScale=0.300000
	RelativeLocation=(Z=5.000000)
	ReloadAnimRate=0.750000
    Mesh=SkeletalMesh'BWBP_APC_Anim.E5Plasma_TPm'
    DrawScale=0.750000
}
