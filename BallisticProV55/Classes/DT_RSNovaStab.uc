//=============================================================================
// DT_RSNovaStab.
//
// Damagetype for the NovaStaff blade attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RSNovaStab extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%o spiked %vs on %k's Nova Staff blades."
     DeathStrings(1)="%o engraved %vs with %k's Nova Staff."
     DeathStrings(2)="%k jammed %kh Nova blades through %o's ribcage."
     DeathStrings(3)="%o walked into %k's Nova Staff."
     DamageIdent="Melee"
     AimDisplacementDamageThreshold=60
     DamageDescription=",Stab,NovaStaff,"
     WeaponClass=Class'BallisticProV55.RSNovaStaff'
     DeathString="%o spiked %vs on %k's Nova Staff blades."
     FemaleSuicide="%o poked herself with her Nova Staff."
     MaleSuicide="%o poked himself with his Nova Staff."
     bNeverSevers=True
     PawnDamageSounds(0)=SoundGroup'BWBP4-Sounds.NovaStaff.Nova-Flesh'
     KDamageImpulse=2000.000000
}
