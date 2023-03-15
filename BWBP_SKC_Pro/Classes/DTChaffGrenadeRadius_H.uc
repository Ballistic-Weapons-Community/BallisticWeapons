//=============================================================================
// DTChaffGrenadeRadius_H.
//
// Damage type for getting caught 
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTChaffGrenadeRadius_H extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o couldn't run fast enough from suicidal %k."
     DeathStrings(1)="%k cracked %kh smoke grenade on a wall and amazingly killed %o."
     DeathStrings(2)="%k took %o out with an attempted self destruct."
     WeaponClass=Class'BWBP_SKC_Pro.ChaffGrenadeWeapon'
     DeathString="%o unexpectedly died to %k's MOA-C chaff grenade."
     FemaleSuicide="%o beat the walls with a live grenade like a lunatic."
     MaleSuicide="%o beat the walls with a live grenade like a lunatic."
     bDelayedDamage=True
     VehicleDamageScaling=0.100000
}
