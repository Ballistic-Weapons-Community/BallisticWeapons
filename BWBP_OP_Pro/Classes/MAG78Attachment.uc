//=============================================================================
// EKS43Attachment.
//
// Attachment for EKS43 sword.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MAG78Attachment extends BallisticMeleeAttachment;

var RSDarkSawHitSound Noise;

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

	if (Noise == None)
		Noise = Spawn(class'RSDarkSawHitSound', Instigator, , Instigator.Location);
	if (level.NetMode != NM_Client && ImpactManager!= None && WaterHitLocation != vect(0,0,0) && bDoWaterSplash && Level.DetailMode >= DM_High && class'BallisticMod'.default.EffectsDetailMode > 0)
	{
		ImpactManager.static.StartSpawn(WaterHitLocation, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLocation), 9, Instigator, 2);//HF_NoSounds);
		Noise.SetNoise(ImpactManager.default.HitSounds[mHitSurf]);
		Noise.SetLocation(WaterHitLocation);
	}
	if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && Vehicle(mHitActor) == None))
		return;
	if (ImpactManager != None)
	{
		ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator, 2);//HF_NoSounds);
		Noise.SetNoise(ImpactManager.default.HitSounds[mHitSurf]);
		Noise.SetLocation(HitLocation);
	}
}

defaultproperties
{
	WeaponClass=class'MAG78Longsword'
	 IdleHeavyAnim="TwoHand_Idle"
     IdleRifleAnim="TwoHand_Idle"
	 MeleeStrikeAnim="TwoHand_Slam"
	 MeleeAltStrikeAnim="TwoHand_StabSaw"
	 MeleeBlockAnim="TwoHand_Block"
     ImpactManager=Class'IM_DarkStarSaw'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Both
     Mesh=SkeletalMesh'BWBP_OP_Anim.TPm_MAGSAW'
     DrawScale=0.200000
	 RelativeRotation=(Pitch=32768,Yaw=16384)
}
