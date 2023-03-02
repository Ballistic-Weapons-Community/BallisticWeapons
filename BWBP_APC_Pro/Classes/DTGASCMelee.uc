//=============================================================================
// DTGASCMelee.
//
// Damagetype for GASC wacking
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTGASCMelee extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%o was beaten like an egg by %k and %kh GASC."
     DeathStrings(1)="%k used %kh GASC pistol to tenderise %o."
     DamageIdent="Melee"
     AimDisplacementDuration=0.500000
     WeaponClass=Class'BWBP_APC_Pro.GASCPistol'
     DeathString="%o was beaten like an egg by %k's GASC."
     FemaleSuicide="%o beat herself up with an GASC."
     MaleSuicide="%o beat himself up with an GASC."
     bArmorStops=False
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.300000
}
