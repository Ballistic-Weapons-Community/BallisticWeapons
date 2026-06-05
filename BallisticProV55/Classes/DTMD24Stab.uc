//=============================================================================
// DTMD24Stab.
//
// Damagetype for MD24 Tac Knife slash and stab attacks
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMD24Stab extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k stabbed %o with the Tac Knife on %kh MD24."
     DeathStrings(1)="%o found out the hard way %k's MD24 has a knife."
     DeathStrings(2)="%k used the Tac Knife to finish %o."
     DeathStrings(3)="%o didn't notice the knife on %k's MD24."
     DamageIdent="Melee"
     AimDisplacementDamageThreshold=25
     AimDisplacementDuration=0.50
     BlockFatiguePenalty=0.1
     WeaponClass=Class'BallisticProV55.MD24Pistol'
     DeathString="%k stabbed %o with the Tac Knife on %kh MD24."
     FemaleSuicide="%o forgot how to use the handle of her Tac Knife."
     MaleSuicide="%o forgot how to use the handle of his Tac Knife."
     KDamageImpulse=1000.000000
}
