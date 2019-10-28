//=============================================================================
// DT_RSBlackHoleSuck.
//
// Black hole suck damage
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RSBlackHoleSuck extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o ran bravely into a black hole."
     FemaleSuicides(0)="%o ran screaming wildly into a black hole."
     FemaleSuicides(1)="%o wandered idly into a deadly vortex."
     FemaleSuicides(2)="%o was hopelessly sucked into a dark maelstrom."
     FemaleSuicides(3)="%o foolishly got herself swept into an innocent black hole."
     MaleSuicides(0)="%o ran screaming wildly into a black hole."
     MaleSuicides(1)="%o wandered idly into a deadly vortex."
     MaleSuicides(2)="%o was hopelessly sucked into a dark maelstrom."
     MaleSuicides(3)="%o foolishly got himself swept into an innocent black hole."
     SimpleKillString="Black Hole"
     FlashThreshold=0
     FlashF=0.350000
     DamageIdent="Energy"
     WeaponClass=Class'BallisticProV55.RSDarkStar'
     DeathString="%o was swept into a black hole"
     FemaleSuicide="%o wandered into a black hole."
     MaleSuicide="%o wandered into a black hole."
     GibModifier=1.500000
     VehicleDamageScaling=2.000000
     VehicleMomentumScaling=1.500000
}
