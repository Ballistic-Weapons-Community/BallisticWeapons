//=============================================================================
// DTXMV850MG.
//
// Damage type for the XMV850 Minigun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTXMV850MG extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was ripped apart by %k's XMV-850."
     DeathStrings(1)="%k put a hail of bullets through %o."
     DeathStrings(2)="%o was ribbonized by %k's XMV-850 minigun."
     DeathStrings(3)="%o was torn asunder by the might of %k's minigun."
     HipString="HIP SPAM"
     DamageIdent="Machinegun"
     WeaponClass=Class'BallisticProV55.XMV850Minigun'
     DeathString="%o was ripped apart by %k's XMV-850."
     FemaleSuicide="%o minigunned her feet into tatters."
     MaleSuicide="%o minigunned his feet into tatters."
     bFastInstantHit=True
     VehicleDamageScaling=0.600000
     VehicleMomentumScaling=0.500000
}
