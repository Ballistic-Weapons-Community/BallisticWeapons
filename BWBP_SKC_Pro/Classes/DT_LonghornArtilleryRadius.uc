//=============================================================================
// DT_LonghornArtilleryRadius.
//
// Damage type for the explosions caused by the Longhorn Artillery explosions
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_LonghornArtilleryRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k's Longhorn rained hell upon %o."
     DeathStrings(1)="%k rained explosive death on %o with a Longhorn."
     InvasionDamageScaling=2.000000
     DamageIdent="Ordnance"
     WeaponClass=Class'BWBP_SKC_Pro.LonghornLauncher'
     DeathString="%k's Longhorn rained hell upon %o."
     FemaleSuicide="%o realized if he shoots straight up, he should also move."
     MaleSuicide="%o realized if he shoots straight up, he should also move."
     bDelayedDamage=True
}
