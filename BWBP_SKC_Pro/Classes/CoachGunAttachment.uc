//=============================================================================
// CoachGunAttachment.
//
// 3rd person weapon attachment
//=============================================================================
class CoachGunAttachment extends BallisticShotgunAttachment;

const SHOT_AMMO = 0;
const SLUG_AMMO = 1;
const ZAP_AMMO = 2;
const FLAME_AMMO = 3;
const HE_AMMO = 4;
const FRAG_AMMO = 5;

var bool						Side;
var byte						AmmoType;

var array< class<BCTraceEmitter> >	TracerClasses[6]; //0-shot,1-slug,2-zap,3-flame,4-he
var array< class<BCImpactManager> >	ImpactManagers[6];

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
	local float RMin, RMax, Range, fX;
	
	ShotCount = IsDoubleFire + 1;
	
	if (mHitLocation == vect(0,0,0))
		return;

	if (Instigator == None)
		return;
		
	if (Level.NetMode == NM_Client)
	{	
		RMin = GetTraceRange(); RMax = GetTraceRange();
		
		Start = Instigator.Location + Instigator.EyePosition();
		
		for (i=0; i < GetTraceCount() * ShotCount; i++)
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

			if (ImpactManagers[AmmoType] != None)
				ImpactManagers[AmmoType].static.StartSpawn(HitLocation, mHitNormal, mHitSurf, self);
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
	if (TracerClasses[AmmoType] != None)
	{
		if (Dist > 200)
		{
			Tracer = Spawn(TracerClasses[AmmoType], self, , TipLoc, Rotator(V - TipLoc));
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
	TracerClasses(0)=class'TraceEmitter_Shotgun' //shot
	TracerClasses(1)=class'TraceEmitter_X83AM' //super slug
	TracerClasses(2)=class'TraceEmitter_Supercharge' //zap
	TracerClasses(3)=class'TraceEmitter_ShotgunFlame' //flame
	TracerClasses(4)=class'TraceEmitter_Shotgun' //he
	TracerClasses(5)=None //frag
	ImpactManagers(0)=class'IM_Shell' //shot
	ImpactManagers(1)=class'IM_ExpBullet' //super slug
	ImpactManagers(2)=class'IM_Shell' //zap
	ImpactManagers(3)=class'IM_ShellHE' //flame
	ImpactManagers(4)=class'IM_ShellHE' //he
	ImpactManagers(5)=None //frag
	
    TracerClass=class'TraceEmitter_Shotgun'
    ImpactManager=class'IM_Shell'

    MeleeImpactManager=class'IM_GunHit'

    WeaponClass=Class'CoachGun'
    MuzzleFlashClass=class'MRT6FlashEmitter'
    FlashBone="Tip1"
    AltFlashBone="tip2"
    FlashScale=1.500000

    InstantMode = MU_Both

    BrassClass=class'Brass_MRS138Shotgun'

    TrackAnimMode=MU_None

    Mesh=SkeletalMesh'BWBP_SKC_Anim.Coachgun_TPm'
    RelativeLocation=(X=5.000000,Z=4.000000)
    RelativeRotation=(Pitch=32768)
    DrawScale=0.450000

    ReloadAnim="Reload_BreakOpen"
    CockingAnim="Reload_BreakOpen"
}
