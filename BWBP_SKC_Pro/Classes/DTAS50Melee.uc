//=============================================================================
// DTAS50Melee.
//
// You got beat down by the FSSG-50 Machinegun biznitch.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTAS50Melee extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k pummeled %o with %kh FSSG-50 stock."
     DeathStrings(1)="%o was beat down by %k's FSSG-50."
     DeathStrings(2)="%k's FSSG-50 cracked a couple of %o's ribs."
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
	 BlockFatiguePenalty=0.25
     AimDisplacementDamageThreshold=60
     AimDisplacementDuration=1
     WeaponClass=Class'BWBP_SKC_Pro.AS50Rifle'
     DeathString="%k pummeled %o with %kh FSSG-50 stock."
     FemaleSuicide="%o bashed herself with the FSSG-50."
     MaleSuicide="%o headbutted his FSSG-50 Machinegun."
     bExtraMomentumZ=True
}
