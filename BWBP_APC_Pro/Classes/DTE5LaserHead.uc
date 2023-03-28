//=============================================================================
// DTVPRLaserHead.
//
// DT for VPR laser headshots.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTE5LaserHead extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o had %vh head decapitated by %k's miniature beam of death."
     DeathStrings(1)="%k gave %o a plasma power tracheostomy, still was fatal though."
     DeathStrings(2)="%o didn't read the fine print before getting lethal eye laser surgery by Dr. %k."
     DeathStrings(3)="%k drew a smiley face on %o before dying, %ve didn’t appreciate it."
     SimpleKillString="E-5 'ViPeR' Laser"
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
     WeaponClass=Class'BWBP_APC_Pro.E5PlasmaRifle'
     DeathString="%k swept %kh ViPeR laser across %o's stunned face."
     FemaleSuicide="%o scorched her own head off with an E-5."
     MaleSuicide="%o scorched his own head off with an E-5."
     bInstantHit=True
     GibModifier=3.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.750000
}
