//=============================================================================
// DTAY90SkrithRadiusSuper.
//
// Damage type for the boltcaster hyperblast
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTAY90SkrithRadiusSuper extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k's fully charged AY90 boltcaster obliterated %o."
     DeathStrings(1)="%o was reduced to atoms by %k's charged AY90 boltcaster."
     DeathStrings(2)="%k let loose the full force of %kh AY90 Wyvern on %o."
     SimpleKillString="AY90 BFG Radius"
	 BloodManagerName="BallisticProV55.BloodMan_A73Burn"
     bIgniteFires=True
     DamageDescription=",Flame,Plasma,"
     WeaponClass=Class'BWBP_SKC_Pro.AY90SkrithBoltcaster'
     DeathString="%k's fully charged boltcaster obliterated %o."
     FemaleSuicide="%o took flight with a fully charged Wyvern."
     MaleSuicide="%o took flight with a fully charged Wyvern."
     GibModifier=3.000000
     GibPerterbation=0.600000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.900000
     bDelayedDamage=True
}
