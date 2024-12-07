//=============================================================================
// DTHMCMelee.
//
// HMC Bonk
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTHMCMelee extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k cracked %o's skull %kh HMC-117."
     DeathStrings(1)="%o took %k's HMC to the face."
     DeathStrings(2)="%k got medieval on %o with a laser cannon."
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
	 BlockFatiguePenalty=0.25
     AimDisplacementDamageThreshold=60
     AimDisplacementDuration=0.75
     WeaponClass=Class'BWBP_SKC_Pro.HMCBeamCannon'
     DeathString="%k cracked %o's skull %kh HMC-117."
     FemaleSuicide="%o headbutter her HMC."
     MaleSuicide="%o headbutted his HMC."
     bExtraMomentumZ=True
}
