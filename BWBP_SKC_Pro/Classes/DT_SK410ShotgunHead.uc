//=============================================================================
// DT_SK410Head.
//
// Damage type for the DT_SK410 DT_SK410DT_SK410DT_SK410.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_SK410ShotgunHead extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="With the aid of %k SK-410, %o's head revolted successfully from %vh body."
     DeathStrings(1)="%k's SK-410 removed %o's mental Bloc."
     DeathStrings(2)="%k's SK-410 Article 58'd %o's face off."
     DeathStrings(3)="%o was shown the true meaning of No Excuses by %k's SK-410."
     DeathStrings(4)="%o's frostbitten face was warmed by %k's SK-410."
     EffectChance=0.500000
     bIgniteFires=True
     bHeaddie=True
     InvasionDamageScaling=2
     DamageIdent="Shotgun"
     DamageDescription=",Bullet,Flame,"
     WeaponClass=Class'BWBP_SKC_Pro.SK410Shotgun'
     DeathString="With the aid of %k SK-410, %o's head revolted successfully from %vh body."
     FemaleSuicide="%o is a little too drunk to use an SK-410."
     MaleSuicide="%o is a little too drunk to use an SK-410."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     bExtraMomentumZ=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=1.600000
     KDamageImpulse=1000.000000
}
