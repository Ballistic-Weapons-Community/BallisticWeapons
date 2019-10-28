//=============================================================================
// DTCYLOMk2Overheat
//
// Damage type for people who don't know how to handle hot guns. ;)
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTCYLOMk2Overheat extends DT_BWBullet;

defaultproperties
{
     MaleSuicides(0)="%o fatally overheated his CYLO Firestorm."
     MaleSuicides(1)="%o fused his hands to an overheating gun."
     MaleSuicides(2)="%o's CYLO Firestorm burned through his hands."
     SimpleSuicideString="CYLO Firestorm V Overheat"
     InvasionDamageScaling=2.000000
     DamageIdent="Assault"
     DamageDescription=",Flame,Hazard,"
     WeaponClass=Class'BWBPRecolorsPro.CYLOAssaultWeapon'
     DeathString="%k somehow managed to burn %o with his overheating Firestorm."
     FemaleSuicide="%o's CYLO Firestorm burned through her hands."
     MaleSuicide="%o's CYLO Firestorm burned through his hands."
     bArmorStops=False
     bCausesBlood=False
     VehicleDamageScaling=0.200000
     VehicleMomentumScaling=0.050000
}
