//=============================================================================
// DT_LonghornArtilleryDirect.
//
// Damage type for the artillery balls fired by the longhorn - Direct Impact
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_LonghornArtilleryDirect extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k's random Longhorn shot landed on %o."
     DeathStrings(1)="%o was in the wrong place at the wrong time."
     InvasionDamageScaling=2.000000
     DamageIdent="Ordnance"
     WeaponClass=Class'BWBPRecolorsPro.LonghornLauncher'
     DeathString="%k's random Longhorn shot landed on %o."
     FemaleSuicide="%o caught her Longhorn bomb on the way down."
     MaleSuicide="%o caught his Longhorn bomb on the way down."
     bDelayedDamage=True
}
