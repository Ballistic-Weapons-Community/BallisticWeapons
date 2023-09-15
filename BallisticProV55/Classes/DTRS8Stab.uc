//=============================================================================
// DTRS8Stab.
//
// Damagetype for X3 Knife when held with an RS8
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRS8Stab extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k poked holes into %o with an X3."
     DeathStrings(1)="%o found out why %k had a knife with %kh RS8."
     DeathStrings(2)="%k tactically stabbed %o with an X3."
     DeathStrings(3)="%o didn't notice the knife under %k's RS8."
     DamageIdent="Melee"
     AimDisplacementDamageThreshold=25
     AimDisplacementDuration=0.50
	 BlockFatiguePenalty=0.1
     WeaponClass=Class'BallisticProV55.RS8Pistol'
     DeathString="%k poked holes into %o with an X3."
     FemaleSuicide="%o forgot how to use the handle of her X3."
     MaleSuicide="%o forgot how to use the handle of his X3."
     KDamageImpulse=1000.000000
}
