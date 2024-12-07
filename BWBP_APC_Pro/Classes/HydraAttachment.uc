//=============================================================================
// G5Attachment.
//
// 3rd person weapon attachment for G5 Bazooka
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HydraAttachment extends BallisticAttachment;

var   bool					bLaserOn;		//Is laser currently active
var   bool					bOldLaserOn;	//Old bLaserOn
var   LaserActor			Laser;			//The laser actor
var   vector				LaserEndLoc;
var   Emitter				LaserDot;
var   Rotator				LaserRot;
var   BallisticWeapon 		myWeap;

var name BackBones[6];
var name FrontBones[6];
var byte Index;

var array<Actor> BackFlashes[6];
var array<Actor> FrontFlashes[6];

// This assumes flash actors are triggered to make them work
// Override this in subclassed for better control
simulated function FlashMuzzleFlash(byte Mode)
{
	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (AltMuzzleFlashClass != None)
	{
		if (BackFlashes[Index] == None)
		{
			BackFlashes[Index] = Spawn(AltMuzzleFlashClass, self);
			if (Emitter(BackFlashes[Index]) != None)
				class'BallisticEmitter'.static.ScaleEmitter(Emitter(BackFlashes[Index]), DrawScale*FlashScale);
			BackFlashes[Index].SetDrawScale(DrawScale*FlashScale);
			if (DGVEmitter(BackFlashes[Index]) != None)
				DGVEmitter(BackFlashes[Index]).InitDGV();

			AttachToBone(BackFlashes[Index], BackBones[Index]);
		}
		BackFlashes[Index].Trigger(self, Instigator);
	}
	if (MuzzleFlashClass != None)
	{
		if (FrontFlashes[Index] == None)
		{
			FrontFlashes[Index] = Spawn(MuzzleFlashClass, self);
			if (Emitter(FrontFlashes[Index]) != None)
				class'BallisticEmitter'.static.ScaleEmitter(Emitter(FrontFlashes[Index]), DrawScale*FlashScale);
			FrontFlashes[Index].SetDrawScale(DrawScale*FlashScale);
			if (DGVEmitter(FrontFlashes[Index]) != None)
				DGVEmitter(FrontFlashes[Index]).InitDGV();
				
			AttachToBone(FrontFlashes[Index], FrontBones[Index]);
		}
		FrontFlashes[Index].Trigger(self, Instigator);
	}
	
	Index++;
	if (Index > 5)
		Index = 0;
}

simulated event Destroyed()
{
	local int i;

	for (i=0; i<6; i++)
	{
		class'BUtil'.static.KillEmitterEffect (FrontFlashes[i]);
		class'BUtil'.static.KillEmitterEffect (BackFlashes[i]);
	}

	if (LaserDot != None)
		LaserDot.Destroy();
	if (Laser != None)
		Laser.Destroy();

	Super.Destroyed();
}

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

	if (bLaserOn && Role==ROLE_Authority && myWeap != None)
	{
		LaserRot = Instigator.GetViewRotation();
		LaserRot += myWeap.GetAimPivot();
		LaserRot += myWeap.GetRecoilPivot();
	}

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (Laser == None)
		Laser = Spawn(class'BallisticProV55.LaserActor_G5Painter',,,Location);

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

	Loc = GetBoneCoords('tip2').Origin;

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

defaultproperties
{
	 WeaponClass=class'HydraBazooka'
     BackBones(0)="backblast"
	 BackBones(1)="backblast"
	 BackBones(2)="backblast"
	 BackBones(3)="backblast"
	 BackBones(4)="backblast"
	 BackBones(5)="backblast"
     FrontBones(0)="Muzzle1"
     FrontBones(1)="Muzzle2"
     FrontBones(2)="Muzzle3"
	 FrontBones(3)="Muzzle4"
	 FrontBones(4)="Muzzle5"
	 FrontBones(5)="Muzzle6"
	 MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
     AltMuzzleFlashClass=Class'BWBP_APC_Pro.HydraBackFlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     AltFlashBone="laser"
     FlashScale=1.200000
     BrassMode=MU_None
     InstantMode=MU_None
	 ReloadAnim="Reload_MG"
	 ReloadAnimRate=1.180000
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_APC_Anim.CruRL_TPm'
     DrawScale=0.230000
}
