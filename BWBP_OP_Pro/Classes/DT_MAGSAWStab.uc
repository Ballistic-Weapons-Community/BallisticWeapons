//=============================================================================
// DT_RSDarkStab.
//
// Damagetype for the DarkStar saw attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MAGSAWStab extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%o was sawed in half by %k's chainsaw longsword."
     DeathStrings(1)="%k's MAG-SAW ripped %o open."
     DeathStrings(2)="%o was dismembered by %k's chainsaw-assisted slashes."
     BloodManagerName="BWBP_OP_Pro.BloodMan_MAGSAW"
     DamageIdent="Melee"
     DamageDescription=",Slash,Hack,"
     WeaponClass=Class'BWBP_OP_Pro.MAG78Longsword'
     DeathString="%o was sawed in half by %k's chainsaw longsword."
     FemaleSuicide="%o somehow managed to end herself with her MAG-SAW."
     MaleSuicide="%o somehow managed to end himself with his MAG-SAW."
     bAlwaysSevers=True
	 BlockFatiguePenalty=0.25
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.DarkStar.Dark-Flesh'
     KDamageImpulse=2000.000000
     TransientSoundVolume=0.900000
	 GibModifier=2
	 EffectChance=1.00
}
