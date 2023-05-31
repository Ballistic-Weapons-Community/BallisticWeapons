//=============================================================================
// DTChaffGrenadeRadius.
//
// Damage type for the MOA-C grenade radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_SHADRACHGrenadeRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k forced evolved %o into a radioactive mess."
     DeathStrings(1)="%o got disoriented and died into %k's radioactive chaff cloud."
     DeathStrings(2)="%k made %o sniff their green cloud, warping their DNA strands into a Dali painting."
	 DeathStrings(3)="%o was redirected into %k's radioactive mist and got lost."
	 DeathStrings(4)="%k scrambled %o so much, that they became a pile of green goo."
     WeaponClass=Class'BWBP_APC_Pro.SRKSubMachinegun'
     DeathString="%o unexpectedly died to %k's SHADRACH chaff grenade."
     FemaleSuicide="%o shouldn't huff in that radioactive cloud, whatever gets them high amirite?"
     MaleSuicide="%o tried to redirect incoming missiles into the cloud, but they got lost instead."
     bDelayedDamage=True
     bExtraMomentumZ=True
     VehicleDamageScaling=0.500000
}
