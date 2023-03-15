//=============================================================================
// DTLS14Body
//
// DT for Laser Carbine limb shots.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTNEXSlashLimb extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%o is now legless due to %k and the Plas-Edge."
     DeathStrings(1)="%k melted %o's arms off with a sword."
     DeathStrings(2)="%k's burning blade sliced an arm off %o."
     BloodManagerName="BWBP_SKC_Pro.BloodMan_HMCLaser"
     ShieldDamage=3
     bIgniteFires=True
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=2.000000
     WeaponClass=Class'BWBP_SKC_Pro.N3XPlaz'
     DeathString="%o is now legless due to %k and the Plas-Edge."
     FemaleSuicide="%o is not very good with fiery swords."
     MaleSuicide="%o is not very good with fiery swords."
     bArmorStops=False
     bAlwaysSevers=True
     GibModifier=1.500000
     PawnDamageSounds(0)=SoundGroup'BWBP_SKC_SoundsExp.NEX.Nex-HitBod'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=2.000000
}
