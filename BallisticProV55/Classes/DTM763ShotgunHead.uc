//=============================================================================
// DTM763ShotgunHead.
//
// Damage type for M763
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM763ShotgunHead extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k uncorked %o with the M763."
     DeathStrings(1)="%o's head was blasted clean off by %k's M763."
     DeathStrings(2)="%k obliterated %o's head with %kh M763."
     DeathStrings(3)="%k's Avenger blast purged %o's face from the battlefield."
     bHeaddie=True
     InvasionDamageScaling=1.500000
     DamageIdent="Shotgun"
     WeaponClass=Class'BallisticProV55.M763Shotgun'
     DeathString="%k uncorked %o with the M763."
     FemaleSuicide="%o nailed herself with the M763."
     MaleSuicide="%o nailed himself with the M763."
     bAlwaysSevers=True
     bSpecial=True
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=10000.000000
}
