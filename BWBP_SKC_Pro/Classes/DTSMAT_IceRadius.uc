//=============================================================================
// DTSMAT_IceRadius.
//
// DamageType for the SMAT freezy radius of coldness
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSMAT_IceRadius extends DT_BWExplode;

defaultproperties
{
	FlashV=(Z=2000.000000)
	FlashF=0.300000
	DeathStrings(0)="%k's forecast was a 100% chance of %o being frozen by a SMAT."
	DeathStrings(1)="%k's SMAT cryo rocket ensured %o was cold as ice."
	DeathStrings(2)="%o went into permenant cryo stasis thanks to %k's SMAT ice rocket."
	DeathStrings(3)="%k gave more than just frostbite to %o with %kh SMAT ice rocket."
	FemaleSuicides(0)="%o tried to cool off with a SMAT ice rocket."
	FemaleSuicides(1)="%o was given the cold shoulder by her SMAT."
	FemaleSuicides(2)="%o's SMAT turned her into a snow angel."
	MaleSuicides(0)="%o tried to cool off with a SMAT ice rocket."
	MaleSuicides(1)="%o was given the cold shoulder by his SMAT."
	MaleSuicides(2)="%o's SMAT turned him into a snow angel."
	SimpleKillString="SMAT Ice Rocket Radius"
	WeaponClass=Class'BWBP_SKC_Pro.SMATLauncher'
	DeathString="%k's forecast was a 100% chance of %o being frozen by a SMAT."
	FemaleSuicide="%o tried to cool off with a SMAT ice rocket."
	MaleSuicide="%o tried to cool off with a SMAT ice rocket."
	bDelayedDamage=True
	VehicleDamageScaling=0.300000
	VehicleMomentumScaling=0.400000
}
