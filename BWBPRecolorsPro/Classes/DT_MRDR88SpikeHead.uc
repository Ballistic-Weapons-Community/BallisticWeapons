//=============================================================================
// DTElephants.
//
// Hello Azarael/Kaboodles/Bjossi/Xav/???!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MRDR88SpikeHead extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k rammed %kh spiky MR-DR88 into %o's head."
     DeathStrings(1)="%o faceplanted into %k's MR-DR88 spiky handle."
     DeathStrings(2)="%k poked %o's beady little eyes out with an MR-DR88."
     DeathStrings(3)="%k has a little bit of %o face on his MR-DR88."
     bHeaddie=True
     DamageIdent="Melee"
     DamageDescription=",Stab,"
     WeaponClass=Class'BWBPRecolorsPro.MRDRMachinePistol'
     DeathString="%k rammed %kh spiky MR-DR88 into %o's head."
     FemaleSuicide="%o  picked her nose with a 3 inch spike."
     MaleSuicide="%o picked his nose with a 3 inch spike."
     bArmorStops=False
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=Sound'BallisticSounds2.A73.A73StabFlesh'
     KDamageImpulse=2000.000000
}
