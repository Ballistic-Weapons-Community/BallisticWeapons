//=============================================================================
// SKASAttachment.
//
// 3rd person weapon attachment for SKAS-21 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SKASAttachment extends BallisticShotgunAttachment;

simulated function FlashMuzzleFlash(byte Mode)
{
	local rotator R;

	if (FlashMode == MU_None || (FlashMode == MU_Secondary && Mode == 0) || (FlashMode == MU_Primary && Mode != 0))
		return;
	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (AltMuzzleFlashClass != None && AltMuzzleFlash == None)
		class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
	if (MuzzleFlashClass != None && MuzzleFlash == None)
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);

	R = Instigator.Rotation;
	R.Pitch = Rotation.Pitch;
	if (Mode == 0 || Mode == 2)
	{
		if (class'BallisticMod'.default.bMuzzleSmoke)
			Spawn(class'MRT6Smoke',,, AltMuzzleFlash.Location, R);
		AltMuzzleFlash.Trigger(self, Instigator);
	}
	if (Mode == 0 || Mode == 1)
	{
		if (class'BallisticMod'.default.bMuzzleSmoke)
			Spawn(class'MRT6Smoke',,, MuzzleFlash.Location, R);
		MuzzleFlash.Trigger(self, Instigator);
	}

}

function SKASUpdateHit(Actor HitActor, vector HitLocation, vector HitNormal, int HitSurf, optional bool bIsRight)
{
	mHitNormal = HitNormal;
	mHitActor = HitActor;
	mHitLocation = HitLocation;
	if (bIsRight)
		FiringMode = 2;
	else
		FiringMode = 1;
	FireCount++;
	ThirdPersonEffects();
}

defaultproperties
{
     FireClass=Class'BWBPRecolorsPro.SKASPrimaryFire'
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     FlashScale=1.800000
     BrassClass=Class'BallisticProV55.Brass_MRS138Shotgun'
     BrassMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     TracerChance=0.500000
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.950000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.SKAS_TPm'
     RelativeLocation=(X=-2.000000,Z=7.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.130000
}
