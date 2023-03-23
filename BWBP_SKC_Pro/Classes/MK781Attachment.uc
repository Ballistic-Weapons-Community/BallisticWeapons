//=============================================================================
// Mk781Attachment.
//
// 3rd person weapon attachment for M781 Shotgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MK781Attachment extends BallisticShotgunAttachment;

var() class<BallisticShotgunFire>	FireClassAlt;
var() class<BCImpactManager>ImpactManagerAlt;		//Impact Manager to use for iATLATmpact effects
var() class<BCTraceEmitter>	TracerClassAlt;		//Type of tracer to use for alt fire effects
var bool		bSilenced;
var bool		bOldSilenced;

replication
{
	// Things the server should send to the client.
	reliable if(Role==ROLE_Authority)
		bSilenced;
}


simulated event PostNetReceive()
{
	if (bSilenced != bOldSilenced)
	{
		bOldSilenced = bSilenced;
		if (bSilenced)
			SetBoneScale (0, 1.0, 'Muzzle2');
		else
			SetBoneScale (0, 0.0, 'Muzzle2');
	}
	Super.PostNetReceive();
}

function SetSilenced(bool bIsSilenced)
{
	bSilenced = bIsSilenced;
	if (bSilenced)
		SetBoneScale (0, 1.0, 'Muzzle2');
	else
		SetBoneScale (0, 0.0, 'Muzzle2');
}

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneScale (0, 0.0, 'Muzzle2');
}

// Do trace to find impact info and then spawn the effect
// This should be called from sub-classes
simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Start, End;
	local Rotator R;
	local Material HitMat;
	local int i;
	local float XS, YS, RMin, RMax, Range, fX;

	if (Level.NetMode == NM_Client && Mode == 0)
	{
		RMin = GetTraceRange(); RMax = GetTraceRange();
		Start = Instigator.Location + Instigator.EyePosition();
		for (i=0;i<GetTraceCount();i++)
		{
			mHitActor = None;
			Range = Lerp(FRand(), RMin, RMax);
			R = Rotator(mHitLocation);
			switch (GetSpreadMode())
			{
				case FSM_Scatter:
					fX = frand();
					R.Yaw +=   XInaccuracy * (frand()*2-1) * sin(fX*1.5707963267948966);
					R.Pitch += YInaccuracy * (frand()*2-1) * cos(fX*1.5707963267948966);
					break;
				case FSM_Circle:
					fX = frand();
					R.Yaw +=   XInaccuracy * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
					R.Pitch += YInaccuracy * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
					break;
				default:
					R.Yaw += ((FRand()*XInaccuracy*2)-XInaccuracy);
					R.Pitch += ((FRand()*YInaccuracy*2)-YInaccuracy);
					break;
			}
			End = Start + Vector(R) * Range;
			mHitActor = Trace (HitLocation, mHitNormal, End, Start, false,, HitMat);
			if (mHitActor == None)
			{
				DoWaterTrace(Mode, Start, End);
				SpawnTracer(Mode, End);
			}
			else
			{
				DoWaterTrace(Mode, Start, HitLocation);
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
	
	if (Level.NetMode == NM_Client && FireClassAlt != None && Mode == 1 && !bSilenced)
	{
		XS = FireClassAlt.default.XInaccuracy; YS = FireclassAlt.default.YInaccuracy;

		RMin = FireClassAlt.default.TraceRange.Min; RMax = FireClassAlt.default.TraceRange.Max;
		Start = Instigator.Location + Instigator.EyePosition();
		for (i=0;i<FireClassAlt.default.TraceCount;i++)
		{
			mHitActor = None;
			Range = Lerp(FRand(), RMin, RMax);
			R = Rotator(mHitLocation);
			switch (FireClassAlt.default.FireSpreadMode)
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
				DoWaterTrace(Mode, Start, End);
				SpawnTracer(Mode, End);
			}
			else
			{
				DoWaterTrace(Mode, Start, HitLocation);
				SpawnTracer(Mode, HitLocation);
			}

			if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None))
				continue;

			if (HitMat == None)
				mHitSurf = int(mHitActor.SurfaceType);
			else
				mHitSurf = int(HitMat.SurfaceType);

			if (ImpactManagerAlt != None)
				ImpactManagerAlt.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, self);
		}
	}
	
}

