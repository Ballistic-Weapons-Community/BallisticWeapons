//=============================================================================
// DT_LonghornBigRadius.
//
// Damage type for the explosions caused by the Longhorn Primary
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_LonghornBigRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o messed with %k's Longhorn and got fragged."
     DeathStrings(1)="%k's Longhorn reduced %o to chile con carne."
     DeathStrings(2)="%k's Longhorn blasted %o into beef jerky."
     SimpleKillString="Longhorn Grenade"
     bIgnoredOnLifts=True
     InvasionDamageScaling=2.000000
     DamageIdent="Ordnance"
     AimDisplacementDamageThreshold=120
     AimDisplacementDuration=0.75
     WeaponClass=Class'BWBP_SKC_Pro.LonghornLauncher'
     DeathString="%o messed with %k's Longhorn and got fragged."
     FemaleSuicide="%o got bucked by her own Longhorn."
     MaleSuicide="%o got bucked by his own Longhorn."
     bDelayedDamage=True
     bExtraMomentumZ=True
}
