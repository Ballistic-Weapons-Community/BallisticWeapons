//=============================================================================
// DTRS04Stab.
//
// Damagetype for X1 Knife when held with an RS04
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRS04Stab extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k poked holes into %o with an X1."
     DeathStrings(1)="%o found out why %k had a knife with %kh RS04."
     DeathStrings(2)="%k tactically stabbed %o with an X1."
     DeathStrings(3)="%o didn't notice the knife under %k's RS04."
     DamageIdent="Melee"
     AimDisplacementDamageThreshold=25
     AimDisplacementDuration=0.50
	 BlockFatiguePenalty=0.1
     WeaponClass=Class'BWBP_SKC_Pro.RS04Pistol'
     DeathString="%k poked holes into %o with an X1."
     FemaleSuicide="%o forgot how to use the handle of her X1."
     MaleSuicide="%o forgot how to use the handle of his X1."
     KDamageImpulse=1000.000000
}
