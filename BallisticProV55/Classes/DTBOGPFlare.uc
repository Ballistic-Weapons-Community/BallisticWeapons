//=============================================================================
// DTBOGPFlare.
//
// Damage type for the BOGP Flare.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTBOGPFlare extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%k lobbed a scorching flare into %o's mop of hair."
     DeathStrings(1)="%o swallowed %k's BORT-85 flare and turned out medium-rare."
     DeathStrings(2)="%o was smacked down by %k's flare."
     DamageIdent="Pistol"
     DamageDescription=",Flame,Hazard,NonSniper,Blunt,"
     WeaponClass=Class'BallisticProV55.BOGPPistol'
     DeathString="%k lobbed a scorching flare into %o's mop of hair."
     FemaleSuicide="%o set her own hair on fire with a BORT-85 flare."
     MaleSuicide="%o set his own hair on fire with a BORT-85 flare."
     bDelayedDamage=True
	 InvasionDamageScaling=2
     VehicleDamageScaling=0.500000
}
