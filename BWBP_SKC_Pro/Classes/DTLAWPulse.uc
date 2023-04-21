//=============================================================================
// DTLAWPulse.
//
// DamageType for the LAW pulse mine radius. Ignores armor.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTLAWPulse extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o got %vh neurons scrambled by %k's LAW pulse."
     DeathStrings(1)="%o had some organs ruptured by %k's LAW pulse."
     DeathStrings(2)="%k's LAW mine ruptured %o's fragile brain."
     DeathStrings(3)="%o camped out by %k's pulsating LAW mine."
     DeathStrings(4)="%k's LAW mine shook %o out of %vh hiding spot."
     FemaleSuicides(0)="%o basked in the blue glow of her LAW mine."
     FemaleSuicides(1)="%o ignored the warning labels on her LAW mine."
     FemaleSuicides(2)="%o got a fatal dose of radiation from his own LAW mine."
     MaleSuicides(0)="%o basked in the blue glow of his LAW mine."
     MaleSuicides(1)="%o ignored the warning labels on his LAW mine."
     MaleSuicides(2)="%o got a fatal dose of radiation from his own LAW mine."
     SimpleKillString="LAW Shockwave"
     InvasionDamageScaling=3.000000
     DamageIdent="Killstreak"
     WeaponClass=Class'BWBP_SKC_Pro.LAWLauncher'
     DeathString="%o got %vh neurons scrambled by %k's LAW pulse."
     FemaleSuicide="%o basked in the blue glow of her LAW mine."
     MaleSuicide="%o basked in the blue glow of his LAW mine."
     bDelayedDamage=True
     bNeverSevers=True
     bArmorStops=False
     VehicleDamageScaling=1.900000
     VehicleMomentumScaling=0.800000
}
