//=============================================================================
// DTG5BazookaRadius.
//
// DamageType for the G5 Bazooka radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRGPXBazookaRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="Even on the fringe, %o couldn't escape %k's explosion."
     DeathStrings(1)="%k showed %o how jank rocket jumping is by blowing up their feet."
     DeathStrings(2)="%o became red mist in the wind thanks to %k's bazooka."
	 DeathStrings(3)="%k assisted %o in a magic trick, transforming into a fine red paste."
	 DeathStrings(4)="%o went splat on the ceiling after %k blew him up with the RGX."
	 DeathStrings(5)="%k might've missed the direct hit, but the impending explosion destroyed %o."
     FemaleSuicides(0)="%o splattered the walls with her gibs using a G5."
     FemaleSuicides(1)="%o blasted herself across the map with a G5."
     FemaleSuicides(2)="%o blew herself into a chunky haze with the G5."
     MaleSuicides(0)="%o splattered the walls with his gibs using a G5."
     MaleSuicides(1)="%o blasted himself across the map with a G5."
     MaleSuicides(2)="%o blew himself into a chunky haze with the G5."
     InvasionDamageScaling=3.000000
     DamageIdent="Ordnance"
     WeaponClass=Class'BWBP_JCF_Pro.RGPXBazooka'
     DeathString="%o almost escaped %k's G5 rocket."
     FemaleSuicide="%o splattered the walls with her gibs using a G5."
     MaleSuicide="%o splattered the walls with his gibs using a G5."
     bDelayedDamage=True
     VehicleDamageScaling=2.500000
     VehicleMomentumScaling=2.500000
}
