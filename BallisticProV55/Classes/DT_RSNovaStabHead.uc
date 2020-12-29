//=============================================================================
// DT_RSNovaStabHead.
//
// Damagetype for the Nova Staff blade attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RSNovaStabHead extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k thrust %kh Nova Staff into %o's eye."
     DeathStrings(1)="%o was impaled through the mouth by %k's Nova."
     DeathStrings(2)="%o almost managed to headbutt %k's Nova Staff from %kh hands."
     bHeaddie=True
     DamageIdent="Melee"
     AimDisplacementDamageThreshold=60
     DamageDescription=",Stab,NovaStaff,"
     WeaponClass=Class'BallisticProV55.RSNovaStaff'
     DeathString="%k thrust %kh Nova Staff into %o's eye."
     FemaleSuicide="%o stabbed her head off with a Nova Staff."
     MaleSuicide="%o stabbed his head off with a Nova Staff."
     bAlwaysSevers=True
     bSpecial=True
	 BlockFatiguePenalty=0.25
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.NovaStaff.Nova-Flesh'
     KDamageImpulse=2000.000000
}
