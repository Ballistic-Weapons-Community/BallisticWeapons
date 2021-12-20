//=============================================================================
// DTM50Grenade.
//
// Damage type for the M900 grenade fired from the M50
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTZ250Grenade extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o was tagged by %k's M900 Gas grenade."
     DeathStrings(1)="%o played with %k's live M900 Gas grenade."
     SimpleKillString="Z250 Grenade"
     InvasionDamageScaling=2.000000
     DamageIdent="Grenade"
     WeaponClass=Class'BWBP_OP_Pro.Z250Minigun'
     DeathString="%o was tagged by %k's M900 Gas grenade."
     FemaleSuicide="%o tagged herself with her own grenade."
     MaleSuicide="%o tagged himself with his own grenade."
     bDelayedDamage=True
}
