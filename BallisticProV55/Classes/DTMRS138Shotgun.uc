//=============================================================================
// DTMRS138Shotgun.
//
// Damage type for MRS138 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMRS138Shotgun extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k fired a tenner into %o with the MRS-138."
     DeathStrings(1)="%o absorbed the random shots of %k's combat shotgun."
     DeathStrings(2)="%k blasted %o down as %ve tried to scamper away in fear."
     DeathStrings(3)="%o was disassembled by %k's MRS-138 barrage."
     InvasionDamageScaling=1.500000
     DamageIdent="Shotgun"
     WeaponClass=Class'BallisticProV55.MRS138Shotgun'
     DeathString="%k fired a tenner into %o with the MRS-138."
     FemaleSuicide="%o fired a tenner into herself with the MRS-138."
     MaleSuicide="%o fired a tenner into himself with the MRS-138."
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=25000.000000
}
