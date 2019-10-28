//=============================================================================
// DTMRS138ShotgunHead.
//
// Damage type for headshots with the MRS138 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMRS138ShotgunHead extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k tore off %o's head with a tenner from %kh shotgun."
     DeathStrings(1)="%k's MRS-138 went off in %o's face."
     DeathStrings(2)="%o got %vh head ventilated by %k's MRS-138."
     bHeaddie=True
     InvasionDamageScaling=1.500000
     DamageIdent="Shotgun"
     WeaponClass=Class'BallisticProV55.MRS138Shotgun'
     DeathString="%k tore off %o's head with a tenner from %kh shotgun."
     FemaleSuicide="%o put a tenner in her own head with the MRS-138."
     MaleSuicide="%o put a tenner in his own head with the MRS-138."
     bAlwaysSevers=True
     bSpecial=True
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=10000.000000
}
