//=============================================================================
// DTSRS900Rifle.
//
// DamageType for the SRS900 Battle Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSRS900Rifle extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k assassinated %o with %kh SRS-900."
     DeathStrings(1)="%k baptized %o with SRS-900 rounds."
     DeathStrings(2)="%o was taken down by %k's battle rifle."
     DeathStrings(3)="%o was decommissioned by %k."
     DeathStrings(4)="%k cancelled %o with %kh battle rifle."
     DeathStrings(5)="%o got %vs pacified by %k."
     DeathStrings(6)="%k stopped %o's whimpering with SRS-900 rounds."
     AimedString="Scoped"
     DamageIdent="Sniper"
     WeaponClass=Class'BallisticProV55.SRS900Rifle'
     DeathString="%k assasinated %o with %kh SRS-900."
     FemaleSuicide="%o nailed herself with the SRS-900."
     MaleSuicide="%o nailed himself with the SRS-900."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
}
