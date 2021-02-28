//=============================================================================
// DTG28CloudBomb.
//
// Damage type for G28 gas cloud explosion
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTG28CloudBomb extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%k brought %o's healing to a fiery end."
     DeathStrings(1)="%o's gas huffing was brought to an end by %k's fiery intervention."
     DeathStrings(2)="%k turned up the heat on %o's healing party."
     WeaponClass=Class'BWBPRecolorsPro.G28Grenade'
     DeathString="%k bombed %o with fire."
     FemaleSuicide="%o didn't read the flammable label on her G28."
     MaleSuicide="%o didn't read the flammable label on his G28."
     bDelayedDamage=True
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.800000
}
