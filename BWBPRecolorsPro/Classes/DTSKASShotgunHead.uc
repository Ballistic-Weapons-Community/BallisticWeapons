//=============================================================================
// DTSKASShotgunHead.
//
// Damage type for SKAS head
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSKASShotgunHead extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k's 10-gauge street sweeper clipped off %o's head."
     DeathStrings(1)="%o's mind was blown by %k's 10-gauge rotary beast."
     DeathStrings(2)="%k executed %o with a massive 10-gauge cannon."
     bHeaddie=True
     InvasionDamageScaling=1.500000
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBPRecolorsPro.SKASShotgun'
     DeathString="%k's 10-gauge street sweeper clipped off %o's head."
     FemaleSuicide="%o put the SKAS to her chin and shot."
     MaleSuicide="%o put a SKAS to his chin and fired."
     bAlwaysSevers=True
     bSpecial=True
     GibPerterbation=0.400000
     KDamageImpulse=10000.000000
}
