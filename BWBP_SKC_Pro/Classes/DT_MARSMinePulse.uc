//=============================================================================
// DT_MARSPulse.
//
// DamageType for the MARS-3 pulse mine radius. Ignores armor.
//
// by Sergeant Kelly
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MARSMinePulse extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o basked in %k's pretty blue MARS pulsewaves."
     DeathStrings(1)="%o's simple brain hemorrhaged thanks to %k's MARS mine."
     DeathStrings(2)="%k's MARS pulse turned %o's insides to jello."
     DeathStrings(3)="%o stuck around to play with %k's MARS mine."
     DeathStrings(4)="%k's MARS mine burned out %o's brain."
     FemaleSuicides(0)="%o strobed out."
     FemaleSuicides(1)="%o was fatally attracted to her pretty MARS mine."
     FemaleSuicides(2)="%o basked in the blue glow of her MARS mine."
     MaleSuicides(0)="%o strobed out."
     MaleSuicides(1)="%o was fatally attracted to his pretty MARS mine."
     MaleSuicides(2)="%o basked in the blue glow of his MARS mine."
     WeaponClass=Class'BWBP_SKC_Pro.MARSAssaultRifle'
     SimpleKillString="MARS-2 Pulse Grenade"
     bArmorStops=False
     bNeverSevers=True
     DeathString="%o basked in %k's pretty blue MARS pulsewaves."
     FemaleSuicide="%o strobed out."
     MaleSuicide="%o strobed out."
     bDelayedDamage=True
     VehicleDamageScaling=1.900000
     VehicleMomentumScaling=0.800000
}
