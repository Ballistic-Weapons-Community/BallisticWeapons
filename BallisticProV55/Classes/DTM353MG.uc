//=============================================================================
// DTM353MG.
//
// Damage type for the M353 Machinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM353MG extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was torn to shreds by %k's M353."
     DeathStrings(1)="%o was blasted into ribbons by %k's M353."
     DeathStrings(2)="%o was machinegunned in half by %k's M353."
     HipString="HIP SPAM"
     DamageIdent="Machinegun"
     WeaponClass=Class'BallisticProV55.M353Machinegun'
     DeathString="%o was torn to shreds by %k's M353."
     FemaleSuicide="%o shot herself in the foot with the M353."
     MaleSuicide="%o shot himself in the foot with the M353."
     bFastInstantHit=True
}
