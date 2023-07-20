//=============================================================================
// DTMD24Melee.
//
// Damagetype for M806 wacking
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM806Melee extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%o was beaten like an egg by %k and %kh M806."
     DeathStrings(1)="%k used %kh M806 pistol to tenderise %o."
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
     AimDisplacementDuration=0.3
     WeaponClass=Class'BallisticProV55.M806Pistol'
     DeathString="%o was beaten like an egg by %k's M806."
     FemaleSuicide="%o beat herself up with an M806."
     MaleSuicide="%o beat himself up with an M806."
	 BlockFatiguePenalty=0.1
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.300000
}
