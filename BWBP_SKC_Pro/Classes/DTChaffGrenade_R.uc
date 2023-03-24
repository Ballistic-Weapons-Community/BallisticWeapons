//=============================================================================
// DTChaffGrenade_R.
//
// Damage type for the G51's rifle grenade impact
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTChaffGrenade_R extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k beaned %o with an MOA-C rifle grenade."
     DeathStrings(1)="%o didn't see %k's MOA-C grenade coming."
     WeaponClass=Class'BWBP_SKC_Pro.G51Carbine'
     DeathString="%k beaned %o with an MOA-C rifle grenade."
     FemaleSuicide="%o launched an MOA-C into her chest."
     MaleSuicide="%o launched an MOA-C into his chest."
     bDelayedDamage=True
     VehicleDamageScaling=0.100000
}
