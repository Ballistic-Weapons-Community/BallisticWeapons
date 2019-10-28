//=============================================================================
// DTF2000Pulse.
//
// DamageType for the MARS-3 pulse mine radius. Ignores armor.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTF2000Pulse extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o got %vh neurons scrambled by %k's MARS-3 pulse."
     DeathStrings(1)="%o had some organs ruptured by %k's MARS-3 pulse."
     DeathStrings(2)="%k's MARS-3 mine ruptured %o's fragile brain."
     DeathStrings(3)="%o camped out by %k's pulsating MARS-3 mine."
     DeathStrings(4)="%k's MARS-3 mine shook %o out of %vh hiding spot."
     FemaleSuicides(0)="%o basked in the blue glow of her MARS-3 mine."
     FemaleSuicides(1)="%o ignored the warning labels on her MARS-3 mine."
     FemaleSuicides(2)="%o got a fatal dose of radiation from his own MARS-3 mine."
     MaleSuicides(0)="%o basked in the blue glow of his MARS-3 mine."
     MaleSuicides(1)="%o ignored the warning labels on his MARS-3 mine."
     MaleSuicides(2)="%o got a fatal dose of radiation from his own MARS-3 mine."
     SimpleKillString="MARS-3 Shockwave Grenade"
     DamageIdent="Assault"
     WeaponClass=Class'BWBPRecolorsPro.F2000AssaultRifle'
     DeathString="%o got %vh neurons scrambled by %k's MARS-3 pulse."
     FemaleSuicide="%o basked in the blue glow of her MARS-3 mine."
     MaleSuicide="%o basked in the blue glow of his MARS-3 mine."
     bDelayedDamage=True
     bNeverSevers=True
     VehicleDamageScaling=1.900000
     VehicleMomentumScaling=0.800000
}
