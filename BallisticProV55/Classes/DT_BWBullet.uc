//=============================================================================
// DT_BWBullet.
//
// Base damage type that will play some pawn impact sounds for bullets
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_BWBullet extends BallisticDamageType;

// Call this to do damage to something. This lets the damagetype modify the things if it needs to
static function Hurt (Actor Victim, float Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DT)
{
	Victim.TakeDamage(Damage, Instigator, HitLocation, Momentum, DT);

	if (class'BallisticReplicationInfo'.static.IsTactical() && Pawn(Victim) != None)
		class'BCSprintControl'.static.SetSlowTo(Pawn(Victim), 0.7, 0.1);
}

static function PlayHitSound (Pawn Victim)
{
	local class<BallisticBloodSet> BS;

	BS = class'BWBloodSetHunter'.static.GetBloodSetFor(Victim);

	if (BS != None)
	{
		if (default.bHeaddie && BS.default.BulletHitHeadSound != None)
			Victim.PlaySound(BS.default.BulletHitHeadSound,,default.TransientSoundVolume,,default.TransientSoundRadius);
		else if (BS.default.BulletHitSound != None)
			Victim.PlaySound(BS.default.BulletHitSound,,default.TransientSoundVolume,,default.TransientSoundRadius);
	}
}

static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
 	if (xPawn(Victim) != None)
 	{
 		PlayHitSound (Victim);
		if (default.EffectChance > 0 && default.EffectChance > FRand() && BallisticPawn(Victim) == None)
			DoBloodEffects(HitLocation, Damage, Momentum, Victim, bLowDetail);
	}
	return super(WeaponDamageType).GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

defaultproperties
{
     EffectChance=1.000000
     BloodManagerName="BallisticProV55.BloodMan_Bullet"
     bMetallic=True
     DamageDescription=",Bullet,"
     bOnlySeverLimbs=True
     bSeverPreventsBlood=True
     bUseMotionBlur=True
     bInstantHit=True
     bRagdollBullet=True
     bBulletHit=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletFlesh'
     VehicleDamageScaling=0.350000
     VehicleMomentumScaling=0.150000
	 TransientSoundVolume=2
}
