//=============================================================================
// DT_RSDarkStabHead.
//
// Damagetype for the Dark Star saw attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MAGSAWStabHead extends DT_BWBlade;

static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
 	if (xPawn(Victim) != None)
 	{
		if (default.PawnDamageSounds.Length > 0)
			Victim.PlaySound(default.PawnDamageSounds[Rand(default.PawnDamageSounds.Length)],SLOT_None,default.TransientSoundVolume,false,default.TransientSoundRadius);
		if (default.EffectChance > 0 && default.EffectChance > FRand())
			DoBloodEffects(HitLocation, Damage, Momentum, Victim, bLowDetail);
	}
	return super.GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

defaultproperties
{
     DeathStrings(0)="%k swung %kh Dark Star into %o's pointy nose."
     DeathStrings(1)="%o's head was obliterated by %k's Dark saw."
     DeathStrings(2)="%o's cranium couldn't quite escape %k's relentless Dark saw attack."
     BloodManagerName="BWBP_OP_Pro.BloodMan_MAGSAW"
     bHeaddie=True
     DamageIdent="Melee"
     DamageDescription=",Slash,Hack,"
     WeaponClass=Class'BWBP_OP_Pro.MAG78Longsword'
     DeathString="%k swung %kh Dark Star into %o's pointy nose."
     FemaleSuicide="%o sawed her head off with a Dark Star."
     MaleSuicide="%o sawed his head off with a Dark Star."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.DarkStar.Dark-Flesh'
     KDamageImpulse=2000.000000
     TransientSoundVolume=0.900000
	 GibModifier=2.000000
	 GibPerterbation=1.200000
}
