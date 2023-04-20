//=============================================================================
// M50Attachment.
//
// 3rd person weapon attachment for M50 Assault Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CYLOFirestormAttachment extends BallisticAttachment;

var() class<BallisticShotgunFire>	ShotgunFireClass;
var bool	bShotgunMode;

simulated event PreBeginPlay()
{
	super.PreBeginPlay();
	if (class'BallisticReplicationInfo'.static.IsClassicOrRealism())
	{
		bShotgunMode=true;
		InstantMode=MU_Both;
	}
}

// Does all the effects for an instant-hit kind of fire.
// On the client, this uses mHitLocation to find all the other info needed.
simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Dir, Start;
	local Material HitMat;
	
	if (InstantMode == MU_None || (InstantMode == MU_Secondary && Mode == 0) || (InstantMode == MU_Primary && Mode != 0))
		return;
		
	if (mHitLocation == vect(0,0,0))
		return;
		
	if (Instigator == none)
		return;
		
	if (FiringMode == 1)
		ShotgunFireEffects(FiringMode);
	else
	{
		SpawnTracer(Mode, mHitLocation);
		FlyByEffects(Mode, mHitLocation);
		
		// Client, trace for hitnormal, hitmaterial and hitactor
		if (Level.NetMode == NM_Client)
		{
			mHitActor = None;
			Start = Instigator.Location + Instigator.EyePosition();

			if (WallPenetrates != 0)				
			{
				WallPenetrates = 0;
				DoWallPenetrate(Mode, Start, mHitLocation);	
			}

			Dir = Normal(mHitLocation - Start);
			mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir * 10, mHitLocation - Dir * 10, true,, HitMat); // CYLO needs to trace actors to find Pawns 
			
			// Check for water and spawn splash
			if (ImpactManager!= None && bDoWaterSplash)
				DoWaterTrace(Mode, Start, mHitLocation);

			if (mHitActor == None)
				return;

			// Set the hit surface type
			if (Vehicle(mHitActor) != None)
				mHitSurf = 3;
			else if (HitMat == None)
				mHitSurf = int(mHitActor.SurfaceType);
			else
				mHitSurf = int(HitMat.SurfaceType);
		}
		
		// Server has all the info already...
		else
			HitLocation = mHitLocation;

		if (level.NetMode != NM_Client && ImpactManager!= None && WaterHitLocation != vect(0,0,0) && bDoWaterSplash && Level.DetailMode >= DM_High && class'BallisticMod'.default.EffectsDetailMode > 0)
			ImpactManager.static.StartSpawn(WaterHitLocation, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLocation), 9, Instigator);
		
		if (mHitActor == None)
			return;
		
		if (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && mHitActor.bProjTarget)
		{
			Spawn (class'IE_IncBulletMetal', ,, HitLocation,);
			return;
		}
		
		if (ImpactManager != None)
			ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
	}
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

	if (Level.NetMode == NM_Client && ShotgunFireClass != None)
	{
		XS = ShotgunFireClass.default.XInaccuracy; YS = ShotgunFireClass.default.YInaccuracy;
		RMin = ShotgunFireClass.default.TraceRange.Min; RMax = ShotgunFireClass.default.TraceRange.Max;
		Start = Instigator.Location + Instigator.EyePosition();
		for (i=0;i<ShotgunFireClass.default.TraceCount;i++)
		{
			mHitActor = None;
			Range = Lerp(FRand(), RMin, RMax);
			R = Rotator(mHitLocation);
			switch (ShotgunFireClass.default.FireSpreadMode)
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
				TracerClass = class<BCTraceEmitter>(ShotgunFireClass.default.TracerClass);
				DoWaterTrace(Mode, Start, End);
				SpawnTracer(Mode, End);
				TracerClass = default.TracerClass;
			}
			else
			{
				TracerClass = class<BCTraceEmitter>(ShotgunFireClass.default.TracerClass);
				DoWaterTrace(Mode, Start, HitLocation);
				SpawnTracer(Mode, HitLocation);
				TracerClass = default.TracerClass;
			}

			if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None))
				continue;

			if (HitMat == None)
				mHitSurf = int(mHitActor.SurfaceType);
			else
				mHitSurf = int(HitMat.SurfaceType);

			if (ShotgunFireClass.default.ImpactManager != None)
				ShotgunFireClass.default.ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, self);
		}
	}
}

defaultproperties
{
	WeaponClass=class'CYLOFirestormAssaultWeapon'
     MuzzleFlashClass=Class'BWBP_SKC_Pro.AH104FlashEmitter'
     AltMuzzleFlashClass=class'M50M900FlashEmitter'
	 ShotgunFireClass=Class'BWBP_SKC_Pro.CYLOFirestormSecondaryShotgunFire'
     ImpactManager=Class'IM_IncendiaryBullet'
     MeleeImpactManager=class'IM_Knife'
     AltFlashBone="tip2"
     FlashScale=0.300000
     BrassClass=class'Brass_Rifle'
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Incendiary'
     WaterTracerClass=class'TraceEmitter_WaterBullet'
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnimRate=0.800000
     bHeavy=True
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_SKC_Anim.CYLOFirestorm_TPm'
     RelativeLocation=(Z=1.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.300000
}
