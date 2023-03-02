//=============================================================================
// DTM763Hit.
//
// Damagetype for M763 Melee attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTFM13Hit extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k bludgeoned %o to death in a wild frenzy with the FM13."
     DeathStrings(1)="%o was pummelled into a heap by %k with the FM13."
     DeathStrings(2)="%k beat %o to a pulp with the FM13."
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=60
     AimDisplacementDuration=0.65
	 BlockFatiguePenalty=0.25
     WeaponClass=Class'BWBP_APC_Pro.FM13Shotgun'
     DeathString="%k bludgeoned %o to death in a wild frenzy with the FM13."
     FemaleSuicide="%o beat herself to death with the FM13."
     MaleSuicide="%o beat himself to death with the FM13."
}
