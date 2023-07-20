//=============================================================================
// DT_XM20Head.
//
// Sergeant Kelly: Concrete is not a color scheme!
// Jiffy: hmm
// TheXavious: IT IS DO NOT QUESTION IT
// Jiffy: in honesty i do like the current xm20, especially with its shield mode
// TheXavious: Rename mine to not xm20 because its not written on the side
//
// by Sarge
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_XM20_Head extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o looked directly into %k's laser carbine."
     DeathStrings(1)="%k disintegrated %o's face with a laser assault rife."
     DeathStrings(2)="%k's XM-20 burned a neat hole directly through %o's forehead."
     DeathStrings(3)="%o should not have stared into %k's laser."
     SimpleKillString="XM20 Laser Carbine Head"
     BloodManagerName="BloodMan_HMCLaser"
     FlashThreshold=0
     FlashV=(X=700.000000,Y=700.000000,Z=2000.000000)
     FlashF=0.300000
     ShieldDamage=5
     bIgniteFires=True
     bHeaddie=True
     DamageIdent="Energy"
     DamageDescription=",Laser,"
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     bUseMotionBlur=True
     WeaponClass=Class'BWBP_SKC_Pro.XM20Carbine'
     DeathString="%o looked directly into %k's laser carbine."
     FemaleSuicide="%o blasted her eyes out."
     MaleSuicide="%o blasted himself in the eye."
     bInstantHit=True
     bAlwaysSevers=True
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
}