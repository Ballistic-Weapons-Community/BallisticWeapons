//=============================================================================
// DT_AR23HR.
//
// Damage type for the M925 Machinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AR23HR extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k made a holy man of %o with M925 rounds."
     DeathStrings(1)="%k blessed %o with M925 rounds."
     DeathStrings(2)="%k blasted %o into a corner with %kh M925."
     DeathStrings(3)="%k's M925 judged %o unworthy."
     DeathStrings(4)="%o was crucified by %k's .50 machinegun."
     DamageIdent="Heavy Rifle"
     WeaponClass=Class'BWBP_SKC_Pro.AR23HeavyRifle'
     DeathString="%k made a holy man of %o with M925 rounds."
     FemaleSuicide="%o caught her face in the belt feed of her M925."
     MaleSuicide="%o caught his face in the belt feed of his M925."
     bFastInstantHit=True
}
