//=============================================================================
// DT_FLASHRadius.
//
// DamageType for the FLASH incendiary rocket radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_FLASHRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o suffered a fiery death thanks to %k's STREAK."
     DeathStrings(1)="%o was flash roasted by %k's incendiary rocket."
     DeathStrings(2)="%k gave %o a good burn with %kh AT40 STREAK."
     DeathStrings(3)="%k's MD40 rocket seared the skin off %o."
     DeathStrings(4)="%k FLASHed %o into a smoldering pile of ash."
     InvasionDamageScaling=2.000000
     DamageIdent="Killstreak"
     WeaponClass=Class'BWBP_SKC_Pro.FLASHLauncher'
     DeathString="%o suffered a fiery death thanks to %k's STREAK."
     FemaleSuicide="%o didn't realize rockets are bad for close range combat."
     MaleSuicide="%o didn't realize rockets are bad for close range combat."
     bDelayedDamage=True
     VehicleMomentumScaling=0.400000
}
