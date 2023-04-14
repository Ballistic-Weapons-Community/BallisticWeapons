//=============================================================================
// ChaffAttachment.
//
// 3rd person weapon attachment for MOA-C Grenade.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ChaffAttachment extends BallisticGrenadeAttachment;


simulated function InstantFireEffects(byte Mode)
{
	if (FiringMode != 0)
		MeleeFireEffects();
	else
		Super.InstantFireEffects(FiringMode);
}

simulated event ThirdPersonEffects()
{
	//Throw
	if (FiringMode == 0)
	{
		if (Level.NetMode != NM_DedicatedServer)
			PlayPawnFiring(FiringMode);
		if (GrenadeSmoke != None)
			class'BallisticEmitter'.static.StopParticles(GrenadeSmoke);
	}
	//Hit
	else if ( Level.NetMode != NM_DedicatedServer && Instigator != None)
	{
		//Spawn impacts, streaks, etc
		MeleeFireEffects();
		//Play pawn anims
		PlayPawnFiring(FiringMode);
    }
}

// Does all the effects for an instant-hit kind of fire.
// On the client, this uses mHitLocation to find all the other info needed.
simulated function MeleeFireEffects()
{
	local Vector HitLocation, Dir, Start;
	local Material HitMat;

	If ( Level.NetMode == NM_DedicatedServer || Instigator == None || mHitLocation == vect(0,0,0))
		return;

	// Client, trace for hitnormal, hitmaterial and hitactor
	if (Level.NetMode == NM_Client)
	{
		mHitActor = None;
		Start = Instigator.Location + Instigator.EyePosition();
		Dir = Normal(mHitLocation - Start);
		mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir*10, mHitLocation - Dir*10, false,, HitMat);
		if (mHitActor == None || (!mHitActor.bWorldGeometry))
			return;
		if (HitMat == None)
			mHitSurf = int(mHitActor.SurfaceType);
		else
			mHitSurf = int(HitMat.SurfaceType);
	}
 	else
		HitLocation = mHitLocation;
	if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && Vehicle(mHitActor) == None))
		return;
	if (MeleeImpactManager != None)
		MeleeImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, Instigator);
}

defaultproperties
{
     MeleeImpactManager=Class'BallisticProV55.IM_GunHit'
     ExplodeManager=Class'BWBP_SKC_Pro.IM_ChaffGrenade'
     GrenadeSmokeClass=Class'BWBP_SKC_Pro.ChaffTrail'
     TrackAnimMode=MU_Primary
	 InstantMode=MU_Secondary
     Mesh=SkeletalMesh'BWBP_SKC_Anim.MOAC_TPm'
     RelativeLocation=(X=-2.000000,Y=-3.000000,Z=20.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.650000
     ImpactManager=Class'BallisticProV55.IM_Katana'
}
