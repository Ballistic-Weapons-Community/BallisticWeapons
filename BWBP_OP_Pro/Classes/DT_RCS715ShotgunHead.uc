//=============================================================================
// DT_SK410Head.
//
// Damage type for the DT_SK410 DT_SK410DT_SK410DT_SK410.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RCS715ShotgunHead extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o had %vh head tactically busted off by %k's RCS-715."
     DeathStrings(1)="%k shredded %o's head to pieces with %kh RCS-715 shells."
     DeathStrings(2)="%k emptied %kh RCS-715 drum magazine all over %o's head."
     DeathStrings(3)="%o's head was met with a barrage of RCS-715 shotgun shells from %k."
     DeathStrings(4)="%o had %vh brains busted by %k's RCS-715."
     EffectChance=0.500000
     bIgniteFires=True
     bHeaddie=True
     InvasionDamageScaling=2
     DamageIdent="Shotgun"
     DamageDescription=",Bullet,Flame,"
     WeaponClass=Class'BWBP_OP_Pro.RCS715Shotgun'
     DeathString="%o had their head tactically busted off by %k's RCS-715."
     FemaleSuicide="%o pointed her RCS-715 the wrong way round."
     MaleSuicide="%o pointed his RCS-715 the wrong way round."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     bExtraMomentumZ=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=1.600000
     KDamageImpulse=1000.000000
}
