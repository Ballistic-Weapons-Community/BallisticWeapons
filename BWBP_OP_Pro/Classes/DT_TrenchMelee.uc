//=============================================================================
// DTCoachMelee.
//
// You got beat down by the coach gun biznitch.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_TrenchMelee extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k pummeled %o with %kh trench gun stock."
     DeathStrings(1)="%o was beat down by %k's trench gun."
     DeathStrings(2)="%k's trench gun cracked a couple of %o's ribs."
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
	 BlockFatiguePenalty=0.25
     AimDisplacementDamageThreshold=60
     AimDisplacementDuration=1
     WeaponClass=Class'BWBP_OP_Pro.TrenchGun'
     DeathString="%k pummeled %o with %kh trench gun stock."
     FemaleSuicide="%o bashed herself with the trench gun."
     MaleSuicide="%o headbutted his trench gun."
     bExtraMomentumZ=True
}