//=============================================================================
// DTRX22AImmolation.
//
// Damage type for players caught alight by the RX22A Flamer
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTZ250Immolation extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%o fought valiantly, but %k's Z250 induced inferno consumed %vm all the same."
     DeathStrings(1)="%k deep fried %o in some Z250 fire, the flames overcooked %vm though."
     DeathStrings(2)="%o tried to crawl out of %k's kiddy pool of Z250 fire, no such luck."
     DeathStrings(3)="%k slow cooked %o over on an open fire."
     InvasionDamageScaling=1.500000
     SimpleKillString="Z250 Burn"
     DamageIdent="Machinegun"
     WeaponClass=Class'BWBP_OP_Pro.Z250Minigun'
     DeathString="%o was immolated %k."
     FemaleSuicide="%o avoided the 'don't swim in your own fire' sign."
     MaleSuicide="%o avoided the 'don't swim in your own fire' sign."
     bSkeletize=True
     bDelayedDamage=True
     GibPerterbation=0.100000
     KDamageImpulse=200.000000
}
