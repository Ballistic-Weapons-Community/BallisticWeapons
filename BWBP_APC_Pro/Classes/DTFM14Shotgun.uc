//=============================================================================
// DTFM13Shotgun.
//
// Damage type for FM13
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTFM14Shotgun extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%o managed to blunder %vh way right in front of %k's blunderbuss."
     DeathStrings(1)="%k managed to hunt %o down and open up a massive hole where %vh spine used to be."
     DeathStrings(2)="%o never saw %ks 8 gauge slug from several feet away, taking one straight to the lungs."
     DeathStrings(3)="%k opened a window to %o's heart with a high powered blunderbuss."
     DeathStrings(4)="%o was a victim of gnasher brutality, %k's gnasher to be precise."
     InvasionDamageScaling=2
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBP_APC_Pro.FM14Shotgun'
     DeathString="%k blasted a pound of lead into %o with the FM14."
     FemaleSuicide="%o nailed herself with the FM14."
     MaleSuicide="%o nailed himself with the FM14."
	 bIgniteFires=True
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=25000.000000
     VehicleMomentumScaling=0.200000
}
