//=============================================================================
// M50Attachment.
//
// 3rd person weapon attachment for M50 Assault Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CYLOFirestormAttachment extends BallisticAttachment;

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

		if (WallPenetrates != 0)				
		{
			WallPenetrates = 0;
			DoWallPenetrate(Start, mHitLocation);	
		}

		Dir = Normal(mHitLocation - Start);
		mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir * 10, mHitLocation - Dir * 10, true,, HitMat); // CYLO needs to trace actors to find Pawns 
		
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
	
	if (mHitActor == None)
		return;
	
	if (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && mHitActor.bProjTarget)
	{
		Spawn (class'IE_IncBulletMetal', ,, HitLocation,);
		return;
	}
	
	if (ImpactManager != None)
		ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
}

defaultproperties
{
     MuzzleFlashClass=Class'BWBPRecolorsPro.AH104FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     ImpactManager=Class'IM_IncendiaryBullet'
     MeleeImpactManager=Class'BallisticProV55.IM_Knife'
     AltFlashBone="tip2"
     FlashScale=0.300000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BWBPRecolorsPro.TraceEmitter_Incendiary'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     IdleHeavyAnim="PistolHip_Idle"
     IdleRifleAnim="PistolAimed_Idle"
     SingleFireAnim="PistolHip_Fire"
     SingleAimedFireAnim="PistolAimed_Fire"
     RapidFireAnim="PistolHip_Burst"
     RapidAimedFireAnim="PistolAimed_Burst"     
	 ReloadAnim="Reload_AR"
     ReloadAnimRate=0.800000
     bHeavy=True
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_SKC_Anim.CYLOFirestorm_TPm'
     RelativeLocation=(Z=1.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.300000
}
