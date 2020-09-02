//=============================================================================
// DTBOGPFlareBurn.
//
// Damage type for the BOGP Flare Fire.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTBOGPFlareBurn extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%o was sent screaming as %k's flare incinerated %vh."
     DeathStrings(1)="%k lit up %o like a burning Christmas tree with %kh BORT-85 flare."
     DeathStrings(2)="%k toasted %o like a marshmallow with a burning hot flare."
     DamageIdent="Pistol"
     WeaponClass=Class'BallisticProV55.BOGPPistol'
     DeathString="%o was sent screaming as %k's flare incinerated %vh."
     FemaleSuicide="%o set herself ablaze with a BORT-85 flare."
     MaleSuicide="%o set himself ablaze with a BORT-85 flare."
     bDelayedDamage=True
	 InvasionDamageScaling=2
     VehicleDamageScaling=0.500000
}
