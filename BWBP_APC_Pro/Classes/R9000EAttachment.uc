//=============================================================================
// R9000EAttachment.
//
// 3rd person weapon attachment for R78 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class R9000EAttachment extends BallisticAttachment;

var byte CurrentTracerMode;
var array< class<BCTraceEmitter> >	TracerClasses[3];
var array< class<BCImpactManager> >	ImpactManagers[3];

var BallisticWeapon BW;

replication
{
	reliable if (Role == ROLE_Authority)
		CurrentTracerMode;
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	if (Role == ROLE_Authority || Instigator.IsLocallyControlled())
		BW = BallisticWeapon(Instigator.Weapon);
	if (Role == ROLE_Authority)
		CurrentTracerMode = BW.CurrentWeaponMode;
}

// Does all the effects for an instant-hit kind of fire.
// On the client, this uses mHitLocation to find all the other info needed.
simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Dir, Start;
	local Material HitMat;

	if (InstantMode == MU_None || (InstantMode == MU_Secondary && Mode != 1) || (InstantMode == MU_Primary && Mode != 0))
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
		if (ImpactManagers[0] != None && bDoWaterSplash)
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

	if (level.NetMode != NM_Client && ImpactManagers[0]!= None && WaterHitLocation != vect(0,0,0) && bDoWaterSplash && Level.DetailMode >= DM_High && class'BallisticMod'.default.EffectsDetailMode > 0)
		ImpactManagers[CurrentTracerMode].static.StartSpawn(WaterHitLocation, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLocation), 9, Instigator);
	if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && Vehicle(mHitActor) == None))
		return;
	if (ImpactManagers[CurrentTracerMode] != None)
		ImpactManagers[CurrentTracerMode].static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
}

// Spawn some wall penetration effects...
simulated function WallPenetrateEffect(byte Mode, vector HitLocation, vector HitNormal, int HitSurf, optional bool bExit)
{
	if (Level.DetailMode < DM_High || class'BallisticMod'.default.EffectsDetailMode == 0 || level.NetMode == NM_DedicatedServer || ImpactManagers[CurrentTracerMode] == None)
		return;
	if (bExit && (Level.DetailMode == DM_High || class'BallisticMod'.default.EffectsDetailMode == 1) )
		return;
	if (bExit)
		ImpactManagers[CurrentTracerMode].static.StartSpawn(HitLocation, HitNormal, HitSurf, instigator, 2/*HF_NoSound*/);
	else
		ImpactManagers[CurrentTracerMode].static.StartSpawn(HitLocation, HitNormal, HitSurf, instigator);
}

simulated function DoDirectHit(byte Mode, vector HitLocation, vector HitNormal, int HitSurf)
{
    if ( Level.NetMode != NM_DedicatedServer && Instigator != None && ImpactManager != None)
		ImpactManagers[CurrentTracerMode].static.StartSpawn(HitLocation, HitNormal, HitSurf, Instigator);
}

// Spawn a tracer and water tracer
simulated function SpawnTracer(byte Mode, Vector V)
{
	local BCTraceEmitter Tracer;
	local Vector TipLoc, WLoc, WNorm;
	local float Dist;

	if (Level.DetailMode < DM_High || class'BallisticMod'.default.EffectsDetailMode == 0)
		return;

	TipLoc = GetTipLocation();
	Dist = VSize(V - TipLoc);

	if (Dist > 200)
		Tracer = Spawn(TracerClasses[CurrentTracerMode], self, , TipLoc, Rotator(V - TipLoc));
	if (Tracer != None)
		Tracer.Initialize(Dist);
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
	WeaponClass=class'R9000ERifle'
	TracerClasses(0)=Class'BallisticProV55.TraceEmitter_Default'
    TracerClasses(1)=Class'BWBP_APC_Pro.TraceEmitter_R9000Incendiary'
    TracerClasses(2)=Class'BWBP_APC_Pro.TraceEmitter_RAD'
    ImpactManagers(0)=Class'BallisticProV55.IM_Bullet'
    ImpactManagers(1)=Class'BWBP_APC_Pro.IM_BulletHE'
    ImpactManagers(2)=Class'BWBP_APC_Pro.IM_BulletRad'
    MuzzleFlashClass=Class'BWBP_APC_Pro.R9000EFlashEmitter'
	FlashScale=0.125000
    ImpactManager=Class'BallisticProV55.IM_Bullet'
    BrassClass=Class'BallisticProV55.Brass_Rifle'
    TracerClass=Class'BallisticProV55.TraceEmitter_Default'
    TracerChance=0.000000
    WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
    WaterTracerMode=MU_Both
    FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
    ReloadAnim="Reload_AR"
    CockingAnim="Cock_RearPull"
	ReloadAnimRate=0.750000
    CockAnimRate=0.560000
    Mesh=SkeletalMesh'BWBP_APC_Anim.R9000E_TPm'
    DrawScale=3.000000
}
