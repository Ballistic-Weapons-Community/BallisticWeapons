//=============================================================================
// DTRX22ABurned.
//
// Damage type for RX22A primary fire spray
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTTrenchBurned extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%k sprayed %o with fire."
     DeathStrings(1)="%k's Trench Gun seared the flesh off %o."
     DeathStrings(2)="%o was torched to a crisp by %k's flamethrower."
     DeathStrings(3)="%o got cooked alive by %k's Trench Gun."
     DeathStrings(4)="%k poured fire all over %o's screaming figure."
     InvasionDamageScaling=1.500000
     DamageIdent="Machinegun"
     WeaponClass=Class'BWBP_OP_Pro.TrenchGun'
     DeathString="%k sprayed %o with fire."
     FemaleSuicide="%o pitbull burned his owner to the bone."
     MaleSuicide="%o mistreated his Pitbull and burned himself to death."
     bDelayedDamage=True
     KDamageImpulse=2000.000000
}
