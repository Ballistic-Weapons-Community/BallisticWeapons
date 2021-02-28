//=============================================================================
// DT_M2020Off.
//
// DamageType for the M2020 gauss offline or deflecting shot
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2003 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_M2020Off extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k sent a superaccelerated M2020 gauss round through %o."
     DeathStrings(1)="%o was polarized by %k's heavy gauss rifle."
     DeathStrings(2)="%k hunted down %o with %kh advanced gauss gun."
     DeathStrings(3)="%o experienced the power of %k's magnetic accelerator first hand."
     DamageIdent="Sniper"
     ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
     WeaponClass=Class'BWBP_SKC_Pro.M2020GaussDMR'
     DeathString="%k sent a superaccelerated M2020 gauss round through %o."
     FemaleSuicide="%o polarized herself."
     MaleSuicide="%o polarized himself."
}
