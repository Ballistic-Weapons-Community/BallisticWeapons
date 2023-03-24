//=============================================================================
// DT_AK490Hit.
//
// Damagetype for AK490 Melee attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AK490Hit extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k RAGED LIKE BEAR and beat %o's face in with an AK!"
     DeathStrings(1)="%k beat %o with %kh Wooden Stock of Killing."
     DeathStrings(2)="%o was killed by a raving %k's AK-490 stock."
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
	 BlockFatiguePenalty=0.25
     AimDisplacementDamageThreshold=55
     AimDisplacementDuration=1
     WeaponClass=Class'BWBP_SKC_Pro.AK490BattleRifle'
     DeathString="%k RAGED LIKE BEAR and beat %o's face in with an AK!"
     FemaleSuicide="%o beat herself to death with the AK490."
     MaleSuicide="%o beat himself to death with the AK490."
}
