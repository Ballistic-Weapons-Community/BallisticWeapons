//=============================================================================
// DTX3Knife.
//
// Damagetype for X3 Knife
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRS8X3Knife extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k viciously shanked %o with the X3."
     DeathStrings(1)="%o was stabbed in the back by %k."
     DeathStrings(2)="%k gutted %o like a fish."
     DeathStrings(3)="%o lurched onto %k's outstretched X3."
     DamageIdent="Melee"
     AimDisplacementDamageThreshold=25
     AimDisplacementDuration=0.5
	 BlockFatiguePenalty=0.1
     WeaponClass=Class'BWBP_APC_Pro.RS8X3Pistol'
     DeathString="%k viciously shanked %o with the X3."
     FemaleSuicide="%o forgot how to use the handle of her X3."
     MaleSuicide="%o forgot how to use the handle of his X3."
     KDamageImpulse=1000.000000
}
