//=============================================================================
// CYLOAttachment.
//
// 3rd person weapon attachment for CYLO Versitile UAW
// This thing is a CHONKY BOY. It supports like 5 fire types guh
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CYLOAttachment extends BallisticAttachment;

var byte CurrentTracerMode;
var byte CurrentAltTracerMode;
var array< class<BCTraceEmitter> >	TracerClasses[3];
var array< class<BCImpactManager> >	ImpactManagers[3];
var array< class<BCTraceEmitter> >	AltTracerClasses[3];
var array< class<BCImpactManager> >	AltImpactManagers[3];
var() class<BallisticShotgunFire>	FireClass;
var	  BallisticWeapon		myWeap;

replication
{
	reliable if ( Role==ROLE_Authority )
		CurrentTracerMode, CurrentAltTracerMode;
}

function InitFor(Inventory I)
{
	Super.InitFor(I);

	if (BallisticWeapon(I) != None)
		myWeap = BallisticWeapon(I);
	if (CYLOUAW(I) != None)
	{
		if (CYLOUAW(I).bExplosive) //incendiary
		{
			CurrentTracerMode=1;
			CurrentAltTracerMode=1;
		}
		if (CYLOUAW(I).bExplosiveOnPlayers) //explosive
		{
			CurrentTracerMode=2;
			CurrentAltTracerMode=1;
		}
		if (CYLOUAW(I).bSlugger) //no alt tracer
		{
			CurrentAltTracerMode=2;
		}
	}
}

