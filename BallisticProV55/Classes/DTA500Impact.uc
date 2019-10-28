//=============================================================================
// DTA500Impact.
//
// Damage type for the A500 blob impact.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA500Impact extends DTA500Blast;

defaultproperties
{
     DeathStrings(0)="%k sent a sizzling glob of acid into %o's face."
     DeathStrings(1)="%o stumbled into %k's A500 acid blob."
     DeathStrings(2)="%k fired a burning acidic bomb down %o's throat."
     SimpleKillString="A500 Acid Bomb"
     InvasionDamageScaling=2.000000
     DeathString="%k sent a sizzling glob of acid into %o's face."
     FemaleSuicide="%o drank her own A500 acid blob."
     MaleSuicide="%o drank his own A500 acid blob."
     bExtraMomentumZ=True
}
