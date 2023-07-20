//=============================================================================
// DTXK2SMG.
//
// Damage type for the XK2 SMG
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMDKSMG extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k found the right setup to take down %o without swapping weapons."
     DeathStrings(1)="%o was a victim of %k's modularity, taking silent bullets without ever realizing."
     DeathStrings(2)="%k murdered %o to death, killing them with ease."
	 DeathStrings(3)="%o got slain from %k's 9mm bullet from a distance quietly."
     EffectChance=0.500000
     InvasionDamageScaling=1.500000
     DamageIdent="SMG"
     WeaponClass=Class'BWBP_SWC_Pro.MDKSubMachinegun'
     DeathString="%o was put out by %k's MDK."
     FemaleSuicide="%o silenced herself."
     MaleSuicide="%o silenced himself."
     bFastInstantHit=True
     VehicleDamageScaling=0.150000
}
