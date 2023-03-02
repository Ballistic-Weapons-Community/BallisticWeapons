//=============================================================================
// DTFP7Grenade.
//
// Damage type for the FP7 Grenade hit
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTAmmoPack extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k bounced an ammo pack off %o's head."
     BloodManagerName="BallisticProV55.BloodMan_BluntSmall"
     bDetonatesBombs=False
     DamageDescription=",Blunt,Hazard,"
     WeaponClass=Class'BWBP_SWC_Pro.L8GIAmmoPack'
     DeathString="%k bounce an ammo pack off %o's head."
     FemaleSuicide="%o tripped on her own ammo pack."
     MaleSuicide="%o tripped on his own ammo pack."
     bDelayedDamage=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
}
