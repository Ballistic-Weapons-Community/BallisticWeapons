//=============================================================================
// DT_RSDarkPlasma.
//
// Damage for DarkStar plasma
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RSDarkPlasma extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%k's dark plasma obliterated %o."
     DeathStrings(1)="%o got caught in %k's Dark Star plasma blast."
     DeathStrings(2)="%o was seared raw by %k's Dark Star."
     DeathStrings(3)="%o writhed in agony as %k's dark plasma raged over %vh."
     DeathStrings(4)="%k poured fire all over %o's screaming figure."
     SimpleKillString="Dark Star Flamer"
     DamageIdent="Energy"
     DamageDescription=",Flame,Hazard,NonSniper,DarkStar,"
     WeaponClass=Class'BallisticProV55.RSDarkStar'
     DeathString="%k's dark plasma obliterated %o."
     FemaleSuicide="%o seared herself raw."
     MaleSuicide="%o seared himself raw."
     bSkeletize=True
     bDelayedDamage=True
     KDamageImpulse=2000.000000
}
