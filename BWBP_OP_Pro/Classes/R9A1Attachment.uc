//=============================================================================
// R9Attachment.
//
// Third person actor for the R9 rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class R9A1Attachment extends BallisticAttachment;

var byte CurrentTracerMode;
var array< class<BCTraceEmitter> >	TracerClasses[5];
var array< class<BCImpactManager> >	ImpactManagers[5];

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

	if (level.NetMode != NM_Client && ImpactManagers[CurrentTracerMode]!= None && WaterHitLocation != vect(0,0,0) && bDoWaterSplash && Level.DetailMode >= DM_High && class'BallisticMod'.default.EffectsDetailMode > 0)
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
    if ( Level.NetMode != NM_DedicatedServer && Instigator != None && ImpactManagers[CurrentTracerMode] != None)
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

	TipLoc = GetModeTipLocation();
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

simulated function Vector GetModeTipLocation(optional byte Mode)
{
    local Vector X, Y, Z;
	
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
	{
		if (BW == None)
		{
			BW = BallisticWeapon(Instigator.Weapon);
			
			if (BW == None)
				return Instigator.Location;
		}
			
		if (BW.bScopeView && BW.ZoomType != ZT_Irons)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			return Instigator.Location + X*20 + Z*5;
		}
		else
			return Instigator.Weapon.GetEffectStart();
	}

    return GetBoneCoords('tip').Origin;
}

defaultproperties
{
	WeaponClass=class'R9A1RangerRifle'
	TracerClasses(0)=class'TraceEmitter_Default'
	TracerClasses(1)=class'TraceEmitter_Freeze'
	TracerClasses(2)=class'TraceEmitter_R9Laser'
	TracerClasses(3)=class'TraceEmitter_Default'
	TracerClasses(4)=class'TraceEmitter_Default'
	ImpactManagers(0)=class'IM_Bullet'
	ImpactManagers(1)=class'IM_FreezeHit'
	ImpactManagers(2)=class'IM_R9Laser'
	ImpactManagers(3)=class'IM_Bullet'
	ImpactManagers(4)=class'IM_Bullet'
	MuzzleFlashClass=Class'BWBP_OP_Pro.R9A1FlashEmitter'
	AltMuzzleFlashClass=class'XK2SilencedFlash'
	ImpactManager=class'IM_Bullet'
	FlashScale=2.000000
	BrassClass=class'Brass_Rifle'
	TracerMode=MU_Both
	InstantMode=MU_Both
	FlashMode=MU_Both
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	WaterTracerMode=MU_Both
	FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
	ReloadAnim="Reload_AR"
	CockingAnim="Cock_RearPull"
	ReloadAnimRate=0.800000
	CockAnimRate=0.900000
	Mesh=SkeletalMesh'BWBP_OP_Anim.R9A1_TPm'
	RelativeLocation=(X=3.000000,Z=1.000000)
	DrawScale=0.160000
	//Skins(0)=Shader'BWBP_OP_Tex.R9_body_SH1'
}
