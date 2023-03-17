//=============================================================================
// DTM50Grenade.
//
// Damage type for the M900 grenade fired from the M50
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMJ51HEGrenade extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o was tagged by %k's rifle grenade."
     DeathStrings(1)="%o played with %k's live rifle grenade."
     SimpleKillString="MJ51 HE Grenade"
     InvasionDamageScaling=2.000000
     DamageIdent="Grenade"
     WeaponClass=Class'BWBP_SKC_Pro.MJ51Carbine'
     DeathString="%o was tagged by %k's rifle grenade."
     FemaleSuicide="%o tagged herself with her own grenade."
     MaleSuicide="%o tagged himself with his own grenade."
     bDelayedDamage=True
}
