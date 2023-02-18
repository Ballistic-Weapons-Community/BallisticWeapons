//=============================================================================
// DTFM13Shotgun.
//
// Damage type for FM13
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_TrenchFire extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%o was chewed up like a piece of meat by %k's Trenchgun."
     DeathStrings(1)="%k unleashed the dragon's breath on %o."
     DeathStrings(2)="%o couldn't slay the dragon and got roasted by %k's Trenchgun."
     DeathStrings(3)="%k sicced his Trenchgun onto %o, good shotgun gets a treat."
     InvasionDamageScaling=2
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBP_OP_Pro.TrenchGun'
     DeathString="%k blasted a pound of lead into %o with the Trenchgun."
     FemaleSuicide="%o nailed herself with the Trenchgun."
     MaleSuicide="%o nailed himself with the Trenchgun."
	 bIgniteFires=True
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=25000.000000
     VehicleMomentumScaling=0.200000
}
