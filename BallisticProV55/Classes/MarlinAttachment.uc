//=============================================================================
// MarlinAttachment.
//
// 3rd person weapon attachment for Deermaster Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MarlinAttachment extends BallisticAttachment;


var() class<BCTraceEmitter>	GaussTracerClass;	//Emitter to sue for under water tracer
var() class<BCImpactManager> GaussImpactManager;

var bool bGauss, bOldGauss;

replication
{
	reliable if ( Role==ROLE_Authority )
		bGauss;
}

simulated event PostNetReceive()
{
	Super.PostNetReceive();
	
	if (bGauss != bOldGauss)
		bOldGauss = bGauss;
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
			DoWallPenetrate(Mode, Start, mHitLocation);	}

		Dir = Normal(mHitLocation - Start);
		mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir*10, mHitLocation - Dir*10, false,, HitMat);
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
	if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && Vehicle(mHitActor) == None))
		return;
	if (ImpactManager != None)
	{
		if (bGauss)
			GaussImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
		else 
			ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
	}
}

// Spawn a tracer and water tracer
simulated function SpawnTracer(byte Mode, Vector V)
{
	local BCTraceEmitter Tracer;
	local Vector TipLoc, WLoc, WNorm;
	local float Dist;
	local bool bThisShot;
	
	//log("When firing: bGauss = "$ bGauss);

	if (class'BallisticMod'.default.EffectsDetailMode == 0)
		return;

	// no tracers if suppressed
	if (Mode == 1)
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
	if (TracerClass != None && bThisShot && (TracerChance >= 1 || FRand() < TracerChance))
	{
		if (Dist > 200)
		{
			if (bGauss)
				Tracer = Spawn(GaussTracerClass, self, , TipLoc, Rotator(V - TipLoc));
			else 
				Tracer = Spawn(TracerClass, self, , TipLoc, Rotator(V - TipLoc));
		}
		if (Tracer != None)
			Tracer.Initialize(Dist,0.2);
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
	WeaponClass=class'MarlinRifle'
	GaussTracerClass=class'TraceEmitter_Gauss'
	GaussImpactManager=class'IM_BulletGauss'
	MuzzleFlashClass=class'R78FlashEmitter'
	ImpactManager=class'IM_Bullet'
	MeleeImpactManager=class'IM_GunHit'
	FlashScale=1.800000
	BrassClass=class'Brass_Rifle'
	TracerClass=class'TraceEmitter_Default'
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	TracerMode=MU_Primary
	InstantMode=MU_Primary
	FlashMode=MU_Primary
	FlyByMode=MU_Primary
	MeleeStrikeAnim="Melee_Smash"
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.Marlin_TPm'
	DrawScale=0.125000
}
