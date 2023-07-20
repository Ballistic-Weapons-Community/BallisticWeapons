//=============================================================================
// DT_BWExplode.
//
// Base damage type that implements some gore for explosions
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_BWExplode extends BallisticDamageType;

static function DoBloodEffects( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (BallisticPawn(Victim) == None && Victim.Health < 1 && (!Victim.PhysicsVolume.bWaterVolume) && !default.bCantLoadBlood && GetBloodManager() != None)
		GetBloodManager().static.StartSpawnBlood(Victim.Location, Momentum, Victim);
}

defaultproperties
{
    DamageBasis=DB_Explosive
    EffectChance=1.000000
    BloodManagerName="BallisticProV55.BloodMan_Exploded"
    bIgniteFires=True
    DamageDescription=",Explode,Hazard,NonSniper,"
    bLocationalHit=False
    bThrowRagdoll=True
    GibModifier=2.000000
    PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletFlesh'
    GibPerterbation=0.500000
    KDamageImpulse=20000.000000
	TransientSoundVolume=2
}
