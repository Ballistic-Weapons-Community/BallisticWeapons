//=============================================================================
// DTMD24Melee.
//
// Damagetype for RS8 wacking
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRS8Melee extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%o was beaten like an egg by %k and %kh RS8."
     DeathStrings(1)="%k used %kh RS8 pistol to tenderise %o."
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
     AimDisplacementDuration=0.650000
     WeaponClass=Class'BallisticProV55.RS8Pistol'
     DeathString="%o was beaten like an egg by %k's RS8."
     FemaleSuicide="%o beat herself up with an RS8."
     MaleSuicide="%o beat himself up with an RS8."
	 BlockFatiguePenalty=0.1
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.300000
}
