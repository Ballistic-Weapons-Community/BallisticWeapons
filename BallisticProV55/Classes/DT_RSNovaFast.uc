//=============================================================================
// DT_RSNovaFast.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RSNovaFast extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k scorched %kh way through %o with a Nova Staff."
     DeathStrings(1)="%o managed to jump into %k's speeding Nova shots."
     DeathStrings(2)="%o was severly roiled by %k's Nova."
     DeathStrings(3)="%o was tangled and mangled by the speeding shots of %k's Nova Staff."
     BloodManagerName="BallisticProV55.BloodMan_NovaSlow"
     bIgniteFires=True
     DamageIdent="Energy"
     DamageDescription=",NovaStaff,"
     bOnlySeverLimbs=True
     WeaponClass=Class'BallisticProV55.RSNovaStaff'
     DeathString="%k scorched %kh way through %o with a Nova Staff."
     FemaleSuicide="%o pointed her Nova Staff in the wrong direction."
     MaleSuicide="%o pointed his Nova Staff in the wrong direction."
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleMomentumScaling=0.400000
}
