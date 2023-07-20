//=============================================================================
// DTRX22AImmolation.
//
// Damage type for players caught alight by the RX22A Flamer
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTFM13Immolation extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%o's bitter, burned corpse made %k's Pitbull very sick."
     DeathStrings(1)="%k's Pitbull feasted on %o's cooked remains for dinner."
     DeathStrings(2)="%o had %vh body covered with burns thanks to %k's FM13."
     DeathStrings(3)="%k coated %o with flaming gas for %kh Pitbull to burn off."
     InvasionDamageScaling=1.500000
     DamageIdent="Machinegun"
     WeaponClass=Class'BWBP_APC_Pro.FM13Shotgun'
     DeathString="%o was immolated %k."
     FemaleSuicide="%o immolated herself."
     MaleSuicide="%o immolated himself."
     bSkeletize=True
     bDelayedDamage=True
     GibPerterbation=0.100000
     KDamageImpulse=200.000000
}
