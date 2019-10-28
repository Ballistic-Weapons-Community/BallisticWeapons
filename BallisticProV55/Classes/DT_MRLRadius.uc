//=============================================================================
// DT_MRLRadius.
//
// DamageType for the JL-21 PeaceMaker radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MRLRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k's PeaceMaker made peace with %o."
     DeathStrings(1)="%o was bounced around the map by %k's JL-21."
     DeathStrings(2)="%o flapped around like a limp fish in %k's MRL hailstorm."
     DeathStrings(3)="%k bombarded the %o zone with JL-21 missiles."
     FemaleSuicides(0)="%o cracked herself open with her own JL-21 rockets."
     FemaleSuicides(1)="%o unleashed a fusillade upon herself."
     MaleSuicides(0)="%o cracked himself open with his own JL-21 rockets."
     MaleSuicides(1)="%o unleashed a fusillade upon himself."
     DamageIdent="Streak"
     WeaponClass=Class'BallisticProV55.MRocketLauncher'
     DeathString="%k's PeaceMaker made peace with %o."
     FemaleSuicide="%o cracked herself open with her own JL-21 rockets."
     MaleSuicide="%o cracked himself open with his own JL-21 rockets."
     bDelayedDamage=True
}
