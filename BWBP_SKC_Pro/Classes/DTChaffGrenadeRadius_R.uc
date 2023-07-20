//=============================================================================
// DTChaffGrenadeRadius_R.
//
// Damage type for the G51's rifle grenade radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTChaffGrenadeRadius_R extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o choked on %k's chaff grenade."
     DeathStrings(1)="%k's smokescreen covered %o's death."
     DeathStrings(2)="%o got killed by %k's lil baby smoke grenade."
     WeaponClass=Class'BWBP_SKC_Pro.G51Carbine'
     DeathString="%o choked on %k's chaff grenade."
     FemaleSuicide="%o's smoke grenade hid her 'tactical' suicide."
     MaleSuicide="%o's smoke grenade hid his 'tactical' suicide."
     bDelayedDamage=True
     VehicleDamageScaling=0.100000
}
