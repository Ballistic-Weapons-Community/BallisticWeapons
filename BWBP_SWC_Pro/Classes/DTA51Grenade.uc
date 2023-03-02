//=============================================================================
// DTFP7Grenade.
//
// Damage type for the FP7 Grenade hit
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA51Grenade extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k bounced an A51 off %o's head."
     BloodManagerName="BallisticProV55.BloodMan_BluntSmall"
     bDetonatesBombs=False
     DamageDescription=",Blunt,Hazard,"
     WeaponClass=Class'BWBP_SWC_Pro.A51Grenade'
     DeathString="%k bounce an A51 off %o's head."
     FemaleSuicide="%o tripped on her own A51."
     MaleSuicide="%o tripped on his own A51."
     bDelayedDamage=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
}
