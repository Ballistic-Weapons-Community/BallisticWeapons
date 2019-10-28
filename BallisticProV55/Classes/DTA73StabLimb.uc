//=============================================================================
// DTA73StabLimb.
//
// Damagetype for the A73 bayonette attack to limbs
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA73StabLimb extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%o almost fended off %k's A73 blades."
     DeathStrings(1)="%o tried to kick %k's A73 blades."
     DeathStrings(2)="%k rammed %kh A73 blades into %o's forearm."
     DamageIdent="Melee"
     AimDisplacementDamageThreshold=75
     DamageDescription=",Stab,"
     WeaponClass=Class'BallisticProV55.A73SkrithRifle'
     DeathString="%o alost fended off %k's A73 blades."
     FemaleSuicide="%o cut herself on her A73."
     MaleSuicide="%o cut himself on his A73."
     PawnDamageSounds(0)=Sound'BallisticSounds2.A73.A73StabFlesh'
     KDamageImpulse=2000.000000
}
