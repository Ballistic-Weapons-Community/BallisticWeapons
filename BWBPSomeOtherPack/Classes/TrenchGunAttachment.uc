//=============================================================================
// TrenchGunAttachment.
//
// 3rd person weapon attachment
//=============================================================================
class TrenchGunAttachment extends BallisticShotgunAttachment;

const EXPLOSIVE_MODE = 0;
const SHOCK_MODE = 1;

enum TrenchBarrelMode
{
	TBM_Single,
	TBM_Double
};

var TrenchBarrelMode			BarrelMode;
var name						SingleBarrelAnim;
var name						SingleBarrelAimedAnim;

var bool						Side;

var() class<BCImpactManager>	ImpactManagerAlt;		//Impact Manager to use for iATLATmpact effects
var() class<BCTraceEmitter>		TracerClassAlt;		//Type of tracer to use for alt fire effects

var	Actor						MuzzleFlashRight;


replication
{
	// Things the server should send to the client.
	reliable if(Role==ROLE_Authority)
		BarrelMode;
}

//======================================================================
// PostNetReceive
//
// Listen for server firing events and perform effects
//======================================================================
simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
		
	if (DirectImpactCount != OldDirectImpactCount)
	{
		DoDirectHit(DirectImpact.HitLoc, class'BUtil'.static.ByteToNorm(DirectImpact.HitNorm), DirectImpact.HitSurf);
		OldDirectImpactCount = DirectImpactCount;
	}
	
	if (FireCount != OldFireCount)
	{
		FiringMode = EXPLOSIVE_MODE;
		ThirdPersonEffects();
		OldFireCount = FireCount;
	}
	
	if (AltFireCount != OldAltFireCount)
	{
		FiringMode = SHOCK_MODE;
		ThirdPersonEffects();
		OldAltFireCount = AltFireCount;
	}
}

//Called for a double shot
function DoubleUpdateHit(Actor HitActor, vector HitLocation, vector HitNormal, Actor sideHitActor, vector sideHitLocation, vector sideHitNormal, int HitSurf, int sideHitSurf, optional vector WaterHitLoc, optional vector sideWaterHitLoc)
{
	mHitSurf = HitSurf;
	mHitNormal = HitNormal;
	mHitActor = HitActor;
	mHitLocation = HitLocation;
	WaterHitLocation = WaterHitLoc;
	
	FireCount++;
	ThirdPersonEffects();
	
	mHitSurf = sideHitSurf;
	mHitNormal = sideHitNormal;
	mHitActor = sideHitActor;
	mHitLocation = sideHitLocation;
	WaterHitLocation = sideWaterHitLoc;
	
	FireCount++;
	NetUpdateTime = Level.TimeSeconds - 1;
	ThirdPersonEffects();
}

//======================================================================
// InstantFireEffects
//
// Switch animations, barrel used and fire effects based on shot type
//======================================================================
simulated function InstantFireEffects(byte Mode)
{
	if ( BarrelMode == TBM_Single )
	{
		SingleAimedFireAnim=SingleBarrelAimedAnim;
		SingleFireAnim=SingleBarrelAnim;
	}
	else
	{
		SingleAimedFireAnim=default.SingleAimedFireAnim;
		SingleFireAnim=default.SingleFireAnim;
	}
	
	if (Mode == SHOCK_MODE)
		ElectroFireEffects(Mode);
	else 
		ExplosiveFireEffects(Mode);
		
	Side = !Side;
}

//======================================================================
// ExplosiveFireEffects
//
// Spawn explosive effects on hit
//======================================================================
simulated function ExplosiveFireEffects(byte Mode)
{
	local Vector HitLocation, Start, End;
	local Rotator R;
	local Material HitMat;
	local int i;
	local float XS, YS, RMin, RMax, Range, fX;
	
	Log("ExplosiveFireEffects");
	
	if (mHitLocation == vect(0,0,0))
		return;

	if (Instigator == None)
		return;
		
	if (Level.NetMode == NM_Client && FireClass != None)
	{
		XS = FireClass.default.XInaccuracy; YS = Fireclass.default.YInaccuracy;
		
		if(!bScoped)
		{
			XS *= FireClass.static.GetAttachmentDispersionFactor();
			YS *= FireClass.static.GetAttachmentDispersionFactor();
		}
		
		RMin = FireClass.default.TraceRange.Min; RMax = FireClass.default.TraceRange.Max;
		
		Start = Instigator.Location + Instigator.EyePosition();
		
		for (i=0; i < FireClass.default.TraceCount; i++)
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
			mHitActor = Trace (HitLocation, mHitNormal, End, Start, true,, HitMat);
			
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
			
			if (mHitActor == None)
				continue;

			if (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && mHitActor.bProjTarget)
			{
				log("Spawning explosive effect");
				Spawn (class'IE_IncBulletMetal', ,, HitLocation,);
				continue;
			}

			if (HitMat == None)
				mHitSurf = int(mHitActor.SurfaceType);
			else
				mHitSurf = int(HitMat.SurfaceType);

			if (ImpactManager != None)
				ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, self);
		}
	}
}

