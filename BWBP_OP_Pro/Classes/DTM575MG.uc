//=============================================================================
// DTM575MG.
//
// Damage type for the M575 Machinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM575MG extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o fell to %k's Hybrid Beast in a bloody slump."
     DeathStrings(1)="%k saw %o through his hybrid scope and mowed him down."
     DeathStrings(2)="%o couldn't flee from the all seeing eye of %k's M575."
	 DeathStrings(3)="%k's M575 spotted %o and ripped him apart with 7.62 lead."
	 DeathStrings(4)="%o ran, but couldn’t hide from %k's machinegun."
	 DeathStrings(5)="%k's M575 chewed %o up like a chew toy."
     DamageIdent="Machinegun"
     WeaponClass=Class'BWBP_OP_Pro.M575Machinegun'
     DeathString="%o was torn to shreds by %k's M575."
     FemaleSuicide="%o shot herself in the foot with the M575."
     MaleSuicide="%o shot himself in the foot with the M575."
     bFastInstantHit=True
}
