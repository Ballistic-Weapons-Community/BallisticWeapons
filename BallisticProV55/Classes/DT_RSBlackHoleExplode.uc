//=============================================================================
// DT_RSBlackHoleExplode.
//
// Black hole explosion
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RSBlackHoleExplode extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o was annihilated by a black hole."
     FemaleSuicides(0)="%o was caught up in an exploding black hole."
     FemaleSuicides(1)="%o got blown into many tiny pieces by a vortex."
     FemaleSuicides(2)="%o found herself getting nebulised by a collapsing black hole."
     MaleSuicides(0)="%o was caught up in an exploding black hole."
     MaleSuicides(1)="%o got blown into many tiny pieces by a vortex."
     MaleSuicides(2)="%o found himself getting nebulised by a collapsing black hole."
     SimpleKillString="Black Hole Explosion"
     FlashThreshold=0
     FlashF=0.350000
     DamageIdent="Energy"
     WeaponClass=Class'BallisticProV55.RSDarkStar'
     DeathString="%k's black hole explosion blew %o away."
     FemaleSuicide="%o got torn to skinny ribbons by a black hole."
     MaleSuicide="%o got torn to skinny ribbons by a black hole"
     GibModifier=1.500000
     VehicleDamageScaling=2.000000
     VehicleMomentumScaling=1.500000
}
