//=============================================================================
// AM67Attachment.
//
// 3rd person weapon attachment for AM67 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AM67Attachment extends HandgunAttachment;

//Laser Vars
var   bool					bLaserVariant; 
var   bool					bLaserOn;	//Is laser currently active
var   bool					bOldLaserOn;//Old bLaserOn
var   LaserActor			Laser;		//The laser actor
var   Rotator				LaserRot;
var   vector				PreviousHitLoc;
var   Emitter				LaserDot;
var   float                 LaserSizeAdjust;

replication
{
	reliable if ( Role==ROLE_Authority )
		bLaserOn, bLaserVariant;
	unreliable if ( Role==ROLE_Authority )
		LaserRot;
}

simulated event PreBeginPlay()
{
	super.PreBeginPlay();

	if (class'BallisticReplicationInfo'.static.IsRealism())
	{
		bLaserVariant=true;
	}
}

simulated function InstantFireEffects(byte Mode)
{
	local vector L, Dir;

	if (Mode == 0)
	{
		ImpactManager = default.ImpactManager;
		super.InstantFireEffects(Mode);
		return;
	}
	else if (bLaserVariant)
	{
		if (VSize(PreviousHitLoc - mHitLocation) < 2)
			return;
		PreviousHitLoc = mHitLocation;
		ImpactManager = class'IM_GRS9Laser';
		super.InstantFireEffects(Mode);
	}
	else
	{
	//	L = GetModeTipLocation();
		L = Instigator.Location + Instigator.EyePosition();
		Dir = Normal(mHitLocation - L);

		if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
			Spawn(class'AM67FlashProjector',Instigator,,L+Dir*25,rotator(Dir));
		else
			Spawn(class'AM67FlashProjector',Instigator,,GetModeTipLocation(Mode),rotator(Dir));
	}
}

simulated function FlashMuzzleFlash(byte Mode)
{
	local rotator R;
	local float DF;

	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (Mode != 0 && AltMuzzleFlashClass != None)
	{
//		AltMuzzleFlash = Spawn(AltMuzzleFlashClass, self);
//		AttachToBone(AltMuzzleFlash, AltFlashBone);
		if (AltMuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);

//		DF = Normal(level.GetlocalPlayerController().Location - (Instigator.Location + Instigator.EyePosition())) Dot Normal(mHitLocation - (Instigator.Location + Instigator.EyePosition()));
//		DF = FMax(0,DF);v
		Emitter(AltMuzzleFlash).Emitters[0].StartSizeRange.X.Min = (200 + DF*600) * DrawScale * FlashScale;
		Emitter(AltMuzzleFlash).Emitters[0].StartSizeRange.X.Max = Emitter(AltMuzzleFlash).Emitters[0].StartSizeRange.X.Min;

//		Emitter(AltMuzzleFlash).Emitters[0].StartSizeRange.X.Min *= 1 + DF*3;
//		Emitter(AltMuzzleFlash).Emitters[0].StartSizeRange.X.Max *= 1 + DF*3;

//		class'BallisticEmitter'.static.ScaleEmitter(Emitter(AltMuzzleFlash), DrawScale);

		AltMuzzleFlash.Trigger(self, Instigator);
//		AltMuzzleFlash.LifeSpan = 0.3;
//		Emitter(AltMuzzleFlash).Kill();
	}
	else if (Mode == 0 && MuzzleFlashClass != None)
	{
		if (MuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
		MuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(FlashBone, R, 0, 1.f);
	}
}

// Laser Code
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
		Laser = Spawn(class'LaserActor_GRSNine',,,Location);

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
	}

	Laser.SetLocation(Loc);
	Laser.SetRotation(Rotator(HitLocation - Loc));
	Scale3D.X = VSize(HitLocation-Laser.Location)/128;
	Scale3D.Y = 2.5*(1 + 4*FMax(0, LaserSizeAdjust - 0.5));
	Scale3D.Z = Scale3D.Y;
	Laser.SetDrawScale3D(Scale3D);
}

simulated function Destroyed()
{
	if (Laser != None)
		Laser.Destroy();
	KillLaserDot();
	Super.Destroyed();
}

defaultproperties
{
	WeaponClass=class'AM67Pistol'
     MuzzleFlashClass=class'D49FlashEmitter'
     AltMuzzleFlashClass=class'AM67FlashEmitter'
     ImpactManager=class'IM_BigBullet'
     AltFlashBone="ejector"
     BrassClass=class'Brass_Pistol'
     FlashMode=MU_Both
     TracerClass=class'TraceEmitter_Pistol'
     WaterTracerClass=class'TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_Pistol"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=0.950000
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.TPm_AM67'
     DrawScale=0.140000
}
