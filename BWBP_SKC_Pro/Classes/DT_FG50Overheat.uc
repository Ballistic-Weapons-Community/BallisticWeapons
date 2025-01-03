//=============================================================================
// DT_FG50Overheat
//
// Damage type for people who don't know how to handle hot guns. ;)
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_FG50Overheat extends DT_BWBullet;

defaultproperties
{
     MaleSuicides(0)="%o fatally overheated his FG50 Machinegun."
     MaleSuicides(1)="%o fused his hands to an overheating gun."
     MaleSuicides(2)="%o's FG50 Machinegun burned through his hands."
     SimpleSuicideString="FG50 Machinegun Overheat"
     InvasionDamageScaling=2.000000
     DamageIdent="Assault"
     DamageDescription=",Flame,Hazard,"
     WeaponClass=Class'BWBP_SKC_Pro.FG50MachineGun'
     DeathString="%k somehow managed to burn %o with his overheating FG50."
     FemaleSuicide="%o's FG50 Machinegun burned through her hands."
     MaleSuicide="%o's FG50 Machinegun burned through his hands."
     bArmorStops=False
     bCausesBlood=False
     VehicleDamageScaling=0.200000
     VehicleMomentumScaling=0.050000
}
