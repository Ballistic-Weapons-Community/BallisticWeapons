//=============================================================================
// DT_MP40Chest.
//
// DamageType for the FMP-2012
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MP40_Incendiary extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k's old school SMG is like a new school Flammenwerfer to %o, still burns all the same."
     DeathStrings(1)="%o screamed and screamed until %k silenced %vm, all quiet on the modern front."
     DeathStrings(2)="%k cleansed more than just sins from %o with the FMP-2012."
     DeathStrings(3)="%o died in glorious combat, reduced to ash by %k."
     DeathStrings(4)="%k silenced the swan song coming from %o with some fiery bullets."
	 bIgniteFires=True
	 EffectChance=1.000000
     WeaponClass=Class'BWBP_SKC_Pro.FMPMachinePistol'
     DeathString="%k embraced Schadenfreude as %kh FMP destroyed %o."
     FemaleSuicide="%o did her fuhrer impression."
     MaleSuicide="%o did his fuhrer impression."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.650000
}
