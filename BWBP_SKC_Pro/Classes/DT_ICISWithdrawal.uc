//=============================================================================
// DT_NukeRadiation.
//
// Damage type for junkies who can't get enough.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_ICISWithdrawal extends DT_BWFire;

defaultproperties
{
     FlashF=0.200000
     FlashV=(X=1500.000000,Y=1500.000000)
     DeathStrings(0)="%k's special stash gave %o a bad trip."
     DeathStrings(1)="%o should have known better than to take drugs from %k."
     FemaleSuicides(0)="%o had a bad trip."
     FemaleSuicides(1)="%o got addicted to some heavy stuff."
     FemaleSuicides(2)="%o overdosed on experimental military drugs."
     FemaleSuicides(3)="%o couldn't let go of the needle."
     MaleSuicides(0)="%o had a bad trip."
     MaleSuicides(1)="%o got addicted to some heavy stuff."
     MaleSuicides(2)="%o overdosed on experimental military drugs."
     MaleSuicides(3)="%o couldn't let go of the needle."
     SimpleKillString="ICIS Overdose"
     bDetonatesBombs=False
     DamageDescription=",Gas,GearSafe,Hazard,"
     MinMotionBlurDamage=1.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=3.000000
     bUseMotionBlur=True
     WeaponClass=Class'BWBP_SKC_Pro.ICISStimpack'
     DeathString="%o should have known better than to take drugs from %k."
     FemaleSuicide="%o had a bad trip."
     MaleSuicide="%o had a bad trip."
     bArmorStops=False
     bInstantHit=True
     bDelayedDamage=True
     GibPerterbation=0.100000
     KDamageImpulse=200.000000
}