// Spawn a tracer and water tracer
simulated function SpawnTracer(byte Mode, Vector V)
{
	local BCTraceEmitter Tracer;
	local Vector TipLoc, WLoc, WNorm;
	local float Dist;
	local bool bThisShot;

	if (Level.DetailMode < DM_High || class'BallisticMod'.default.EffectsDetailMode == 0)
		return;

	TipLoc = GetModeTipLocation();
	Dist = VSize(V - TipLoc);

	// Count shots to determine if it's time to spawn a tracer
	if (TracerMix == 0)
		bThisShot=true;
	else
	{
		TracerCounter++;
		if (TracerMix < 0)
		{
			if (TracerCounter >= -TracerMix)	{
				TracerCounter = 0;
				bThisShot=false;			}
			else
				bThisShot=true;
		}
		else if (TracerCounter >= TracerMix)	{
			TracerCounter = 0;
			bThisShot=true;					}
	}
	// Spawn a tracer
	if (TracerClass != None && TracerMode != MU_None && (TracerMode == MU_Both && Mode == 0) &&
		bThisShot && (TracerChance >= 1 || FRand() < TracerChance) && !bSilenced)
	{
		if (Dist > 200)
			Tracer = Spawn(TracerClass, self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	// Spawn an alt tracer
	if (TracerClassAlt != None && !bSilenced && TracerMode != MU_None && (TracerMode == MU_Both && Mode != 0) && (TracerChance >= 1 || FRand() < TracerChance))
	{
		if (Dist > 200)
			Tracer = Spawn(TracerClassAlt, self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	// Spawn under water bullet effect
	if ( Instigator != None && Instigator.PhysicsVolume.bWaterVolume && level.DetailMode == DM_SuperHigh && WaterTracerClass != None &&
		 WaterTracerMode != MU_None && (WaterTracerMode == MU_Both || (WaterTracerMode == MU_Secondary && Mode != 0) || (WaterTracerMode == MU_Primary && Mode == 0)))
	{
		if (!Instigator.PhysicsVolume.TraceThisActor(WLoc, WNorm, TipLoc, V))
			Tracer = Spawn(WaterTracerClass, self, , TipLoc, Rotator(WLoc - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(VSize(WLoc - TipLoc));
	}
}


simulated function FlashMuzzleFlash(byte Mode)
{
	if (FlashMode == MU_None || (FlashMode == MU_Secondary && Mode == 0) || (FlashMode == MU_Primary && Mode != 0))
		return;
	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (Mode != 0 && AltMuzzleFlashClass != None)
	{
		if (AltMuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*0.6, self, AltFlashBone);
		AltMuzzleFlash.Trigger(self, Instigator);
	}
	else if (Mode == 0 && MuzzleFlashClass != None)
	{
		if (MuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
		MuzzleFlash.Trigger(self, Instigator);
	}
}

// Return the location of the muzzle.
simulated function Vector GetModeTipLocation(optional byte Mode)
{
    local Coords C;
	
	if (!bSilenced)
		return Super.GetModeTipLocation();

	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		C = Instigator.Weapon.GetBoneCoords('tip2');
	else
		C = GetBoneCoords('tip2');

    return C.Origin;
}

defaultproperties
{
     FireClassAlt=Class'BWBP_SKC_Pro.MK781SecondaryFire'
     ImpactManagerAlt=Class'BWBP_SKC_Pro.IM_Supercharge'
     TracerClassAlt=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
     WeaponClass=Class'BWBP_SKC_Pro.MK781Shotgun'
     MuzzleFlashClass=Class'BWBP_SKC_Pro.MK781FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     FlashScale=1.800000
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     BrassMode=MU_Both
     TracerMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Flechette'
     Mesh=SkeletalMesh'BWBP_SKC_Anim.MK781_TPm'
     RelativeRotation=(Pitch=32768)
     DrawScale=0.500000
     PrePivot=(Z=-5.000000)
     Skins(0)=Texture'BWBP_SKC_Tex.M1014.M1014-Misc'
}
