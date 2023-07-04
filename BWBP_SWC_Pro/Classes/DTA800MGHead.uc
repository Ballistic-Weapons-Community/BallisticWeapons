//=============================================================================
// DTA800MGHead.
//
// Damage type for the a800 hyperblaster dome removal
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA800MGHead extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k's monster gun tore %o's head off."
     DeathStrings(1)="%o's head was turned to slag by %k's Hyperblaster."
     DeathStrings(2)="%o found %vh cranium being vapourised by %k's A800."
     DeathStrings(3)="%k pumped A800 plasma into %o's twitchy head."
     BloodManagerName="BallisticProV55.BloodMan_A73Burn"
     DamageDescription=",Plasma,Laser,"
     WeaponClass=Class'BWBP_SWC_Pro.A800SkrithMinigun'
     DeathString="%k's monster gun tore %o's head off."
     FemaleSuicide="%o minigunned her own head off."
     MaleSuicide="%o minigunned his own head off."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     VehicleDamageScaling=1.250000
}
