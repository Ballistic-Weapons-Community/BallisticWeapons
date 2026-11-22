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
	// gauss shots always get the gauss beam (chance 2), within the base's detail checks
	if (bGauss && ModeInfos[Mode].bTracer)
		SpawnTracerOfClass(GaussTracerClass, Mode, mHitLocation, 2);
	else
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
	ReloadAnimRate=1.000000
	CockAnimRate=1.800000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.Marlin_TPm'
	DrawScale=0.125000
}
