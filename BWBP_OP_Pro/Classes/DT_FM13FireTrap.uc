//=============================================================================
// DT_FM13FireTrap.
//
// Damage type for FM13 surface fires
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_FM13FireTrap extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%o tried to take %k's fire and got burned for it, literally."
     DeathStrings(1)="%k's Pitbull fueled %o's pyre fit for a viking end."
     DeathStrings(2)="%o got turned into ashes like the heretic %ve is due to %k's Pitbull."
     DeathStrings(3)="%k's Pitbull charred the outside and insides of %o to 500 degrees."
     BloodManagerName="BallisticProV55.BloodMan_FireExploded"
     bIgnoredOnLifts=True
     InvasionDamageScaling=1.500000
     DamageIdent="Machinegun"
     bOnlySeverLimbs=True
     WeaponClass=Class'BWBP_OP_Pro.FM13Shotgun'
     DeathString="%o swam in %k's fire."
     FemaleSuicide="%o ran into a fire."
     MaleSuicide="%o ran into a fire."
     bDelayedDamage=True
     KDamageImpulse=2000.000000
}
