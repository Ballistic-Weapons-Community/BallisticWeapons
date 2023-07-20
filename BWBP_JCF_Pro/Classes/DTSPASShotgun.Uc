//=============================================================================
// DTSPASShotgun.
//
// Damage type for SPAS
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSPASShotgun extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k subdued %o with a 12-Gauge SPAS shell."
     DeathStrings(1)="%k's SPAS gut-shot forced %o to %vh knees."
     DeathStrings(2)="%o's protest was quelled by %k's SPAS-12."
     DeathStrings(3)="%o protested in front of %k's unforgiving SPAS-12."
     DeathStrings(4)="%k restored peace by filling %o with SPAS buckshot."
     WeaponClass=Class'BWBP_JCF_Pro.SPASShotgun'
     DeathString="%k subdued %o with a 12-Gauge SPAS shell."
     FemaleSuicide="%o nailed herself with the SPAS."
     MaleSuicide="%o nailed himself with the SPAS."
     GibPerterbation=0.650000
     KDamageImpulse=14000.000000
     VehicleDamageScaling=0.400000
}
