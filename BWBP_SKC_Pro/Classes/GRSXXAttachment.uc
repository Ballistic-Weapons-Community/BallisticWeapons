//=============================================================================
// GRS9Attachment.
//
// _TPm person weapon attachment for GRS9 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class GRSXXAttachment extends HandgunAttachment;

var   bool					bLaserOn;	//Is laser currently active
var   bool					bOldLaserOn;//Old bLaserOn
var   LaserActor			Laser;		//The laser actor
var   Rotator				LaserRot;
var   vector				PreviousHitLoc;
var   Emitter				LaserDot;
var   bool					bBigLaser;

replication
{
	reliable if ( Role==ROLE_Authority )
		bLaserOn;
	unreliable if ( Role==ROLE_Authority )
		LaserRot, bBigLaser;
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
		LaserDot = Spawn(class'IE_GRSXXLaserHit',,,Loc);
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
		Laser = Spawn(class'LaserActor_GRSXX',,,Location);

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
	if (bBigLaser)
	{
		Scale3D.Y = 9;
		Scale3D.Z = 9;
	}
	else
	{
		Scale3D.Y = 4.5;
		Scale3D.Z = 4.5;
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
	if (Mode == 0)
		ImpactManager = default.ImpactManager;
	else
	{
		if (VSize(PreviousHitLoc - mHitLocation) < 2)
			return;
		//PreviousHitLoc = mHitLocation;
        ModeInfos[1].ImpactManager = class'IM_GRSXXLaser';
		//ImpactManager = class'IM_GRSXXLaser';
	}
	super.InstantFireEffects(Mode);
}

defaultproperties
{
	WeaponClass=class'GRSXXPistol'
     MuzzleFlashClass=Class'BWBP_SKC_Pro.GRSXXFlashemitter'
     ImpactManager=class'IM_Bullet'
     //AltImpactManager=class'IM_GRSXXLaser'
     BrassClass=Class'BWBP_SKC_Pro.Brass_GRSXX'
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
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.GRS9_TPm'
     DrawScale=0.070000
	 Skins(0)=Shader'BWBP_SKC_Tex.Glock_Gold.GRSXX-MainShine'
}
