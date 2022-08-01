//=============================================================================
// DTAM67Laser.
//
// DT for AM67 laser non-headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTAM67Laser extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o was cut down by %k's AM67 laser."
     DeathStrings(1)="%k burned through %o with %kh AM67."
     DeathStrings(2)="%o discovered %k's AM67 laser."
     BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
     bIgniteFires=True
     WeaponClass=Class'BallisticProV55.AM67Pistol'
     DeathString="%o discovered %k's flailing AM67 laser."
     FemaleSuicide="%o thought it was just a laser-sight."
     MaleSuicide="%o thought it was just a laser-sight."
     bInstantHit=True
     GibModifier=4.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.200000
}
