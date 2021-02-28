//=============================================================================
// DT_ICIS
//
// Damagetype for ICIS stabbings
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_ICIS extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k stabbed %o with a dirty needle."
     DeathStrings(1)="%o contracted a disease from %k's rusty needles."
     DamageDescription=",Slash,Stab,"
     WeaponClass=Class'BWBP_SKC_Pro.ICISStimpack'
     DeathString="%k stabbed %o with a dirty needle."
     FemaleSuicide="%o died from super AIDS."
     MaleSuicide="%o got HIV, Syphillis, the mumps, gangrene, and FEV."
     bArmorStops=False
     KDamageImpulse=1000.000000
}
