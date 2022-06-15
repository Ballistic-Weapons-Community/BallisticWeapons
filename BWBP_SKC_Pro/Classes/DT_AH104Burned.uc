//=============================================================================
// DTRX22ABurned.
//
// Damage type for ah104 flame belchin'
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AH104Burned extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%k sprayed %o with hellfire."
     DeathStrings(1)="%k's AH104 seared the flesh off %o."
     DeathStrings(2)="%o was torched to a crisp by %k's pistol flamer."
     DeathStrings(3)="%o got cooked alive by %k's AH104."
     DeathStrings(4)="%k poured fire all over %o's screaming figure."
     SimpleKillString="AH104 Flamethrower"
     DamageIdent="Assault"
     WeaponClass=Class'BWBP_SKC_Pro.AH104Pistol'
     DeathString="%k sprayed %o with fire."
     FemaleSuicide="%o burned herself."
     MaleSuicide="%o burned himself."
     bDelayedDamage=True
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.350000
}
