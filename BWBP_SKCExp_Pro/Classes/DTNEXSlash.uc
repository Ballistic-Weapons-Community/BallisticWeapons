//=============================================================================
// DTHMCBeam.
//
// Damagetype for lasering with the AHEM! stabbing people with glowy swords
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTNEXSlash extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k's NEX left glowing lacerations on %o's chest."
     DeathStrings(1)="%k rammed a glowing sword up %o's formerly sunshine-free place."
     DeathStrings(2)="%k disemboweled %o and cauterized the guts."
     DeathStrings(3)="%o was stabbed in the spine by %k's glowing blade."
     DeathStrings(4)="%o was carved right down the middle by %k the swordmaster."
     BloodManagerName="BWBP_SKC_Pro.BloodMan_HMCLaser"
     ShieldDamage=3
     bIgniteFires=True
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=3.000000
     DamageDescription=",Plasma,Slash,"
     WeaponClass=Class'BWBP_SKCExp_Pro.N3XPlaz'
     DeathString="%o's chest now has glowing lacerations by %k."
     FemaleSuicide="%o tripped and died a flamey, burney death."
     MaleSuicide="%o tripped and died a flamey, burney death."
     bArmorStops=False
     GibModifier=4.000000
     PawnDamageSounds(0)=SoundGroup'BWBP_SKC_SoundsExp.NEX.Nex-HitBod'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.150000
}
