//=============================================================================
// DT_RSDarkFireBomb.
//
// Damage for DarkStar Fire Ball
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RSDarkFireBomb extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%k's DarkStar fireball destroyed %o."
     DeathStrings(1)="%o was bombarded by %k's Dark hellfire bomb."
     DeathStrings(2)="%k slung a burning hot fireball under %o's legs."
     DeathStrings(3)="%o got scorched in half by %k's unholy fireball."
     DeathStrings(4)="%k's fireball burned a hole through %o's chest."
     SimpleKillString="Dark Star Fireball"
     DamageIdent="Energy"
     DamageDescription=",Flame,Hazard,NonSniper,DarkStar,"
     WeaponClass=Class'BallisticProV55.RSDarkStar'
     DeathString="%k's fireball burned a hole through %o's chest."
     FemaleSuicide="%o bombed herself with a Dark fireball."
     MaleSuicide="%o bombed himself with a Dark fireball."
     bSkeletize=True
     bDelayedDamage=True
     KDamageImpulse=2000.000000
     VehicleDamageScaling=1.000000
     VehicleMomentumScaling=0.500000
}
