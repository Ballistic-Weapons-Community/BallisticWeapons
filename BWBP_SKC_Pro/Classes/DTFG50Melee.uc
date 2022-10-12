//=============================================================================
// DTFG50Melee.
//
// You got beat down by the FG50 Machinegun biznitch.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTFG50Melee extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k pummeled %o with %kh FG50 stock."
     DeathStrings(1)="%o was beat down by %k's FG50."
     DeathStrings(2)="%k's FG50 cracked a couple of %o's ribs."
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
	 BlockFatiguePenalty=0.25
     AimDisplacementDamageThreshold=60
     AimDisplacementDuration=1
     WeaponClass=Class'BWBP_SKC_Pro.FG50Machinegun'
     DeathString="%k pummeled %o with %kh FG50 stock."
     FemaleSuicide="%o bashed herself with the FG50."
     MaleSuicide="%o headbutted his FG50 Machinegun."
     bExtraMomentumZ=True
}
