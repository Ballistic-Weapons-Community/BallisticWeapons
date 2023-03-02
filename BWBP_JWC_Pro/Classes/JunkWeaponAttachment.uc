//=============================================================================
// JunkWeaponAttachment.
//
// FIXME
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkWeaponAttachment extends BallisticAttachment;

//var() class<BCImpactManager>ImpactManager;		//Impact Manager to use for impact effects
var   class<JunkObject>		Junk;
var   class<JunkObject>		NetJunk;
var   class<JunkObject>		OldJunk;
var   byte					ThrowFireCount;			//FIXME
var   Actor					SpecialActor;			//FIXME
var   byte					BlockHitCount;			//FIXME
var	  vector				BlockHitLocation;		//FIXME
var   class<DamageType>		BlockHitType;
var   byte					DamageHitCount;
var   byte					DamageAltHitCount;		//
var   vector				DamageHitLocations[4];	//FIXME
var   byte					DamageHitIndex;

replication
{
	reliable if (bNetDirty && Role==Role_Authority)
		ThrowFireCount, NetJunk, BlockHitCount, BlockHitLocation, BlockHitType;
	unreliable if (bNetDirty && Role==Role_Authority)
		DamageHitCount, DamageAltHitCount, DamageHitLocations;
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	super.PostNetReceive();
	if (ThrowFireCount != default.ThrowFireCount)		{	default.ThrowFireCount = ThrowFireCount;
		FiringMode = 2;
		//Play pawn anims
		PlayPawnFiring(2);
	}
	if (NetJunk != OldJunk)
	{
		Junk = NetJunk;
		InitJunk(NetJunk);
		OldJunk = NetJunk;
	}
	if (BlockHitCount != default.BlockHitCount)		{		default.BlockHitCount = BlockHitCount;
		if (class<BallisticDamageType>(BlockHitType) != None && class<BallisticDamageType>(BlockHitType).default.ImpactManager != None)
			class<BallisticDamageType>(BlockHitType).default.ImpactManager.static.StartSpawn(BlockHitLocation, normal(BlockHitLocation - Instigator.Location), Junk.default.BlockSurface, Instigator, /*HF_NoDecals*/4);
	}

	if (DamageHitCount != default.DamageHitCount)		{	default.DamageHitCount = DamageHitCount;
		JunkDamageEffects(false);
	}
	if (DamageAltHitCount != default.DamageAltHitCount)	{	default.DamageAltHitCount = DamageAltHitCount;
		JunkDamageEffects(true);
	}
}

// Does all the effects for an instant-hit kind of fire.
// On the client, this uses mHitLocation to find all the other info needed.
simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Dir, Start;
	local Material HitMat;

	if (InstantMode == MU_None || (InstantMode == MU_Secondary && Mode < 2) || (InstantMode == MU_Primary && Mode > 1))
		return;
	if (mHitLocation == vect(0,0,0))
		return;
	SpawnTracer(Mode, mHitLocation);
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
	//FIXME
	if (level.NetMode != NM_Client && ImpactManager!= None && WaterHitLocation != vect(0,0,0) && bDoWaterSplash)
		ImpactManager.static.StartSpawn(WaterHitLocation, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLocation), 9, Instigator);
	if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && Vehicle(mHitActor) == None))
		return;
	if (Mode == 0 && Junk != None && Junk.default.MeleeAFireInfo.ImpactManager != None)
		Junk.default.MeleeAFireInfo.ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
	else if (Mode == 1 && Junk != None &&  Junk.default.MeleeBFireInfo.ImpactManager != None)
		Junk.default.MeleeBFireInfo.ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
}

simulated function InitJunk(class<JunkObject> JC)
{
	if (OldJunk != None)
		OldJunk.static.RestoreThirdPersonDisplay(self);
	if (JC != None && JC.static.SetThirdPersonDisplay(self))
		return;
	if (JC == None)
		SetStaticMesh(None);
	else
	{
		SetStaticMesh(JC.default.ThirdPersonMesh);
		SetDrawScale(JC.default.ThirdPersonDrawScale);
		SetRelativeRotation(JC.default.ThirdPersonPivot);
		SetRelativeLocation(JC.default.ThirdPersonOffset);
		bHeavy = JC.default.ThirdPersonHeavy;
    	if ( Instigator != None && xPawn(Instigator) != None )
        	xPawn(Instigator).SetWeaponAttachment(self);
    }

}
simulated function Destroyed()
{
	if (Junk != None)
		Junk.static.RestoreThirdPersonDisplay(self);
	if (SpecialActor != None)
		SpecialActor.Destroy();
	super.Destroyed();
}
function SetJunk(class<JunkObject> JC)
{
	OldJunk = Junk;
	InitJunk(JC);
	Junk = JC;
	NetJunk = JC;
}

