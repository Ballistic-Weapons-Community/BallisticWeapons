//=============================================================================
// MRT6Attachment.
//
// Attachemnt for MRT6 to give it double barrel abilities.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MRT6Attachment extends HandgunAttachment;

var() class<BallisticShotgunFire>	FireClass;

// Do trace to find impact info and then spawn the effect
// This should be called from sub-classes
simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Start, End;
	local Rotator R;
	local Material HitMat;
	local int i;
	local float XS, YS, RMin, RMax, Range, fX;

	if (Level.NetMode == NM_Client && FireClass != None)
	{
		XS = FireClass.default.XInaccuracy; YS = Fireclass.default.YInaccuracy;
		RMin = FireClass.default.TraceRange.Min; RMax = FireClass.default.TraceRange.Max;
		Start = Instigator.Location + Instigator.EyePosition();
		for (i=0;i<FireClass.default.TraceCount;i++)
		{
			mHitActor = None;
			Range = Lerp(FRand(), RMin, RMax);
			R = Rotator(mHitLocation);

			fX = frand();
			R.Yaw +=   XS * (frand()*2-1) * sin(fX*1.5707963267948966);
			R.Pitch += YS * (frand()*2-1) * cos(fX*1.5707963267948966);

//			R.Yaw += ((FRand()*XS*2)-XS);
//			R.Pitch += ((FRand()*YS*2)-YS);
			End = Start + Vector(R) * Range;
			mHitActor = Trace (HitLocation, mHitNormal, End, Start, false,, HitMat);
			if (mHitActor == None)
			{
				DoWaterTrace(Start, End);
				SpawnTracer(Mode, End);
			}
			else
			{
				DoWaterTrace(Start, HitLocation);
				SpawnTracer(Mode, HitLocation);
			}

			if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None))
				continue;

			if (HitMat == None)
				mHitSurf = int(mHitActor.SurfaceType);
			else
				mHitSurf = int(HitMat.SurfaceType);

			if (ImpactManager != None)
				ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, self);
		}
	}
}

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
		BrassClass = Class'Brass_MRT6Right';
		super.EjectBrass(Mode);
	}
	if (Mode == 0 || Mode == 1)
	{
		BrassBone = 'EjectorR';
		BrassClass = Class'Brass_MRT6Left';
		super.EjectBrass(Mode);
	}
}

function MRT6UpdateHit(Actor HitActor, vector HitLocation, vector HitNormal, int HitSurf, optional bool bIsRight)
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
     FireClass=Class'BallisticProV55.MRT6PrimaryFire'
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     AltFlashBone="tip2"
     FlashScale=1.800000
     BrassClass=Class'BallisticProV55.Brass_MRT6Left'
     BrassMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
     TracerChance=0.500000
     ReloadAnim="Reload_Pistol"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.500000
     CockAnimRate=1.400000
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.MRT6_TPm'
     DrawScale=0.250000
}
