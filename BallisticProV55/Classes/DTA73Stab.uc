//=============================================================================
// DTA73Stab.
//
// Damagetype for the A73 bayonette attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA73Stab extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%o was impaled on the blades of %k's A73."
     DeathStrings(1)="%o was split like a pear by %k's A73 blades."
     DeathStrings(2)="%k skewered %o with the A73."
     DeathStrings(3)="%k introduced %o to the merits of Skrith-style combat."
     DamageIdent="Melee"
     AimDisplacementDamageThreshold=75
     DamageDescription=",Stab,"
     WeaponClass=Class'BallisticProV55.A73SkrithRifle'
     DeathString="%o was impaled on the blades of %k's A73."
     FemaleSuicide="%o cut herself on her A73."
     MaleSuicide="%o cut himself on his A73."
     bNeverSevers=True
     PawnDamageSounds(0)=Sound'BallisticSounds2.A73.A73StabFlesh'
     KDamageImpulse=2000.000000
}