function JunkUpdateThrow()
{
	ThrowFireCount++;
	//Play pawn anims
	PlayPawnFiring(2);
}

function JunkBlockHit(vector HitLocation, class<DamageType> DamageType)
{
	BlockHitType = DamageType;
	BlockHitLocation = HitLocation;
	BlockHitCount++;
	if (level.NetMode != NM_DedicatedServer && class<BallisticDamageType>(BlockHitType) != None && class<BallisticDamageType>(BlockHitType).default.ImpactManager != None)
		class<BallisticDamageType>(BlockHitType).default.ImpactManager.static.StartSpawn(BlockHitLocation, normal(BlockHitLocation - Instigator.Location), Junk.default.BlockSurface, Instigator, /*HF_NoDecals*/4);
}

function JunkHitActor(Actor HitActor, vector HitLocation, vector HitNormal, int HitSurf, optional bool bIsAlt)
{
	DamageHitLocations[DamageHitIndex] = HitLocation;
	class'bUtil'.static.Loop(DamageHitIndex, 1, 3, 0);
	if (bIsAlt)
		DamageAltHitCount++;
	else
		DamageHitCount++;

//	JunkDamageEffects(HitActor, HitLocation, HitNormal, );
	NetUpdateTime = Level.TimeSeconds - 1;
	if (level.NetMode != NM_DedicatedServer)
		SpawnDamageEffects(HitLocation, HitNormal, HitSurf, bIsAlt);
}

simulated function JunkDamageEffects(bool bIsAlt)
{
	local int i;
	for (i=0;i<4;i++)
		if (DamageHitLocations[i] !=  vect(0,0,0))
		{
			TraceJunkDamageEffect(bIsAlt, DamageHitLocations[i]);
			DamageHitLocations[i] = vect(0,0,0);
		}
}
simulated function TraceJunkDamageEffect(bool bIsAlt, vector HitLocation)
{
	local actor T;
	local vector Dir, HitLoc, HitNorm;
	local int HitSurf;

	if (Instigator != None)
		Dir = Normal(HitLocation - Instigator.Location+Instigator.EyePosition());
	else
		Dir = Normal(HitLocation - Location);
	T = Trace(HitLoc, HitNorm, HitLocation+Dir*32, HitLocation-Dir*16, true);
	if (T == None || T.bWorldGeometry || Mover(T) != None)
	{
		HitLoc = HitLocation;
		HitNorm = -Dir;
		HitSurf = 6;
	}
	else
	{
		if (Vehicle(T) != None)
			HitSurf = 3/*EST_Metal*/;
		else
			HitSurf = 6/*EST_Flesh*/;
	}
	SpawnDamageEffects(HitLoc, HitNorm, HitSurf, bIsAlt);
}
simulated function SpawnDamageEffects(vector HitLoc, vector HitNorm, int HitSurf, optional bool bIsAlt)
{
	if (bIsAlt && Junk != None &&  Junk.default.MeleeBFireInfo.ImpactManager != None)
		Junk.default.MeleeBFireInfo.ImpactManager.static.StartSpawn(HitLoc, HitNorm, HitSurf, instigator);
	else if (!bIsAlt && Junk != None && Junk.default.MeleeAFireInfo.ImpactManager != None)
		Junk.default.MeleeAFireInfo.ImpactManager.static.StartSpawn(HitLoc, HitNorm, HitSurf, instigator);
}

defaultproperties
{
     ImpactManager=Class'BWBP_JWC_Pro.IM_PipeHitWall'
     BrassMode=MU_None
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Both
     TrackNum(1)=0
     TrackNum(2)=1
     bHeavy=True
     DrawType=DT_StaticMesh
}
