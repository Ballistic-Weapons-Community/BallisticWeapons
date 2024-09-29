//=============================================================================
// M290Attachment.
//
// 3rd person weapon attachment for M290 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M290Attachment extends BallisticShotgunAttachment;

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

// Fling out shell casing
simulated function EjectBrass(byte Mode)
{
	if (Mode == 0 || Mode == 2)
	{
		BrassBone = 'EjectorR';
		BrassClass = Class'Brass_M290Right';
		super.EjectBrass(0);
	}
	if (Mode == 0 || Mode == 1)
	{
		BrassBone = 'EjectorR';
		BrassClass = Class'Brass_M290Left';
		super.EjectBrass(0);
	}
}

function M290UpdateHit(Actor HitActor, vector HitLocation, vector HitNormal, int HitSurf, optional bool bIsRight)
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
     WeaponClass=class'M290Shotgun'
     MuzzleFlashClass=class'MRT6FlashEmitter'
     AltMuzzleFlashClass=class'MRT6FlashEmitter'
     ImpactManager=class'IM_Shell'
     AltFlashBone="tip2"
     FlashScale=3.500000
     BrassClass=class'Brass_M290Left'
     BrassMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=class'TraceEmitter_Shotgun'
     TracerChance=0.500000
     CockingAnim="Cock_Pump"
     CockAnimRate=1.700000
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.M290_TPm'
     DrawScale=0.180000
}
