//=============================================================================
// DTGASCPistol.
//
// Damage type for the GASC Pistol
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTGASCPistol extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was stuffed like a turkey by %k's GASC."
     DeathStrings(1)="%k passed a few GASC rounds into %o's stomach."
     DeathStrings(2)="%o got %vs greased by %k's GASC pistol."
     DamageIdent="Pistol"
     WeaponClass=Class'BWBP_APC_Pro.GASCPistol'
     DeathString="%o was stuffed like a turkey by %k's GASC."
     FemaleSuicide="%o blasted herself with an GASC."
     MaleSuicide="%o blasted himself with an GASC."
     VehicleDamageScaling=0.000000
}
