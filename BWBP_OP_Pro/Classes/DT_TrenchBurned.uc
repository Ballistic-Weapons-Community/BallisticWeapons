//=============================================================================
// DTRX22ABurned.
//
// Damage type for RX22A primary fire spray
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_TrenchBurned extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%o had their fat rendered to a crisp after being shot by %k’s white hot phosphorus."
     DeathStrings(1)="%k won the fire making challenge after using %o’s corpse as a heat source."
     DeathStrings(2)="%o reached maximum thermal capacity after taking about 2 shells from %k."
     DeathStrings(3)="%k burned the skin on their dish, a roast %o with a blood sauce reduction."
     DeathStrings(4)="%o was cremated in 30 seconds or less after being lit up by %k’s dragon’s breath."
     DeathStrings(5)="%k flambeed %o with a dragon’s breath shell, too bad they forgot the marshmallows."
     InvasionDamageScaling=1.500000
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBP_OP_Pro.TrenchGun'
     DeathString="%%o reached maximum thermal capacity after taking about 2 shells from %k."
     FemaleSuicide="%o miscalculated the theoretical thermal capacity of her body."
     MaleSuicide="%o miscalculated the theoretical thermal capacity of his body."
     bDelayedDamage=True
     KDamageImpulse=2000.000000
}
