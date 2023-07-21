//=============================================================================
// DTSARLaserBal.
//
// DT for SAR laser non-headshots
//
// by Nolan "Dark Carnivour" Richert. Kab
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSARLaser extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o was seared by %k's SAR laser."
     DeathStrings(1)="%k scorched through %o with %kh SAR."
     DeathStrings(2)="%k grilled %o with %kh SAR laser."
     BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
     bIgniteFires=True
     WeaponClass=Class'BallisticProV55.SARAssaultRifle'
     DeathString="%o was seared by %k's SAR laser."
     FemaleSuicide="%o thought it was just a laser-sight."
     MaleSuicide="%o  thought it was just a laser-sight."
     bInstantHit=True
     GibModifier=3.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.200000
}
