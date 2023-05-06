//=============================================================================
// DT_MRDR88Body.
//
// Damage type for the MR-DR SMG
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MRDR88Body extends DT_BWBullet;

defaultproperties
{
	DeathStrings(0)="%k took %o out with a fusillade of MR-DR88 bullets."
	DeathStrings(1)="%o went down under a barrage of %k's MR-DR88 slugs."
	DeathStrings(2)="%k's MR-DR88 showered %o with lead."
	DeathStrings(3)="%o was ripped apart by %k's spraying MR-DR88."
	EffectChance=0.500000
	DamageIdent="SMG"
	WeaponClass=Class'BWBP_SKC_Pro.MRDRMachinePistol'
	DeathString="%k took %o out with a fusillade of MR-DR88 bullets."
	FemaleSuicide="%o shot herself with an MR-DR88?"
	MaleSuicide="%o shot himself with an MR-DR88!"
	bFastInstantHit=True
	VehicleDamageScaling=0.100000

	TagMultiplier=0.7
	TagDuration=0.1
}
