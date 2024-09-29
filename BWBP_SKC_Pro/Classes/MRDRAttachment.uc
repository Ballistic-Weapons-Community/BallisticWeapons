//=============================================================================
// MRDRAttachment.
//
// 3rd person weapon attachment for the MR-DR Wrist Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MRDRAttachment extends HandgunAttachment;

simulated function InstantFireEffects(byte Mode)
{
	if (FiringMode != 0)
		MeleeFireEffects();
	else
		Super.InstantFireEffects(FiringMode);
}
// Do trace to find impact info and then spawn the effect
simulated function MeleeFireEffects()
{
	local Vector HitLocation, Dir, Start;
	local Material HitMat;

	if (mHitLocation == vect(0,0,0))
		return;

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
//	if (ImpactManager != None)
		class'IM_GunHit'.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
}

defaultproperties
{
	WeaponClass=class'MRDRMachinePistol'
     MuzzleFlashClass=Class'BWBP_SKC_Pro.MRDRFlashEmitter'
     ImpactManager=class'IM_Bullet'
     FlashScale=0.800000
     BrassClass=class'Brass_Pistol'
     TrackAnimMode=MU_Secondary
     TracerClass=class'TraceEmitter_Default'
     TracerChance=0.500000
     WaterTracerClass=class'TraceEmitter_WaterBullet'
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_Pistol"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.250000
     CockAnimRate=0.800000
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_SKC_Anim.MRDR_TPm'
     RelativeLocation=(X=-3.000000,Z=5.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.140000
}
