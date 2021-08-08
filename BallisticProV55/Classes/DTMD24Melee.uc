//=============================================================================
// DTMD24Melee.
//
// Damagetype for MD24 wacking
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMD24Melee extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%o was beaten like an egg by %k and %kh MD24."
     DeathStrings(1)="%k used %kh MD24 pistol to tenderise %o."
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
     AimDisplacementDuration=0.650000
     WeaponClass=Class'BallisticProV55.MD24Pistol'
     DeathString="%o was beaten like an egg by %k's MD24."
     FemaleSuicide="%o beat herself up with an MD24."
     MaleSuicide="%o beat himself up with an MD24."
	 BlockFatiguePenalty=0.1
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.300000
}
