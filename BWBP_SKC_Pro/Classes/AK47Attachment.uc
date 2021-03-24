//=============================================================================
// AK47Attachment.
//
// 3rd person weapon attachment for AK47 Battle Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AK47Attachment extends BallisticAttachment;

var	  BallisticWeapon		myWeap;
var Vector		SpawnOffset;
var bool bLoaded; //knife on, use different impact manager

replication
{
	reliable if (Role == ROLE_Authority)
		bLoaded;
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (AK47AssaultRifle(Instigator.Weapon).BCRepClass.default.GameStyle == 1)
	{
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Tranq';
	}
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
	if (!bLoaded)
		class'IM_GunHit'.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
	else class'IM_Bayonet'.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, Instigator);
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     TrackAnimMode=MU_Secondary
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     TracerChance=2.000000
     TracerMix=-3
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.800000
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_SKC_Anim.AK490_TPm'
     RelativeRotation=(Pitch=32768)
     DrawScale=0.350000
}
