//=============================================================================
// DTVPRLaser.
//
// DT for VPR laser non-headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTVPRLaser extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o was burnt in two by %k's sacred fire."
     DeathStrings(1)="%k's burning hot E-23 laser surged through %o."
     DeathStrings(2)="%k scorched %o with %kh ViPeR laser."
     SimpleKillString="E-23 'ViPeR' Laser"
     AimedString="Scoped"
     BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
     bIgniteFires=True
     DamageIdent="Energy"
     DamageDescription=",Laser,"
     WeaponClass=Class'BallisticProV55.E23PlasmaRifle'
     DeathString="%o was burnt in two by %k's sacred fire."
     FemaleSuicide="%o accidentally scorched her own legs off with the E-23 laser."
     MaleSuicide="%o accidentally scorched his own legs off with the E-23 laser."
     bInstantHit=True
     GibModifier=4.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.750000
     VehicleMomentumScaling=0.750000
}
