//=============================================================================
// DTSTEVETorsoLunge
//
// Damagetype for body alt stabs.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTBOBTorsoLunge extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k carved the heart out of %o with his black ops blade."
     DeathStrings(1)="%k lunged into %o with his X5W."
     DeathStrings(2)="%o was fatally speared by %k's black ops blade."
     WeaponClass=Class'BWBP_SKCExp_Pro.BlackOpsWristBlade'
     DeathString="%k carved out %o's heart with his black ops blade."
     FemaleSuicide="%o cut her own heart out."
     MaleSuicide="%o cut his own heart out."
     bArmorStops=False
     bNeverSevers=True
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.500000
}
