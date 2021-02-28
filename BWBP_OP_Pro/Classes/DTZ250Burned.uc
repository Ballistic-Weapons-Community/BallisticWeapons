//=============================================================================
// DTRX22ABurned.
//
// Damage type for RX22A primary fire spray
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTZ250Burned extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%k sprayed %o with fire."
     DeathStrings(1)="%k's RX-22A seared the flesh off %o."
     DeathStrings(2)="%o was torched to a crisp by %k's flamethrower."
     DeathStrings(3)="%o got cooked alive by %k's RX-22A."
     DeathStrings(4)="%k poured fire all over %o's screaming figure."
     InvasionDamageScaling=1.500000
     DamageIdent="Machinegun"
     WeaponClass=Class'BWBP_OP_Pro.Z250Minigun'
     DeathString="%k sprayed %o with fire."
     FemaleSuicide="%o burned herself."
     MaleSuicide="%o burned himself."
     bDelayedDamage=True
     KDamageImpulse=2000.000000
}
