//=============================================================================
// DTGRS9LaserHead.
//
// DT for GRS9 laser headshots. Adds red blinding effect and motion blur
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTGRSXXLaserHead extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o's head was illuminated off by %k's GRS-XX beam."
     DeathStrings(1)="%k scorched a hole through %o's cranium."
     DeathStrings(2)="%k sentenced %o's head to death with a GRS-XX laser."
     SimpleKillString="GRS-XX Laser"
     BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
     FlashThreshold=0
     FlashV=(X=2000.000000,Y=700.000000,Z=700.000000)
     FlashF=0.300000
     bIgniteFires=True
     bHeaddie=True
     DamageIdent="Sidearm"
     DamageDescription=",Laser,"
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=3.000000
     bUseMotionBlur=True
     WeaponClass=Class'BWBP_SKCExp_Pro.GRSXXPistol'
     DeathString="%o's head was illuminated off by %k's GRS-XX beam."
     FemaleSuicide="%o burned her own head off with a GRS-XX."
     MaleSuicide="%o burned his own head off with a GRS-XX."
     bInstantHit=True
     GibModifier=3.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.350000
}
