//=============================================================================
// DTA73bStab.
//
// Damagetype for the A73b bayonette attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MRDR88Spike extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%o got shanked real good by %k's MR-DR88."
     DeathStrings(1)="%o lost a fist fight to %k's spiked knuckle."
     DeathStrings(2)="%k punched a couple holes into %o."
     DeathStrings(3)="%k got medieval on %o's ass."
     DamageIdent="Melee"
     DamageDescription=",Stab,"
     WeaponClass=Class'BWBPRecolorsPro.MRDRMachinePistol'
     DeathString="%o got shanked real good by %k's MR-DR88."
     FemaleSuicide="%o happily stabbed herself to death."
     MaleSuicide="%o happily stabbed himself to death."
     bArmorStops=False
     bNeverSevers=True
     PawnDamageSounds(0)=Sound'BallisticSounds2.A73.A73StabFlesh'
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.500000
}
