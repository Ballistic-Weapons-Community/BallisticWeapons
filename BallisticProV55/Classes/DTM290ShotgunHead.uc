//=============================================================================
// DTM290ShotgunHead.
//
// Damage type for M290
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM290ShotgunHead extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k uncorked %o with the M290."
     DeathStrings(1)="%o lost %vh head in an M290 brawl with %k."
     DeathStrings(2)="%k popped %o's melon with %kh M290."
     bHeaddie=True
     InvasionDamageScaling=1.500000
     DamageIdent="Shotgun"
     WeaponClass=Class'BallisticProV55.M290Shotgun'
     DeathString="%k uncorked %o with the M290."
     FemaleSuicide="%o nailed herself with the M290."
     MaleSuicide="%o nailed himself with the M290."
     bAlwaysSevers=True
     bSpecial=True
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=10000.000000
}
