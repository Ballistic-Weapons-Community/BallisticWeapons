//=============================================================================
// DTXMK5DartPoison.
//
// DamageType for the XMK5 dart poisoning
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTXMK5DartPoison extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k's XMk5 dart poisoned %o to an agonizing death."
     DeathStrings(1)="%o suffered boils and poisoning from %k's stun dart."
     DeathStrings(2)="%k's dart poison eventually overcame %o's fragile constitution."
     SimpleKillString="XMk5 Poison"
     DamageDescription=",Poison,GearSafe,NonSniper,"
     WeaponClass=Class'BallisticProV55.XMK5SubMachinegun'
     DeathString="%k's XMk5 dart poisoned %o to an agonizing death."
     FemaleSuicide="%o pricked herself with an XMk5 dart."
     MaleSuicide="%o pricked himself with an XMk5 dart."
     bArmorStops=False
     bFastInstantHit=True
     bDirectDamage=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.650000
     bDelayedDamage=True
}
