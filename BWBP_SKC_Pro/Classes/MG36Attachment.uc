//=============================================================================
// MG36Attachment.
//
// 3rd person weapon attachment for MG36 Tactical Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MG36Attachment extends BallisticAttachment;

var	  BallisticWeapon		myWeap;
var() Material	InvisTex;

var() class<BCImpactManager>    ImpactManagerAlt;		//Impact Manager to use for gauss effects
var() class<BCTraceEmitter>	TracerClassAlt;		//Type of tracer to use for alt fire effects

var() bool		bHasGauss;	//Switch tracers and impacts
var() bool		bIsOldGauss;	//Switch tracers and impacts
var() bool		bSilenced;
var() bool		bOldSilenced;

replication
{
	reliable if ( Role==ROLE_Authority )
		bSilenced, bHasGauss;
	//reliable if ( Role==ROLE_Authority )
		//LaserRot;
}

simulated Event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (BallisticTurret(Instigator) != None)
		bHidden=true;
}

simulated event PostNetReceive()
{
	if (bSilenced != bOldSilenced)
	{
		bOldSilenced = bSilenced;
		if (bSilenced)
			SetBoneScale (0, 1.0, 'Silencer');
		else
			SetBoneScale (0, 0.0, 'Silencer');
	}
	if (bHasGauss != bIsOldGauss)
	{
		bIsOldGauss = bHasGauss;
		if (bHasGauss)
			SetBoneScale (1, 1.0, 'Reciever');
		else
			SetBoneScale (1, 0.0, 'Reciever');
	}
	Super.PostNetReceive();
}


function IAOverride(bool bSilenced)
{
	if (bSilenced)
		SetBoneScale (0, 1.0, 'Silencer');
	else
		SetBoneScale (0, 0.0, 'Silencer');
}

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneScale (0, 0.0, 'Silencer');
}

function InitFor(Inventory I)
{
	Super.InitFor(I);

	if (BallisticWeapon(I) != None)
		myWeap = BallisticWeapon(I);
	if (MG36Machinegun(I) != None)
	{
		if (MG36Machinegun(I).bHasGauss)
		{
			bHasGauss=True;
			SetBoneScale (1, 1.0, 'Reciever');
		}
		else
			SetBoneScale (1, 0.0, 'Reciever');
		if (!MG36Machinegun(I).bHasScope)
		{
			SetBoneScale (2, 0.0, 'Scope');
		}
		if (!MG36Machinegun(I).bHasDrum)
		{
			SetBoneScale (3, 0.0, 'MagDrum');
			SetBoneScale (4, 1.0, 'MagSmall');
		}
		else
		{
			SetBoneScale (3, 1.0, 'MagDrum');
			SetBoneScale (4, 0.0, 'MagSmall');
		}
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
		mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir*10, mHitLocation - Dir*10, true,, HitMat); //needs to pick up pawns to spawn explosion fx
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
	if (ImpactManager != None && !bHasGauss)
		ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
	else if (ImpactManagerAlt != None && bHasGauss)
		ImpactManagerAlt.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
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
	if (TracerClass != None && TracerMode != MU_None && (TracerMode == MU_Both && Mode == 0) &&
		bThisShot && (TracerChance >= 1 || FRand() < TracerChance) && !bHasGauss)
	{
		if (Dist > 200)
			Tracer = Spawn(TracerClass, self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	// Spawn an alt tracer
	if (TracerClassAlt != None && TracerMode != MU_None && bHasGauss)
	{
		if (Dist > 200)
			Tracer = Spawn(TracerClassAlt, self, , TipLoc, Rotator(V - TipLoc));
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
	WeaponClass=class'MG36Machinegun'
	MuzzleFlashClass=class'M50FlashEmitter'
	AltMuzzleFlashClass=Class'BWBP_SKC_Pro.MG36SilencedFlash'
	ImpactManager=class'IM_Bullet'
    ImpactManagerAlt=class'IM_BulletGauss'
	AltFlashBone="tip2"
	BrassClass=class'Brass_Rifle'
	InstantMode=MU_Both
	FlashMode=MU_Both
	LightMode=MU_Both
	TracerClass=class'BWBP_SKC_Pro.TraceEmitter_MG36Bullet'
	TracerClassAlt=class'TraceEmitter_Gauss'
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	WaterTracerMode=MU_Both
	FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
	ReloadAnim="Reload_AR"
	ReloadAnimRate=1.200000
	FlashScale=0.250000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.MG36_TPm'
	RelativeRotation=(Pitch=32768)
	DrawScale=1.000000
	PrePivot=(Z=-10.000000)
}
