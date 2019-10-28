//=============================================================================
// DTVPRLaserHead.
//
// DT for VPR laser headshots.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTVPRLaserHead extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k swept %kh ViPeR laser across %o's stunned face."
     DeathStrings(1)="%o's head was caught up in %k's E-23 laser beam."
     DeathStrings(2)="%k's E-23 beam cauterized %o's head in half."
     SimpleKillString="E-23 'ViPeR' Laser"
     AimedString="Scoped"
     BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
     FlashThreshold=0
     FlashV=(X=2000.000000,Y=2000.000000,Z=1500.000000)
     FlashF=0.300000
     bIgniteFires=True
     bHeaddie=True
     DamageIdent="Energy"
     DamageDescription=",Laser,"
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=3.000000
     bUseMotionBlur=True
     WeaponClass=Class'BallisticProV55.E23PlasmaRifle'
     DeathString="%k swept %kh ViPeR laser across %o's stunned face."
     FemaleSuicide="%o scorched her own head off with an E-23."
     MaleSuicide="%o scorched his own head off with an E-23."
     bInstantHit=True
     GibModifier=3.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.750000
}
