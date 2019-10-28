//=============================================================================
// DTSRS600Rifle.
//
// DamageType for the SRS600 Battle Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSRS600Rifle extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k assassinated %o with %kh SRS-600."
     DeathStrings(1)="%k baptized %o with SRS-600 rounds."
     DeathStrings(2)="%o was taken down by %k's battle rifle."
     DeathStrings(3)="%o was decommissioned by %k."
     DeathStrings(4)="%k cancelled %o with %kh battle rifle."
     DeathStrings(5)="%o got %vs pacified by %k's SRS-600."
     DeathStrings(6)="%k stopped %o's whimpering with SRS-600 rounds."
     DamageIdent="Assault"
     WeaponClass=Class'BallisticProV55.SRS600Rifle'
     DeathString="%k assassinated %o with %kh SRS-600."
     FemaleSuicide="%o nailed herself with the SRS-600."
     MaleSuicide="%o nailed himself with the SRS-600."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
}
