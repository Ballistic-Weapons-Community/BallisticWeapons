//=============================================================================
// DTSARMelee.
//
// Damagetype for SAR Melee attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSARMelee extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k bludgeoned %o to death in a wild frenzy with the SAR."
     DeathStrings(1)="%o was pummelled into a heap by %k with the SAR."
     DeathStrings(2)="%k beat %o to a pulp with the SAR."
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=60
     AimDisplacementDuration=0.50
	 BlockFatiguePenalty=0.25
     WeaponClass=Class'BallisticProV55.SARAssaultRifle'
     DeathString="%k bludgeoned %o to death in a wild frenzy with the SAR."
     FemaleSuicide="%o beat herself to death with the SAR."
     MaleSuicide="%o beat himself to death with the SAR."
}
