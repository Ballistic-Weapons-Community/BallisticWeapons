//=============================================================================
// DTSPASShotgunHead.
//
// Damage type for SPAS head
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSPASShotgunHead extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%o got his face right up in %k's SPAS barrel."
     DeathStrings(1)="%k's SPAS-12 relocated %o's brain to a wall."
     DeathStrings(2)="%k had no choice but to discharge his SPAS into %o's face."
     bHeaddie=True
     WeaponClass=Class'BWBP_JCF_Pro.SPASShotgun'
     DeathString="%o got his face right up in %k's SPAS barrel."
     FemaleSuicide="%o nailed herself with the SPAS."
     MaleSuicide="%o nailed himself with the SPAS."
     bAlwaysSevers=True
     bSpecial=True
     GibPerterbation=0.400000
     KDamageImpulse=10000.000000
}
