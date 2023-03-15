//=============================================================================
// SawnOffAttachment.
//
// 3rd person weapon attachment
//=============================================================================
class SawnOffAttachment extends BallisticShotgunAttachment;

const SHOT_AMMO = 0;
const SLUG_AMMO = 1;

var bool						Side;
var byte						AmmoType;

var() class<BCImpactManager>    ImpactManagerAlt;		//Impact Manager to use for iATLATmpact effects
var() class<BCTraceEmitter>	    TracerClassAlt;		    //Type of tracer to use for alt fire effects

var	Actor	MuzzleFlashRight;

replication
{
	// Things the server should send to the client.
	reliable if (Role == ROLE_Authority)
		AmmoType;
}

//======================================================================
// InitFor
//
// Sets initial shot mode on attachment to pawn
//======================================================================
function InitFor(Inventory I)
{
	Super.InitFor(I);
	
	AmmoType = BallisticWeapon(I).CurrentWeaponMode;
}

//======================================================================
// SwitchWeaponMode
//
// Called when weapon changes shot mode
//======================================================================
function SwitchWeaponMode(byte WeaponMode)
{
	AmmoType = WeaponMode;
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
		DoDirectHit(0, DirectImpact.HitLoc, class'BUtil'.static.ByteToNorm(DirectImpact.HitNorm), DirectImpact.HitSurf);
		OldDirectImpactCount = DirectImpactCount;
	}
	
	// SINGLE FIRE
	if (FireCount != OldFireCount)
	{
		FiringMode = 0;
		ThirdPersonEffects();
		OldFireCount = FireCount;
	}
	
	// DOUBLE FIRE
	if (AltFireCount != OldAltFireCount)
	{
		FiringMode = 1;
		ThirdPersonEffects();
		OldAltFireCount = AltFireCount;
	}
}

//======================================================================
// InstantFireEffects
//
// Switch animations, barrel used and fire effects based on shot type
//======================================================================
simulated function InstantFireEffects(byte IsDoubleFire)
{
	if (IsDoubleFire == 0)
	{
		SingleFireAnim 		= 	'RifleHip_Fire';
		SingleAimedFireAnim	=	'RifleAimed_Fire';
	}
	else
	{
		SingleAimedFireAnim	= default.SingleAimedFireAnim;
		SingleFireAnim		= default.SingleFireAnim;
	}
	
	if (AmmoType == SLUG_AMMO)
		SlugFireEffects(IsDoubleFire);
	else 
		ShotFireEffects(IsDoubleFire);
}

