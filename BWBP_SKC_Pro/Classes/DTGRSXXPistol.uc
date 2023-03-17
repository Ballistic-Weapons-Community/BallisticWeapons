//=============================================================================
// DTGRS9Pistol.
//
// Damage type for the GRS9 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTGRSXXPistol extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k prosecuted %o with %kh GRS-XX."
     DeathStrings(1)="%o was acquitted by %k's GRS-XX."
     DeathStrings(2)="%o was vindicated by %k's GRS-XX."
     DeathStrings(3)="%k intimidated %o to pieces with %kh GRS-XX."
     DamageIdent="Pistol"
	 InvasionDamageScaling=1.5
     WeaponClass=Class'BWBP_SKC_Pro.GRSXXPistol'
     DeathString="%k prosecuted %o with %kh GRS-XX."
     FemaleSuicide="%o prosecuted herself with the GRS-XX."
     MaleSuicide="%o prosecuted himself with the GRS-XX."
     VehicleDamageScaling=0.000000
}
