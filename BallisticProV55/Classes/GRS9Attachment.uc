//=============================================================================
// GRS9Attachment.
//
// 3rd person weapon attachment for GRS9 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class GRS9Attachment extends HandgunAttachment;

var   bool					bLaserOn;	//Is laser currently active
var   bool					bOldLaserOn;//Old bLaserOn
var   LaserActor			Laser;		//The laser actor
var   Rotator				LaserRot;
var   vector				PreviousHitLoc;
var   Emitter				LaserDot;
var   bool					bBigLaser;

var bool					bHasKnife;	//shank?
var bool					bHasFlash;	//blind?
var bool					bHasCombatLaser; //ouch?
var	  BallisticWeapon		myWeap;

replication
{
	reliable if ( Role==ROLE_Authority )
		bLaserOn, bHasCombatLaser, bHasKnife, bHasFlash;
	unreliable if ( Role==ROLE_Authority )
		LaserRot, bBigLaser;
}

function InitFor(Inventory I)
{
	Super.InitFor(I);

	if (BallisticWeapon(I) != None)
		myWeap = BallisticWeapon(I);
	if (GRS9Pistol(I) != None && GRS9Pistol(I).bHasKnife)
	{
		bHasKnife=true;
	}
	if (GRS9Pistol(I) != None && GRS9Pistol(I).bHasFlash)
	{
		bHasFlash=true;
	}
	if (GRS9Pistol(I) != None && GRS9Pistol(I).bHasCombatLaser)
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

	if (bLaserOn && Role == ROLE_Authority && Handgun != None)
	{
		LaserRot = Instigator.GetViewRotation() + Handgun.GetFireRot();
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
	if (bBigLaser)
	{
		Scale3D.Y = 4;
		Scale3D.Z = 4;
	}
	else
	{
		Scale3D.Y = 1.5;
		Scale3D.Z = 1.5;
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
		ImpactManager = default.ImpactManager;
	else if (bHasKnife && Mode == 1)
	{
		MeleeFireEffects();
		return;
	}
	else if (bHasCombatLaser && Mode == 1)
	{
		if (VSize(PreviousHitLoc - mHitLocation) < 2)
			return;
		PreviousHitLoc = mHitLocation;
        ModeInfos[1].ImpactManager = class'IM_GRS9Laser';
		//ImpactManager = class'IM_GRS9Laser';
	}
	else if (bHasFlash && Mode == 1)
	{
		L = Instigator.Location + Instigator.EyePosition();
		Dir = Normal(mHitLocation - L);

		if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
			Spawn(class'AM67FlashProjector',Instigator,,L+Dir*25,rotator(Dir));
		else
			Spawn(class'AM67FlashProjector',Instigator,,GetModeTipLocation(),rotator(Dir));
		return;
	}
	super.InstantFireEffects(Mode);
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
		class'IM_MRS138TazerHit'.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, Instigator);
}

defaultproperties
{
	WeaponClass=class'GRS9Pistol'
	MuzzleFlashClass=class'XK2FlashEmitter'
	FlashScale=2.000000
	ImpactManager=class'IM_Bullet'
	//AltImpactManager=class'IM_GRS9Laser'
	BrassClass=class'Brass_GRSNine'
	InstantMode=MU_Both
	TracerClass=class'TraceEmitter_Pistol'
	TracerChance=0.600000
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	WaterTracerMode=MU_Both
	FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
	FlyByMode=MU_Primary
	ReloadAnim="Reload_Pistol"
	CockingAnim="Cock_RearPull"
	CockAnimRate=0.800000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.TPm_GRS9'
	DrawScale=0.070000
}