//======================================================================
// ElectroFireEffects
//
// Use alternate impact manager
//======================================================================
simulated function ElectroFireEffects(byte Mode)
{
	local Vector HitLocation, Start, End;
	local Rotator R;
	local Material HitMat;
	local int i;
	local float XS, YS, RMin, RMax, Range, fX;
	
	if (mHitLocation == vect(0,0,0))
		return;
	if (Instigator == none)
		return;
	
	if (Level.NetMode == NM_Client && FireClass != None)
	{
		XS = FireClass.default.XInaccuracy; YS = Fireclass.default.YInaccuracy;
		
		if (!bScoped)
		{
			XS *= FireClass.static.GetAttachmentDispersionFactor();
			YS *= FireClass.static.GetAttachmentDispersionFactor();
		}
		
		RMin = FireClass.default.TraceRange.Min; RMax = FireClass.default.TraceRange.Max;
		
		Start = Instigator.Location + Instigator.EyePosition();
		
		for (i=0; i < FireClass.default.TraceCount; i++)
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

	Log("SpawnTracer");
	
	if (Level.DetailMode < DM_High || class'BallisticMod'.default.EffectsDetailMode == 0)
		return;

	TipLoc = GetTipLocation();
	Dist = VSize(V - TipLoc);

	// Spawn a tracer for the appropriate mode
	if (TracerClass != None)
	{
		if (Dist > 200)
		{
			if (Mode == EXPLOSIVE_MODE)
				Tracer = Spawn(TracerClass, self, , TipLoc, Rotator(V - TipLoc));
			else Tracer = Spawn(TracerClassAlt, self, , TipLoc, Rotator(V - TipLoc));
		}
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	// Spawn under water bullet effect
	if ( Instigator != None && Instigator.PhysicsVolume.bWaterVolume && level.DetailMode == DM_SuperHigh && WaterTracerClass != None &&
		 WaterTracerMode != MU_None && (WaterTracerMode == MU_Both || (WaterTracerMode == MU_Secondary && Mode == EXPLOSIVE_MODE) || (WaterTracerMode == MU_Primary && Mode != SHOCK_MODE)))
	{
		if (!Instigator.PhysicsVolume.TraceThisActor(WLoc, WNorm, TipLoc, V))
			Tracer = Spawn(WaterTracerClass, self, , TipLoc, Rotator(WLoc - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(VSize(WLoc - TipLoc));
	}
}

// Return the location of the muzzle.
simulated function Vector GetTipLocation()
{
    local Coords C;

	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
	{
		if (!Side)
			C = Instigator.Weapon.GetBoneCoords('tip');
		else C = Instigator.Weapon.GetBoneCoords('Tip2');
	}
	else
	{
		if (!Side)
			C = GetBoneCoords(FlashBone);
		else C = GetBoneCoords(AltFlashBone);
	}
	if (Instigator != None && level.NetMode != NM_StandAlone && level.NetMode != NM_ListenServer && VSize(C.Origin - Instigator.Location) > 300)
		return Instigator.Location;
    return C.Origin;
}

// This assumes flash actors are triggered to make them work
// Override this in subclassed for better control
simulated function FlashMuzzleFlash(byte Mode)
{
	local rotator R;

	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (bRandomFlashRoll)
		R.Roll = Rand(65536);

	if (Mode == 1 && AltMuzzleFlashClass != None)
	{
		if (AltMuzzleFlash == None)
		{
			if (!Side)
				class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
			else 
				class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
		}
		AltMuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(AltFlashBone, R, 0, 1.f);
	}
	else if (MuzzleFlashClass != None)
	{
		if(!Side)
		{
			if (MuzzleFlash == None)
				class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
			MuzzleFlash.Trigger(self, Instigator);
			if (bRandomFlashRoll)	SetBoneRotation(FlashBone, R, 0, 1.f);
		}
		else
		{
			if (MuzzleFlashRight == None)
				class'BUtil'.static.InitMuzzleFlash (MuzzleFlashRight, MuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
			MuzzleFlashRight.Trigger(self, Instigator);
			if (bRandomFlashRoll)	SetBoneRotation(AltFlashBone, R, 0, 1.f);
		}
	}
}

simulated function EjectBrass(byte Mode);

defaultproperties
{
	 TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_IncendiaryBullet'
	 
     TracerClassAlt=Class'BWBPRecolorsPro.TraceEmitter_Supercharge'
	 ImpactManagerAlt=Class'BWBPRecolorsPro.IM_Supercharge'
	 
	 MeleeImpactManager=Class'BallisticProV55.IM_GunHit'
	 
     FireClass=Class'BWBPSomeOtherPack.TrenchGunPrimaryFire'

     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     FlashBone="Tip1"
     AltFlashBone="tip2"
     FlashScale=1.500000
	 
	 InstantMode = MU_Both
	 
     BrassClass=Class'BallisticProV55.Brass_MRS138Shotgun'
	 
     TrackAnimMode=MU_None

     Mesh=SkeletalMesh'BWBPSomeOtherPackAnims.TechGun_Third'
     RelativeLocation=(X=5.000000,Z=4.000000)
     RelativeRotation=(Pitch=32768,Roll=-16384)
     DrawScale=0.450000
	 
 	 SingleFireAnim="Reload_BreakOpenFast"
     SingleAimedFireAnim="Reload_BreakOpenFast"
     RapidFireAnim="Reload_BreakOpenFast"
     RapidAimedFireAnim="Reload_BreakOpenFast"
	 ReloadAnim="Reload_BreakOpen"
	 CockingAnim="Reload_BreakOpen"
	 SingleBarrelAnim="RifleHip_Fire"
	 SingleBarrelAimedAnim="RifleAimed_Fire"
}
