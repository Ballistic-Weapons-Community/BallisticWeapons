//=============================================================================
// DT_MAC.
//
// DamageType for the HAMR Cannon
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MACSelf extends DT_BWBlunt;

defaultproperties
{
     SimpleKillString="HAMR Self-Damage"
     DamageIdent="Ordnance"
     DisplacementType=DSP_Linear
     WeaponClass=Class'BallisticProV55.MACWeapon'
     DeathString="Damagetype bug - HAMR self damage killed another player."
     FemaleSuicide="%o's HAMR knocked her shoulder out."
     MaleSuicide="%o's HAMR knocked his shoulder out."
     bDelayedDamage=True
     VehicleDamageScaling=1.000000
     VehicleMomentumScaling=1.000000
}