//======================================================================
// ShotFireEffects
//
// Spawn shotgun tracers
//======================================================================
simulated function ShotFireEffects(byte IsDoubleFire)
{
	local Vector HitLocation, Start, End;
	local Rotator R;
	local Material HitMat;
	local int i, j, ShotCount;
	local float XS, YS, RMin, RMax, Range, fX;
	
	ShotCount = IsDoubleFire + 1;
	
	if (mHitLocation == vect(0,0,0))
		return;

	if (Instigator == None)
		return;
		
	if (Level.NetMode == NM_Client && FireClass != None)
	{
		if (IsDoubleFire == 0)
		{
			XS = class'SawnOffPrimaryFire'.default.ShotInaccuracy.X; 
			YS = class'SawnOffPrimaryFire'.default.ShotInaccuracy.Y;
		}
		else 
		{
			XS = class'SawnOffPrimaryFire'.default.ShotDoubleInaccuracy.X; 
			YS = class'SawnOffPrimaryFire'.default.ShotDoubleInaccuracy.Y;
		}
		
		if(!bScoped)
		{
			XS *= FireClass.static.GetAttachmentDispersionFactor();
			YS *= FireClass.static.GetAttachmentDispersionFactor();
		}
		
		RMin = FireClass.default.TraceRange.Min; RMax = FireClass.default.TraceRange.Max;
		
		Start = Instigator.Location + Instigator.EyePosition();
		
		for (i=0; i < FireClass.default.TraceCount * ShotCount; i++)
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
				DoWaterTrace(0, Start, End);
				
				for (j = 0; j < ShotCount; ++j)
				{
					SpawnTracer(IsDoubleFire, End);
					Side = !Side;
				}
			}
			else
			{
				DoWaterTrace(0, Start, HitLocation);
				
				for (j = 0; j < ShotCount; ++j)
				{
					SpawnTracer(IsDoubleFire, HitLocation);
					Side = !Side;
				}
			}
			
			if (mHitActor == None)
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

//======================================================================
// SlugFireEffects
//
// Use alternate impact manager
//======================================================================
simulated function SlugFireEffects(byte IsDoubleFire)
{
	local Vector HitLocation, Start, End;
	local Rotator R;
	local Material HitMat;
	local int i, j, ShotCount;
	local float XS, YS, RMin, RMax, Range, fX;
	
	ShotCount = IsDoubleFire + 1;
	
	if (mHitLocation == vect(0,0,0))
		return;
	if (Instigator == none)
		return;
	
	if (Level.NetMode == NM_Client && FireClass != None)
	{
		if (IsDoubleFire == 0)
		{
			XS = class'SawnOffPrimaryFire'.default.SlugInaccuracy.X; 
			YS = class'SawnOffPrimaryFire'.default.SlugInaccuracy.Y;
		}
		else 
		{
			XS = class'SawnOffPrimaryFire'.default.SlugDoubleInaccuracy.X; 
			YS = class'SawnOffPrimaryFire'.default.SlugDoubleInaccuracy.Y;
		}
		
		RMin = FireClass.default.TraceRange.Min; RMax = FireClass.default.TraceRange.Max;
		
		Start = Instigator.Location + Instigator.EyePosition();
		
		for (i=0; i < ShotCount; i++)
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
				DoWaterTrace(0, Start, End);
				
				for (j = 0; j < ShotCount; ++j)
				{
					SpawnTracer(IsDoubleFire, End);
					Side = !Side;
				}
			}
			else
			{
				DoWaterTrace(0, Start, HitLocation);
				
				for (j = 0; j < ShotCount; ++j)
				{
					SpawnTracer(IsDoubleFire, HitLocation);
					Side = !Side;
				}
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
simulated function SpawnTracer(byte IsDoubleFire, Vector V)
{
	local BCTraceEmitter Tracer;
	local Vector TipLoc, WLoc, WNorm;
	local float Dist;

	if (Level.DetailMode < DM_High || class'BallisticMod'.default.EffectsDetailMode == 0)
		return;

	TipLoc = GetModeTipLocation();
	Dist = VSize(V - TipLoc);

	// Spawn a tracer for the appropriate mode
	if (TracerClass != None)
	{
		if (Dist > 200)
		{
			if (AmmoType == SHOT_AMMO)
				Tracer = Spawn(TracerClass, self, , TipLoc, Rotator(V - TipLoc));
			else Tracer = Spawn(TracerClassAlt, self, , TipLoc, Rotator(V - TipLoc));
		}
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	// Spawn under water bullet effect
	if ( Instigator != None && Instigator.PhysicsVolume.bWaterVolume && level.DetailMode == DM_SuperHigh && WaterTracerClass != None &&
		 WaterTracerMode != MU_None && (WaterTracerMode == MU_Both || (WaterTracerMode == MU_Secondary && AmmoType == SHOT_AMMO) || (WaterTracerMode == MU_Primary && AmmoType != SLUG_AMMO)))
	{
		if (!Instigator.PhysicsVolume.TraceThisActor(WLoc, WNorm, TipLoc, V))
			Tracer = Spawn(WaterTracerClass, self, , TipLoc, Rotator(WLoc - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(VSize(WLoc - TipLoc));
	}
}

// Return the location of the muzzle.
simulated function Vector GetModeTipLocation(optional byte Mode)
{
    local Coords C;

	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
	{
		if (!Side)
			return Instigator.Weapon.GetBoneCoords('tip').Origin;
		return Instigator.Weapon.GetBoneCoords('Tip2').Origin;
	}
	else
	{
		if (!Side)
			C = GetBoneCoords(FlashBone);
		else 
			C = GetBoneCoords(AltFlashBone);
	}

    return C.Origin;
}

// This assumes flash actors are triggered to make them work
// Override this in subclassed for better control
simulated function FlashMuzzleFlash(byte IsDoubleFire)
{
	local rotator R;

	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (bRandomFlashRoll)
		R.Roll = Rand(65536);

	if (AmmoType == 1 && AltMuzzleFlashClass != None)
	{
		if (AltMuzzleFlash == None)
		{
			if (!Side)
				class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
			else 
				class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
		}

		AltMuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)
            SetBoneRotation(AltFlashBone, R, 0, 1.f);
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
			if (bRandomFlashRoll)
                SetBoneRotation(AltFlashBone, R, 0, 1.f);
		}
	}
}

simulated function EjectBrass(byte Mode);

defaultproperties
{
    TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
    ImpactManager=Class'BallisticProV55.IM_Shell'
    TracerClassAlt=Class'BWBP_SKC_Pro.TraceEmitter_X83AM'
    ImpactManagerAlt=Class'BWBP_SKC_Pro.IM_ExpBullet'
    MeleeImpactManager=Class'BallisticProV55.IM_GunHit'
    FireClass=Class'BWBP_SKC_Pro.SawnOffPrimaryFire'
    MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
    FlashBone="Tip"
    AltFlashBone="tip2"
    FlashScale=1.500000
    InstantMode = MU_Both
    BrassClass=Class'BallisticProV55.Brass_MRS138Shotgun'
    TrackAnimMode=MU_None
    Mesh=SkeletalMesh'BWBP_SKC_AnimExp.ScifiSawnOff_TPm'
    DrawScale=0.150000
    SingleFireAnim="Reload_BreakOpenFast"
    SingleAimedFireAnim="Reload_BreakOpenFast"
    RapidFireAnim="RifleHip_Fire"
    RapidAimedFireAnim="RifleAimed_Fire"
    ReloadAnim="Reload_BreakOpen"
    CockingAnim="Reload_BreakOpen"
}
