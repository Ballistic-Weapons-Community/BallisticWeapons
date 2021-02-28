//=============================================================================
// DTLS14Body
//
// DT for Laser Carbine body shots.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTLS14Body extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o's lungs were turned to ashes by %k's laser carbine."
     DeathStrings(1)="%k's LS-14 created a sizzling hole where %o's heart was."
     DeathStrings(2)="%o found his torso fried by %k's LS-14."
     DeathStrings(3)="%k lasered %o's life away with his carbine."
     DeathStrings(4)="%o was at the receiving end of %k's energy carbine."
     SimpleKillString="LS-14 Single Barrel"
     BloodManagerName="BloodMan_HMCLaser"
     ShieldDamage=3
     bIgniteFires=True
     DamageIdent="Sniper"
     DamageDescription=",Laser,"
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=2.000000
     WeaponClass=Class'BWBPRecolorsPro.LS14Carbine'
     DeathString="%o's lungs were turned to ashes by %k's laser carbine."
     FemaleSuicide="%o cannot use a carbine effectively."
     MaleSuicide="%o stinks at using laser carbines."
     bInstantHit=True
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.600000
     VehicleMomentumScaling=0.400000
}
