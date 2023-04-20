//=============================================================================
// T9CNAttachment.
//
// 3rd person weapon attachment for the T9CN
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class T9CNAttachment extends HandgunAttachment;

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
	WeaponClass=class'T9CNMachinePistol'
	MuzzleFlashClass=Class'BWBP_SKC_Pro.T9CNFlashEmitter'
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
	bRapidFire=True
	Mesh=SkeletalMesh'BWBP_SKC_Anim.T9CNRC_TPm'
	RelativeLocation=(Z=5.000000)
	RelativeRotation=(Pitch=32768)
	DrawScale=0.150000
}
