//=============================================================================
// DT_BWBullet.
//
// Base damage type that will play some pawn impact sounds for bullets
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_BWBullet extends BallisticDamageType;

static function Sound GetHitSound (Pawn Victim)
{
	local class<BallisticBloodSet> BS;

	BS = class'BWBloodSetHunter'.static.GetBloodSetFor(Victim);

	if (BS == None)
		return None;
	if (default.bHeaddie && BS.default.BulletHitHeadSound != None)
		return BS.default.BulletHitHeadSound;
	return BS.default.BulletHitSound;
}

static function PlayHitSound (Pawn Victim)
{
	local Sound S;

	S = GetHitSound(Victim);
	if (S != None)
		Victim.PlaySound(S,,default.TransientSoundVolume,,default.TransientSoundRadius);
}

// A Ballistic pawn's blood comes with the hit itself, so for a body this is the sound
simulated static function CorpseDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	local Sound S;

	S = GetHitSound(Victim);
	if (S != None)
		Victim.PlaySound(S,,default.TransientSoundVolume,,default.TransientSoundRadius);
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

	TagDuration=0.135
	TagMultiplier=0.6
}
