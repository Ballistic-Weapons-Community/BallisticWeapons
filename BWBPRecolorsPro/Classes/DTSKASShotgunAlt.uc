//=============================================================================
// DTSKASShotgunAlt.
//
// Damage type for SKAS Automatic Shotgun Tri-Blasts
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSKASShotgunAlt extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k's SKAS-21 blew %o torso apart with a triple blast."
     DeathStrings(1)="%k targeted and annihilated %o with a SKAS tri-blast."
     DeathStrings(2)="%o was blown apart by %k's three SKAS-21 barrels."
     DeathStrings(3)="%o swallowed a triple barrel blast from %k's SKAS."
     DeathStrings(4)="%k's SKAS-21 absolutely destroyed hapless %o."
     InvasionDamageScaling=3
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBPRecolorsPro.SKASShotgun'
     DeathString="%k's SKAS-21 blew %o torso apart with a triple blast."
     FemaleSuicide="%o's triple barrel blast ensured a lethal suicide."
     MaleSuicide="%o's triple barrel blast ensured a lethal suicide."
     GibPerterbation=0.400000
     KDamageImpulse=15000.000000
}
