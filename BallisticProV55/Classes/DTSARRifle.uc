//=============================================================================
// DTSARRifle.
//
// Damage type for the SAR12
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSARRifle extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o's light was snuffed out by %k's S-AR 12."
     DeathStrings(1)="%k tore through %o with %kh sub-assault rifle."
     DeathStrings(2)="%k's S-AR 12 riddled %o with holes."
     DeathStrings(3)="%k's S-AR 12 consecrated it's way through %o."
     DeathStrings(4)="%k assaulted %o with %kh compact carbine."
     DeathStrings(5)="%k dispatched %o with S-AR 12 rounds."
     DeathStrings(6)="%o was cleaned out by %k's sub-assault rifle."
     EffectChance=0.500000
     DamageIdent="Assault"
     WeaponClass=Class'BallisticProV55.SARAssaultRifle'
     DeathString="%o's light was snuffed out by %k's S-AR 12."
     FemaleSuicide="%o consecrated herself."
     MaleSuicide="%o consecrated himself."
     bFastInstantHit=True
}
