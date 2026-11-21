//=============================================================================
// DT_RSDarkStabHead.
//
// Damagetype for the Dark Star saw attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MAGSAWStabHead extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k ripped and tore %kh chainsword into %o's screaming face."
     DeathStrings(1)="%o's head was massacred by %k's chainsword."
     DeathStrings(2)="%o's face was mulched by %k's chainsword."
     BloodManagerName="BWBP_OP_Pro.BloodMan_MAGSAW"
     bHeaddie=True
     DamageIdent="Melee"
     DamageDescription=",Slash,Hack,"
     WeaponClass=Class'BWBP_OP_Pro.MAG78Longsword'
     DeathString=""%k ripped and tore %kh chainsword into %o's screaming face."
     FemaleSuicide="%o sawed her head off with a Dark Star."
     MaleSuicide="%o sawed his head off with a Dark Star."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.DarkStar.Dark-Flesh'
     KDamageImpulse=2000.000000
     TransientSoundVolume=0.900000
	 GibModifier=2.000000
	 GibPerterbation=1.200000
}
