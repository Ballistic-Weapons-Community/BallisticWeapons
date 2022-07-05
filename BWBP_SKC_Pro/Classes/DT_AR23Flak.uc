//=============================================================================
// DT_MD402Flak.
//
// Damagetype for the 40mm SHOTGUN
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AR23Flak extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k opened a 40mm canister of pain on %o's ass."
     DeathStrings(1)="%o was finely shredded into bite sized chunks by %k's canister."
     DeathStrings(2)="%k tried to flush %o out of their hidey-hole, only to be swiss cheesed by the shrapnel."
     DeathStrings(3)="%o couldn't escape getting eviscerated by %k, even if they were around a corner."
	 DeathStrings(4)="%k launched some contained devastation into %o's face."
	 DeathStrings(5)="%o got all the acupuncture thanks to %k and their trusty canister of pain."
	 SimpleKillString="AR23 Shotgun Fire"
     WeaponClass=Class'BWBP_SKC_Pro.AR23HeavyRifle'
     DeathString="%o received a 40mm serving of buckshot from %k's AR23"
     FemaleSuicide="%o made a severe tactical error."
     MaleSuicide="%o made a severe tactical error."
//   bAlwaysGibs=True
//   bLocationalHit=False
//   bAlwaysSevers=True
     PawnDamageSounds(0)=Sound'BWBP_SKC_Sounds.Berserk.Berserk-Squish'
     GibPerterbation=4.000000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.050000
     VehicleMomentumScaling=1.300000
}
