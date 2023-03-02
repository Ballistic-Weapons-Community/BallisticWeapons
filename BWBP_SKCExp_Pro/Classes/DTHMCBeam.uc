//=============================================================================
// DTHMCBeam.
//
// Damagetype for lasering with the HMC.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTHMCBeam extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o was sliced up by %k's sweeping HMC laser."
     DeathStrings(1)="%k field tested %kh HMC laser on %o."
     DeathStrings(2)="%o tested %k's new laser prototype."
     DeathStrings(3)="%k gave %o a fairly lethal shock with %kh HMC laser."
     BloodManagerName="BWBP_SKCExp_Pro.BloodMan_HMCLaser"
     ShieldDamage=3
     bIgniteFires=True
     bPowerPush=True
     DamageIdent="Energy"
     WeaponClass=Class'BWBP_SKCExp_Pro.HMCBeamCannon'
     DeathString="%o was sliced up by %k's sweeping HMC laser."
     FemaleSuicide="%o tripped and thrashed through her own death-beam."
     MaleSuicide="%o tripped and thrashed through his own death-beam."
     bInstantHit=True
     GibModifier=4.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=2.000000
}
