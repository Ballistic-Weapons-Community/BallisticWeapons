//=============================================================================
// DTMD24Melee.
//
// Damagetype for A42 wacking
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA42Melee extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%o was beaten like an egg by %k and %kh A42."
     DeathStrings(1)="%k used %kh A42 pistol to tenderise %o."
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
     AimDisplacementDuration=0.650000
     WeaponClass=Class'BallisticProV55.A42SkrithPistol'
     DeathString="%o was beaten like an egg by %k's A42."
     FemaleSuicide="%o beat herself up with an A42."
     MaleSuicide="%o beat himself up with an A42."
	 BlockFatiguePenalty=0.1
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.300000
}
