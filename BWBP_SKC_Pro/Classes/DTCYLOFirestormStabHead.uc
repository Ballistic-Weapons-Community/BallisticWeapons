//=============================================================================
// DTA73StabHead.
//
// Damagetype for the A73 bayonette attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTCYLOFirestormStabHead extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%o lost an eye to %k's CYLO blade."
     DeathStrings(1)="%k lobotomized %o with %kh CYLO blade."
     DeathStrings(2)="%k's CYLO amputated %o's head."
     bHeaddie=True
     DamageIdent="Melee"
     DamageDescription=",Stab,"
     WeaponClass=Class'BWBP_SKC_Pro.CYLOUAW'
     DeathString="%o was was mauled by %k's CYLO."
     FemaleSuicide="%o sliced her own head in half with the CYLO."
     MaleSuicide="%o sliced his own head in half with the CYLO."
     bAlwaysSevers=True
     bSpecial=True
	 BlockFatiguePenalty=0.25
     PawnDamageSounds(0)=Sound'BW_Core_WeaponSound.A73.A73StabFlesh'
     KDamageImpulse=2000.000000
}
