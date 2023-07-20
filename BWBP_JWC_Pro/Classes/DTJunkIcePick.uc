//=============================================================================
// DTJunkIcePick.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkIcePick extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k tore %o to shredds with an ice pick."
     DeathStrings(1)="%o was torn down in path of %k's ice-pick frenzy."
     DeathStrings(2)="%k lurched onto %o and eviscerated %vm with an ice-pick."
     BloodManagerName="BallisticFix.BloodMan_Slash"
     ShieldDamage=35
     DamageDescription=",Hack,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkIcePick'
     DeathString="%k tore %o to shredds with an ice pick."
     FemaleSuicide="%o iced herself with a pick."
     MaleSuicide="%o iced himself with a pick."
}
