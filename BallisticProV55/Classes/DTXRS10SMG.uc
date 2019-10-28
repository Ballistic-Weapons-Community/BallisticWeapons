//=============================================================================
// DTXRS10SMG.
//
// Damage type for the XRS10 SMG
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTXRS10SMG extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was cleansed by a hail of %k's XRS-10 rounds."
     DeathStrings(1)="%o flapped around like a fish as %k filled %vm with XRS-10 rounds."
     DeathStrings(2)="%k directed a few XRS-10 rounds into %o's belly."
     DeathStrings(3)="%k's XRS-10 sorted %o out good and proper."
     EffectChance=0.500000
     InvasionDamageScaling=1.500000
     DamageIdent="SMG"
     WeaponClass=Class'BallisticProV55.XRS10SubMachinegun'
     DeathString="%o was cleansed by a hail of %k's XRS-10 rounds."
     FemaleSuicide="%o silenced herself."
     MaleSuicide="%o silenced himself."
     bFastInstantHit=True
     VehicleDamageScaling=0.150000
}
