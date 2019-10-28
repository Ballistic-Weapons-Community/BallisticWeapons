//=============================================================================
// Xk2Attachment.
//
// 3rd person weapon attachment for XK2 SMG
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XK2Attachment extends BallisticAttachment;

var int IceFireCount, OldIceFireCount;
var() class<BCTraceEmitter>	IceTracerClass;	//Emitter to sue for under water tracer
var() class<BCImpactManager>	IceImpactManager;

replication
{
	reliable if (Role == ROLE_Authority)
		IceFireCount;
}

function IceUpdateHit(Actor HitActor, vector HitLocation, vector HitNormal, int HitSurf, optional bool bIsAlt, optional vector WaterHitLoc)
{
	mHitSurf = HitSurf;
	WaterHitLocation = WaterHitLoc;
	mHitNormal = HitNormal;
	mHitActor = HitActor;
	mHitLocation = HitLocation;
	FiringMode = 2;
	IceFireCount++;
	NetUpdateTime = Level.TimeSeconds - 1;
	ThirdPersonEffects();
}

// If firecount changes, start ThirdPersonEffects()
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
		FiringMode = 0;
		ThirdPersonEffects();
		OldFireCount = FireCount;
	}
	if (AltFireCount != OldAltFireCount)
	{
		FiringMode = 1;
		ThirdPersonEffects();
		OldAltFireCount = AltFireCount;
	}
	if (IceFireCount != OldIceFireCount)
	{
		FiringMode = 2;
		ThirdPersonEffects();
		OldIceFireCount = IceFireCount;
	}
}

simulated event ThirdPersonEffects()
{
    if ( Level.NetMode != NM_DedicatedServer && Instigator != None)
	{
		if (FiringMode == 1)
			SetBoneScale (0, 1.0, 'Silencer');
		else
			SetBoneScale (0, 0.0, 'Silencer');
    }
	super.ThirdPersonEffects();
}

// Does all the effects for an instant-hit kind of fire.
// On the client, this uses mHitLocation to find all the other info needed.
simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Dir, Start;
	local Material HitMat;

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

		if (WallPenetrates != 0)				{
			WallPenetrates = 0;
			DoWallPenetrate(Start, mHitLocation);	}

		Dir = Normal(mHitLocation - Start);
		mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir*10, mHitLocation - Dir*10, false,, HitMat);
		// Check for water and spawn splash
		if (ImpactManager!= None && bDoWaterSplash)
			DoWaterTrace(Start, mHitLocation);

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
	if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && Vehicle(mHitActor) == None))
		return;
	if (ImpactManager != None)
	{
		if (Mode == 2)
			IceImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
		else ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
	}
}

// Spawn a tracer and water tracer
simulated function SpawnTracer(byte Mode, Vector V)
{
	local BCTraceEmitter Tracer;
	local Vector TipLoc, WLoc, WNorm;
	local float Dist;
	local bool bThisShot;

	if (class'BallisticMod'.default.EffectsDetailMode == 0)
		return;

	TipLoc = GetTipLocation();
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
	if (TracerClass != None && bThisShot && (TracerChance >= 1 || FRand() < TracerChance))
	{
		if (Dist > 200)
		{
			if (FiringMode == 2)
				Tracer = Spawn(IceTracerClass, self, , TipLoc, Rotator(V - TipLoc));
			else Tracer = Spawn(TracerClass, self, , TipLoc, Rotator(V - TipLoc));
		}
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

defaultproperties
{
     IceTracerClass=Class'BallisticProV55.TraceEmitter_Freeze'
     IceImpactManager=Class'BallisticProV55.IM_FreezeHit'
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     AltFlashBone="tip2"
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     TracerMix=-3
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.250000
     CockAnimRate=0.900000
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims2.Xk2-3rd'
     DrawScale=0.110000
}
