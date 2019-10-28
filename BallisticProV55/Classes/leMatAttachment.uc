//=============================================================================
// leMatAttachment.
//
// ThirdPersonActor for the Wilson DB
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class leMatAttachment extends HandgunAttachment;

var   byte		RevolverBrass;
var() class<BallisticShotgunFire>	FireClass;


replication
{
	reliable if (Role == ROLE_Authority)
		RevolverBrass;
}

simulated event PostNetReceive()
{
	if (RevolverBrass > 0)
	{
		if (RevolverBrass > 127)
			RevolverBrass -= 128;
		RevolverEjectBrass(RevolverBrass);
		RevolverBrass = 0;
	}
	super.PostNetReceive();
}

simulated function InstantFireEffects(byte Mode)
{
	if (FiringMode != 0)
		ShotgunFireEffects(FiringMode);
	else
		Super.InstantFireEffects(FiringMode);
}

// Do trace to find impact info and then spawn the effect
// This should be called from sub-classes
simulated function ShotgunFireEffects(byte Mode)
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
			switch (FireClass.default.FireSpreadMode)
			{
				case FSM_Scatter:
					fX = frand();
					R.Yaw +=   XS * (frand()*2-1) * sin(fX*1.5707963267948966);
					R.Pitch += YS * (frand()*2-1) * cos(fX*1.5707963267948966);
					break;
				case FSM_Circle:
					fX = frand();
					R.Yaw +=   XS * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
					R.Pitch += YS * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
					break;
				default:
					R.Yaw += ((FRand()*XS*2)-XS);
					R.Pitch += ((FRand()*YS*2)-YS);
					break;
			}
			End = Start + Vector(R) * Range;
			mHitActor = Trace (HitLocation, mHitNormal, End, Start, false,, HitMat);
			if (mHitActor == None)
			{
				TracerClass = class<BCTraceEmitter>(FireClass.default.TracerClass);
				DoWaterTrace(Start, End);
				SpawnTracer(Mode, End);
				TracerClass = default.TracerClass;
			}
			else
			{
				TracerClass = class<BCTraceEmitter>(FireClass.default.TracerClass);
				DoWaterTrace(Start, HitLocation);
				SpawnTracer(Mode, HitLocation);
				TracerClass = default.TracerClass;
			}

			if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None))
				continue;

			if (HitMat == None)
				mHitSurf = int(mHitActor.SurfaceType);
			else
				mHitSurf = int(HitMat.SurfaceType);

			if (FireClass.default.ImpactManager != None)
				FireClass.default.ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, self);
		}
	}
}

simulated function RevolverEjectBrass(byte Num)
{
	local int i;
	local Rotator R;

	if (Role == ROLE_Authority)
	{
		if (RevolverBrass > 127)
			RevolverBrass = Num;
		else
			RevolverBrass = Num + 128;
	}
	if (level.NetMode == NM_DedicatedServer)
		return;
	if (Instigator!=None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;
	if (!class'BallisticMod'.default.bEjectBrass || Level.DetailMode < DM_High)
		return;
	if (Num >= 64)
	{
		Spawn(Class'Brass_leMatSG', self,, GetEjectorLocation(R)+VRand()*2, R);
		Num -= 64;
	}
	for (i=0;i<Num;i++)
		Spawn(BrassClass, self,, GetEjectorLocation(R)+VRand()*2, R);
}

simulated function EjectBrass(byte Mode);

simulated function FlashMuzzleFlash(byte Mode)
{
	local rotator R;

	if (bIsSlave)
		SlaveAlpha = 1.0;

	if (FlashMode == MU_None || (FlashMode == MU_Secondary && Mode == 0) || (FlashMode == MU_Primary && Mode != 0))
		return;
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (bRandomFlashRoll)
		R.Roll = Rand(65536);

	if (Mode != 0 && AltMuzzleFlashClass != None)
	{
		if (AltMuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*2.0, self, AltFlashBone);
		AltMuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(AltFlashBone, R, 0, 1.f);
	}
	else if (Mode == 0 && MuzzleFlashClass != None)
	{
		if (MuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*0.6, self, FlashBone);
		MuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(FlashBone, R, 0, 1.f);
	}
}

defaultproperties
{
     FireClass=Class'BallisticProV55.leMatSecondaryFire'
     MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     AltFlashBone="tip2"
     BrassClass=Class'BallisticProV55.Brass_Magnum'
     BrassBone="leMat-3rd"
     TracerMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'
     TracerChance=0.600000
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     Mesh=SkeletalMesh'BWBP4-Anims.leMat-3rd'
     DrawScale=0.125000
}