simulated function InstantFireEffects(byte Mode)
{

	local Vector HitLocation, Dir, Start;
	local Material HitMat;
	
	if (FiringMode == 1 && CurrentAltTracerMode != 2)
	{
		ShotgunFireEffects(FiringMode);
		return;
	}

	Mode = Min(Mode, 1);

	if (!ModeInfos[Mode].bInstant)
		return;
	if (mHitLocation == vect(0,0,0))
		return;
	if (Instigator == none)
		return;

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
		mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir*10, mHitLocation - Dir*10, false,, HitMat);
		// Check for water and spawn splash
		if (ImpactManagers[CurrentTracerMode] != None && bDoWaterSplash)
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

	if (level.NetMode != NM_Client && ModeInfos[Mode].ImpactManager != None && WaterHitLocation != vect(0,0,0) && bDoWaterSplash && Level.DetailMode >= DM_High && class'BallisticMod'.default.EffectsDetailMode > 0)
		ModeInfos[Mode].ImpactManager.static.StartSpawn(WaterHitLocation, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLocation), 9, Instigator);
	if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && Vehicle(mHitActor) == None))
		return;
	if (ImpactManagers[CurrentTracerMode] != None)
		ImpactManagers[CurrentTracerMode].static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
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
		if(!bIsAimed)
		{
			XS *= 2.5;
			YS *= 2.5;
		}
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
				DoWaterTrace(Mode, Start, End);
				SpawnAltTracer(Mode, End);
			}
			else
			{
				DoWaterTrace(Mode, Start, HitLocation);
				SpawnAltTracer(Mode, HitLocation);
			}

			if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None))
				continue;

			if (HitMat == None)
				mHitSurf = int(mHitActor.SurfaceType);
			else
				mHitSurf = int(HitMat.SurfaceType);

			if (AltImpactManagers[CurrentTracerMode] != None)
				AltImpactManagers[CurrentTracerMode].static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
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

	TipLoc = GetModeTipLocation(Mode);
	Dist = VSize(V - TipLoc);

	// Count shots to determine if it's time to spawn a tracer
	if (ModeInfos[Mode].TracerMix == 0)
		bThisShot=true;
	else
	{
		ModeInfos[Mode].TracerCounter++;
		if (TracerMix < 0)
		{
			if (ModeInfos[Mode].TracerCounter >= -ModeInfos[Mode].TracerMix)	{
				ModeInfos[Mode].TracerCounter = 0;
				bThisShot=false;			}
			else
				bThisShot=true;
		}
		else if (ModeInfos[Mode].TracerCounter >= ModeInfos[Mode].TracerMix)	{
			ModeInfos[Mode].TracerCounter = 0;
			bThisShot=true;					}
	}
	// Spawn a tracer
	if (ModeInfos[Mode].bTracer && TracerClasses[CurrentTracerMode] != None &&
		bThisShot && (ModeInfos[Mode].TracerChance >= 1 || FRand() < ModeInfos[Mode].TracerChance))
	{
		if (Dist > 200)
			Tracer = Spawn(TracerClasses[CurrentTracerMode], self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	// Spawn under water bullet effect
	if ( Instigator != None && Instigator.PhysicsVolume.bWaterVolume && level.DetailMode == DM_SuperHigh 
    && ModeInfos[Mode].WaterTracerClass != None && ModeInfos[Mode].bWaterTracer)
	{
		if (!Instigator.PhysicsVolume.TraceThisActor(WLoc, WNorm, TipLoc, V))
			Tracer = Spawn(ModeInfos[Mode].WaterTracerClass, self, , TipLoc, Rotator(WLoc - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(VSize(WLoc - TipLoc));
	}
}

// Spawn the shotgun's tracers
simulated function SpawnAltTracer(byte Mode, Vector V)
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
	if (AltTracerClasses[CurrentTracerMode] != None && TracerMode != MU_None && (TracerMode == MU_Both || (TracerMode == MU_Secondary && Mode != 0) || (TracerMode == MU_Primary && Mode == 0)) &&
		bThisShot && (Mode == 1 || TracerChance >= 1 || FRand() < TracerChance))
	{
		if (Mode == 0)
		{
			if (Dist > 200)
				Tracer = Spawn(AltTracerClasses[CurrentTracerMode], self, , TipLoc, Rotator(V - TipLoc));

				if (Tracer != None)
				Tracer.Initialize(Dist);
		}

		else
			Tracer = Spawn(AltTracerClasses[2], self, , TipLoc, Rotator(V - TipLoc));
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

simulated function FlashMuzzleFlash(byte Mode)
{
	local rotator R;


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
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*1.0, self, FlashBone);
		MuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(FlashBone, R, 0, 1.f);
	}
}

defaultproperties
{
	WeaponClass=class'CYLOUAW'
	FireClass=class'CYLOSecondaryFire'
	TracerClasses(0)=class'TraceEmitter_Default' //bullet
	TracerClasses(1)=class'TraceEmitter_Incendiary' //inc
	TracerClasses(2)=class'TraceEmitter_Incendiary' //inc
	ImpactManagers(0)=class'IM_Bullet'
	ImpactManagers(1)=class'IM_IncendiaryHMGBullet' //incendiary
	ImpactManagers(2)=class'IM_IncendiaryBullet' //explosive
	AltTracerClasses(0)=class'TraceEmitter_Shotgun'
	AltTracerClasses(1)=class'TraceEmitter_ShotgunFlameLight'
	AltImpactManagers(0)=class'IM_Shell'
	AltImpactManagers(1)=class'IM_ShellHE'
	MuzzleFlashClass=class'M50FlashEmitter'
	AltMuzzleFlashClass=class'M50M900FlashEmitter'
	ImpactManager=class'IM_Bullet'
	MeleeImpactManager=class'IM_Knife'
	AltFlashBone="tip2"
	BrassClass=class'Brass_Shotgun'
	BrassMode=MU_Secondary
	FlashMode=MU_Both
	LightMode=MU_Both
	TracerClass=class'TraceEmitter_Default'
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
	bHeavy=True
	bRapidFire=True
	Mesh=SkeletalMesh'BWBP_SKC_Anim.TPm_CYLOUAW'
	RelativeLocation=(Z=1.000000)
	RelativeRotation=(Pitch=32768)
	DrawScale=0.300000
}
