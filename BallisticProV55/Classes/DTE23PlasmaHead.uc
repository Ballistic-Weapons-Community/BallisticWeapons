//=============================================================================
// DTE23PlasmaHead.
//
// Damage type for E23 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTE23PlasmaHead extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k left %o stumped with %kh E-23."
     DeathStrings(1)="%o's head was bitten off by %k's ViPeR."
     DeathStrings(2)="%k scorched and roasted %o's tiny little head with the E-23 plasma rifle."
     BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
     bIgniteFires=True
     bHeaddie=True
     DamageIdent="Energy"
     DamageDescription=",Plasma,"
     WeaponClass=Class'BallisticProV55.E23PlasmaRifle'
     DeathString="%k left %o stumped with %kh E-23."
     FemaleSuicide="%o stumped herself with the E-23."
     MaleSuicide="%o stumped himself with the E-23."
     bAlwaysSevers=True
     bSpecial=True
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
}
