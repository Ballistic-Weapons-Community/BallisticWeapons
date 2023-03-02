//=============================================================================
// DT_A73BPower.
//
// Damage for DarkStar Fire Ball
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_SkrithStaffPower extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o was the epicenter of %k's light show."
     DeathStrings(1)="%k made %o a skeleton with a meat dress."
     DeathStrings(2)="%o's corpse made a nice lantern for %k to see in the dark."
     DeathStrings(3)="%k roasted %o with a plasma bomb."
     BloodManagerName="BWBP_SWC_Pro.BloodMan_A73B"
     bIgniteFires=True
     DamageDescription=",Flame,Hazard,NonSniper,Plasma,"
     WeaponClass=Class'BWBP_SWC_Pro.SkrithStaff'
     DeathString="%k's plasma ball burned through %o."
     FemaleSuicide="%o attempted to shoot her feet."
     MaleSuicide="%o attempted to shoot his feet."
     bDelayedDamage=True
     bFlaming=True
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=2000.000000
     VehicleDamageScaling=1.500000
}
