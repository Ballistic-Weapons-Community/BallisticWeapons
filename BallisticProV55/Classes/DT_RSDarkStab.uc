//=============================================================================
// DT_RSDarkStab.
//
// Damagetype for the DarkStar saw attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RSDarkStab extends DT_BWBlade;

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
     DeathStrings(0)="%o screeched and leapt onto %k's Dark Star saw."
     DeathStrings(1)="%k sawed %o into tiny pieces with a Dark Star."
     DeathStrings(2)="%k thrust %kh Dark Star into %o's ribcage."
     DeathStrings(3)="%o was insanely shredded by %k's Dark Star."
     BloodManagerName="BallisticProV55.BloodMan_Saw"
     DamageIdent="Melee"
     AimDisplacementDamageThreshold=30
     AimDisplacementDuration=0.25
     DamageDescription=",Slash,DarkStar,Hack,"
     WeaponClass=Class'BallisticProV55.RSDarkStar'
     DeathString="%o screeched and leapt onto %k's Dark Star saw."
     FemaleSuicide="%o accidentally shredded herself on her Dark Star."
     MaleSuicide="%o accidentally shredded himself on his Dark Star."
     bNeverSevers=True
     PawnDamageSounds(0)=SoundGroup'BWBP4-Sounds.DarkStar.Dark-Flesh'
     KDamageImpulse=2000.000000
     TransientSoundVolume=0.900000
}
