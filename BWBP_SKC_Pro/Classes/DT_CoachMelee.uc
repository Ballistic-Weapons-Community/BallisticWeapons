//=============================================================================
// DTCoachMelee.
//
// You got beat down by the coach gun biznitch.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_CoachMelee extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k pummeled %o with %kh coach gun stock."
     DeathStrings(1)="%o was beat down by %k's coach gun."
     DeathStrings(2)="%k's coach gun cracked a couple of %o's ribs."
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
	 BlockFatiguePenalty=0.25
     AimDisplacementDamageThreshold=60
     AimDisplacementDuration=0.75
     WeaponClass=Class'BWBP_SKC_Pro.CoachGun'
     DeathString="%k pummeled %o with %kh coach gun stock."
     FemaleSuicide="%o bashed herself with the coach gun."
     MaleSuicide="%o headbutted his coach gun."
     bExtraMomentumZ=True
}
