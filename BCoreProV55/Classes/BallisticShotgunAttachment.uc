//=============================================================================
// BallisticShotgunAttachment.
//
// 3rd person weapon attachment for shotgun type weapons where multiple impacts
// are used.
//
// This works slightly differently from the usual. mHitNormal is used to set as
// the central aim dir of the shotgun and all the impact effects are positioned
// using the X/YInaccuracy and TraceRange of the shotgun fire class.
// Standalone and listenservers can just spawn the effects from the firemode's
// DoTrace code.
//
// Azarael: Replicates its aimed status for the Expanded Conefire implementation.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticShotgunAttachment extends BallisticAttachment
	DependsOn(FireEffectParams);

var	int XInaccuracy, YInaccuracy;

replication
{
	reliable if (Role == ROLE_Authority)
		XInaccuracy, YInaccuracy;
}

simulated final function int GetTraceCount()
{
	if (WeaponClass != None)
		return ShotgunEffectParams(WeaponClass.default.ParamsClasses[class'BallisticReplicationInfo'.default.GameStyle].default.Layouts[0].FireParams[0].FireEffectParams[0]).TraceCount;

	return 10;
}

simulated final function int GetTraceRange()
{
	if (WeaponClass != None)
		return InstantEffectParams(WeaponClass.default.ParamsClasses[class'BallisticReplicationInfo'.default.GameStyle].default.Layouts[0].FireParams[0].FireEffectParams[0]).TraceRange.Max;

	return 3000;
}

simulated final function FireEffectParams.FireSpreadMode GetSpreadMode()
{
	if (WeaponClass != None)
		return WeaponClass.default.ParamsClasses[class'BallisticReplicationInfo'.default.GameStyle].default.Layouts[0].FireParams[0].FireEffectParams[0].SpreadMode;

	return FSM_Circle;
}

// Do trace to find impact info and then spawn the effect
// This should be called from sub-classes
simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Start, End;
	local Rotator R;
	local Material HitMat;
	local int i;
	local float RMin, RMax, Range, fX;
	
	if (InstantMode == MU_None || (InstantMode == MU_Secondary && Mode != 1) || (InstantMode == MU_Primary && Mode != 0))
		return;

	if (mHitLocation == vect(0,0,0))
		return;

	if (Instigator == none)
		return;

	if (Level.NetMode == NM_Client)
	{	
		RMin = GetTraceRange(); 
		RMax = GetTraceRange();

		//log("BallisticShotgunAttachment: Client trace: XInacc "$XInaccuracy$", YInacc "$YInaccuracy);
		
		Start = Instigator.Location + Instigator.EyePosition();
		
		for (i=0; i < GetTraceCount(); i++)
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

defaultproperties
{
	 ReloadAnim="Reload_ShovelBottom"
	 CockingAnim="Cock_PumpSlow"
}
