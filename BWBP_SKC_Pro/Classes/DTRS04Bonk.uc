//=============================================================================
// DTRS04Bonk.
//
// Damagetype for bonk
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRS04Bonk extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k bonked %o with an RS04."
     DeathStrings(1)="%o got the bonk from %k's RS04."
     DeathStrings(2)="%k slapped %o with an RS04."
     DamageIdent="Melee"
     AimDisplacementDamageThreshold=25
     AimDisplacementDuration=0.50
	 BlockFatiguePenalty=0.1
     WeaponClass=Class'BWBP_SKC_Pro.RS04Pistol'
     DeathString="%k bonked %o with an RS04."
     FemaleSuicide="%o committed self-bonk."
     MaleSuicide="%o committed self-bonk."
     KDamageImpulse=1000.000000
}
