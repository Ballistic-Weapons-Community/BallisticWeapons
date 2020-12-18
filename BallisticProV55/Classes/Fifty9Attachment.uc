//=============================================================================
// Fifty9Attachment.
//
// 3rd person weapon attachment for the Fifty 9
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Fifty9Attachment extends HandgunAttachment;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneRotation('tip', rot(0,0,8192));
	if (FRand() > 0.5)
		SetBoneRotation('Stock', rot(32768,0,0));
}
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
		class'IM_Fifty9Blade'.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.Fifty9FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     FlashScale=0.800000
     BrassClass=Class'BallisticProV55.Brass_Uzi'
     TrackAnimMode=MU_Secondary
     TracerClass=Class'BallisticProV55.TraceEmitter_FiftyNine'
     TracerChance=0.500000
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.400000
     CockAnimRate=1.250000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims2.Fifty9-3rd'
     DrawScale=0.190000
}
