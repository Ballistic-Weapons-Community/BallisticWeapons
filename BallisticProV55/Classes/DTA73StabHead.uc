//=============================================================================
// DTA73StabHead.
//
// Damagetype for the A73 bayonette attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA73StabHead extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k rammed the blades of the A73 into %o's head."
     DeathStrings(1)="%o was jabbed in the jaw by %k's A73."
     DeathStrings(2)="%o tried to chew on %k's A73."
     bHeaddie=True
     DamageIdent="Melee"
     AimDisplacementDamageThreshold=75
     DamageDescription=",Stab,"
     WeaponClass=Class'BallisticProV55.A73SkrithRifle'
     DeathString="%k rammed the blades of the A73 into %o's head."
     FemaleSuicide="%o sliced her own head in half with the A73."
     MaleSuicide="%o sliced his own head in half with the A73."
     bAlwaysSevers=True
     bSpecial=True
	 BlockFatiguePenalty=0.25
     PawnDamageSounds(0)=Sound'BallisticSounds2.A73.A73StabFlesh'
     KDamageImpulse=2000.000000
}
