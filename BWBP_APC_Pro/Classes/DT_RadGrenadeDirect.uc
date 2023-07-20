//=============================================================================
// DT_RadGrenadeDirect.
//
// Damage type for the RAD grenade impact
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RadGrenadeDirect extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k whipped a rad grenade at %o's face."
     DeathStrings(1)="%o took %k's explosive rad grenade to the face."
     WeaponClass=Class'BWBP_APC_Pro.SRKSubMachinegun'
     DeathString="%k whipped a rad grenade at %o's face."
     FemaleSuicide="%o beat the walls with her grenade like a lunatic."
     MaleSuicide="%o beat the walls with his grenade like a lunatic."
     bDelayedDamage=True
     VehicleDamageScaling=0.500000
}
