//=============================================================================
// M763Attachment.
//
// 3rd person weapon attachment for M763 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M763Attachment extends BallisticShotgunAttachment
	DependsOn(M763GasControl);

var class<BCTraceEmitter> AltTracerClass;

// Do trace to find impact info and then spawn the effect
// This should be called from sub-classes
simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Start, End;
	local Rotator R;
	local Material HitMat;
	local int i;
	local float  RMin, RMax, Range, fX;

	if (Mode == 1)
	{
		GasShotFX();
		return;
	}
	
	if (Level.NetMode == NM_Client)
	{
		RMin = GetTraceRange(); RMax = GetTraceRange();

		Start = Instigator.Location + Instigator.EyePosition();

		for (i = 0; i < GetTraceCount(); i++)
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
}

// Does all the effects for an instant-hit kind of fire.
// On the client, this uses mHitLocation to find all the other info needed.
simulated function GasShotFX()
{
	if (mHitLocation == vect(0,0,0) || Instigator == none)
		return;

	SpawnTracer(1, mHitLocation);
	FlyByEffects(1, mHitLocation);

}

// Spawn a tracer and water tracer

simulated function SpawnTracer(byte Mode, Vector V)
{
	local BCTraceEmitter Tracer;
	local Vector TipLoc, WLoc, WNorm;
	local float Dist;
	local bool bThisShot;


	if (class'BallisticMod'.default.EffectsDetailMode == 0 && Mode == 0)

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
	if (TracerClass != None && TracerMode != MU_None && (TracerMode == MU_Both || (TracerMode == MU_Secondary && Mode != 0) || (TracerMode == MU_Primary && Mode == 0)) &&
		bThisShot && (Mode == 1 || TracerChance >= 1 || FRand() < TracerChance))

	{
		if (Mode == 0)
		{
			if (Dist > 200)
				Tracer = Spawn(TracerClass, self, , TipLoc, Rotator(V - TipLoc));

				if (Tracer != None)
				Tracer.Initialize(Dist);
		}

		else
			Tracer = Spawn(AltTracerClass, self, , TipLoc, Rotator(V - TipLoc));
	}
	// Spawn under water bullet effect
	if ( Mode == 0 && Instigator != None && Instigator.PhysicsVolume.bWaterVolume && level.DetailMode == DM_SuperHigh && WaterTracerClass != None &&
		 WaterTracerMode != MU_None && (WaterTracerMode == MU_Both || (WaterTracerMode == MU_Secondary && Mode != 0) || (WaterTracerMode == MU_Primary && Mode == 0)))
	{
		if (!Instigator.PhysicsVolume.TraceThisActor(WLoc, WNorm, TipLoc, V))
			Tracer = Spawn(WaterTracerClass, self, , TipLoc, Rotator(WLoc - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(VSize(WLoc - TipLoc));

	}
}

defaultproperties
{
     AltTracerClass=Class'BallisticProV55.TraceEmitter_M763Gas'
     WeaponClass=Class'BallisticProV55.M763Shotgun'
     MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     MeleeImpactManager=Class'BallisticProV55.IM_GunHit'
     FlashScale=1.800000
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     TracerMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     TracerChance=0.500000
     MeleeStrikeAnim="Melee_swing"
     SingleFireAnim="RifleHip_FireCock"
     SingleAimedFireAnim="RifleAimed_FireCock"
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.M763_TPm'
     DrawScale=0.080000
}
