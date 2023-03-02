//=============================================================================
// DTA73BSkrithHead.
//
// Damage type for A73B headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_SkrithStaffHead extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o failed to see %k's plasma bolt to the face."
     DeathStrings(1)="%k made a jack-o-lantern with %o's skull and a plasma bolt."
     DeathStrings(2)="%o got a bolt to the bonce by %k's Shillelagh."
     DeathStrings(3)="%k bopped %o's skull with a plasma bolt."
     BloodManagerName="BWBP_SWC_Pro.BloodMan_A73B"
     bIgniteFires=True
     DamageDescription=",Flame,Plasma,"
     WeaponClass=Class'BWBP_SWC_Pro.SkrithStaff'
     DeathString="%k burned through %o's scalp with the Shillelagh."
     FemaleSuicide="%o's Shillelagh turned on her."
     MaleSuicide="%o's Shillelagh turned on him."
     bAlwaysSevers=True
     bSpecial=True
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
}
