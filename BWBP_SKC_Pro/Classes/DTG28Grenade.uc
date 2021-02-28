//=============================================================================
// DTT10Grenade.
//
// Damage type for the T10 Grenade hit
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTG28Grenade extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k ironically murdered %o with a health grenade."
     BloodManagerName="BallisticV21.BloodMan_BluntSmall"
     bDetonatesBombs=False
     DamageDescription=",Blunt,Hazard,"
     WeaponClass=Class'BWBP_SKC_Pro.G28Grenade'
     DeathString="%k ironically murdered %o with a health grenade."
     FemaleSuicide="%o tripped on her own med grenade."
     MaleSuicide="%o tripped on his own med grenade."
     bDelayedDamage=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
}
