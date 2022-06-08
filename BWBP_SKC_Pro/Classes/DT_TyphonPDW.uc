//=============================================================================
// DT_TyphonPDW.
//
// Damage type for the Typhon Pulse PDW
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_TyphonPDW extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o became a holy person thanks to %k's Typhon."
     DeathStrings(1)="%k's Typhon didn’t need lead to murder %o."
     DeathStrings(2)="%o was pulsed into next week by %k's SMG."
	 DeathStrings(3)="%k gave %o a tech demo of the new Typhon."
	 DeathStrings(4)="%o got phased away by %k's Typhon."
     WeaponClass=Class'BWBP_SKC_Pro.TyphonPDW'
     DeathString="%o was capped by %k's Typhon."
     FemaleSuicide="%o nailed herself with the Typhon."
     MaleSuicide="%o nailed himself with the Typhon."
     VehicleDamageScaling=1.000000
}
