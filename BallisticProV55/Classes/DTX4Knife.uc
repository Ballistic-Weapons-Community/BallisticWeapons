//=============================================================================
// DTX4Knife.
//
// Damagetype for X4 Knife
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTX4Knife extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k cut up %o like a paper-shredder with %kh X4 knife."
     DeathStrings(1)="%o pounced onto %k's X4, and disembowelled %vs."
     DeathStrings(2)="%k jammed %kh X4 knife into %o's staggering body."
     DeathStrings(3)="%o was stabbed to death by %k's X4."
     DamageIdent="Melee"
     AimDisplacementDamageThreshold=40
     AimDisplacementDuration=1.400000
     DamageDescription=",Slash,Stab,"
     WeaponClass=Class'BallisticProV55.X4Knife'
     DeathString="%k cut up %o like a paper-shredder with %kh X4 knife."
     FemaleSuicide="%o fell on her X4 knife."
     MaleSuicide="%o fell on his X4 knife."
     KDamageImpulse=1000.000000
}
