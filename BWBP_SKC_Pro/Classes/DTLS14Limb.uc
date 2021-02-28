//=============================================================================
// DTLS14Body
//
// DT for Laser Carbine limb shots.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTLS14Limb extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k accurately lasered off %o's arms with %kh LS-14."
     DeathStrings(1)="%k's precise LS-14 aiming turned %o into an amputee."
     DeathStrings(2)="%o lost an arm and a leg to %k and the LS-14."
     SimpleKillString="LS-14 Single Barrel"
     BloodManagerName="BloodMan_HMCLaser"
     ShieldDamage=3
     bIgniteFires=True
     DamageIdent="Sniper"
     DamageDescription=",Laser,"
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=2.000000
     WeaponClass=Class'BWBP_SKC_Pro.LS14Carbine'
     DeathString="%k accurately lasered off %o's arms with %kh LS-14."
     FemaleSuicide="%o cannot use a carbine effectively."
     MaleSuicide="%o stinks at using laser carbines."
     bInstantHit=True
     GibModifier=1.500000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.600000
}
