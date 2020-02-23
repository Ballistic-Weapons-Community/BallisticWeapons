//=============================================================================
// DT_SK410.
//
// Damage type for the HE SK410 shells
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_ARShotgun extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o only wishes that %k's SK-410 was capable of jamming."
     DeathStrings(1)="%k 8-Gauge SK-410 exiled pieces of %o."
     DeathStrings(2)="%k's SK-410 blasted %o out of the Eastern Bloc."
     DeathStrings(3)="%k gave %o an iron curtain of explosive shotgun shells."
     DeathStrings(4)="%k redistributed %kh wealth of HE shotshells to %o."
     bIgniteFires=True
     InvasionDamageScaling=1.500000
     DamageIdent="Shotgun"
     DamageDescription=",Bullet,Flame,"
     WeaponClass=Class'BallisticJiffyPack.ARShotgun'
     DeathString="%o's only wishes that %k's SK-410 was capable of jamming."
     FemaleSuicide="%o amputated a foot with the SK410"
     MaleSuicide="%o removed some toes with his SK410."
     bFastInstantHit=True
     bExtraMomentumZ=True
     GibPerterbation=2.000000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.600000
}
