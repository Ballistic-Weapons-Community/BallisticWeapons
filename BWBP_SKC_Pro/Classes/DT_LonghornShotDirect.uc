//=============================================================================
// DT_LonghornShotDirect.
//
// Damage type for the secondary balls fired by the longhorn - Direct Impact
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_LonghornShotDirect extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k's Longhorn chose the direct approach for %o."
     DeathStrings(1)="%k peppered %o with explosive Longhorn shot."
     DeathStrings(2)="%k knocked %o into next week with %kh Longhorn."
     SimpleKillString="Longhorn Cluster Shot Impact"
     InvasionDamageScaling=2.000000
     DamageIdent="Ordnance"
     WeaponClass=Class'BWBP_SKC_Pro.LonghornLauncher'
     DeathString="%k's Longhorn chose the direct approach for %o."
     FemaleSuicide="%o had the great idea to spit flak at her feet."
     MaleSuicide="%o had the great idea to spit flak at his feet."
     bDelayedDamage=True
}
