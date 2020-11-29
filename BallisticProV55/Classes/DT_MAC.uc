//=============================================================================
// DT_MAC.
//
// DamageType for the HAMR Cannon
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MAC extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o was completely obliterated by %k's HAMR cannon."
     DeathStrings(1)="%k used a HAMR cannon to reduce %o to a fine paste."
     DeathStrings(2)="%o accidentally swallowed %k's incoming HAMR shell."
     DeathStrings(3)="%k launched a HAMR round straight into %o's ear."
     InvasionDamageScaling=2.000000
     DamageIdent="Ordnance"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=150
     WeaponClass=Class'BallisticProV55.MACWeapon'
     DeathString="%o was completely obliterated by %k's HAMR cannon."
     FemaleSuicide="%o totally eradicated herself with her HAMR."
     MaleSuicide="%o totally eradicated himself with his HAMR."
     bDelayedDamage=True
     bExtraMomentumZ=True
     VehicleDamageScaling=1.500000
}
