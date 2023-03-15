//=============================================================================
// DTLS440Body
//
// DT for Super Laser Carbine body shots.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_LS440Body extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="Red pulses from %k's LS440 reduced %o to ash."
     DeathStrings(1)="%k's LS-440 mercilessly lasered %o away."
     DeathStrings(2)="%o took a red storm of %k's lasers to the chest."
     DeathStrings(3)="%k singed %o's chest with a LS-440 laser fusilade."
     BloodManagerName="BWBP_SKC_Pro.BloodMan_HMCLaser"
     ShieldDamage=3
     bIgniteFires=True
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=2.000000
     DamageDescription=",Laser,"
     WeaponClass=Class'BWBP_SKC_Pro.LS440Instagib'
     DeathString="Red pulses from %k's LS440 reduced %o to ash."
     FemaleSuicide="%o cannot use a carbine effectively."
     MaleSuicide="%o stinks at using laser carbines."
     bInstantHit=True
     GibPerterbation=1.200000
     KDamageImpulse=1000.000000
}
