//=============================================================================
// DTGRS9Melee.
//
// Damagetype for GRS9 wacking
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTGRS9Melee extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%o got a good pistol whipping from %k and %kh GRS9."
     DeathStrings(1)="%k used %kh GRS9 pistol to pacify %o."
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
     AimDisplacementDuration=0.30
     WeaponClass=Class'BallisticProV55.GRS9Pistol'
     DeathString="%o got a good pistol whipping from %k and %kh GRS9."
     FemaleSuicide="%o beat herself up with an GRS9."
     MaleSuicide="%o beat himself up with an GRS9."
	 BlockFatiguePenalty=0.1
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.300000
}
