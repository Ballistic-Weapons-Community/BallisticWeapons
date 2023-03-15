//=============================================================================
// DTChaffGrenade_H.
//
// Damage type for meleeing with a live grenade...
// The epitome of tactical warfare.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTChaffGrenade_H extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o was bludgeoned with a live grenade by crazed %k."
     DeathStrings(1)="%k maniacally charged and beat %o with %kh live grenade."
     DeathStrings(2)="%k did %kh drunk demoman impression on %o with a live grenade."
     WeaponClass=Class'BWBP_SKC_Pro.ChaffGrenadeWeapon'
     DeathString="%o was bludgeoned with a live grenade by crazed %k."
     FemaleSuicide="%o beat the walls with a live grenade like a lunatic."
     MaleSuicide="%o beat the walls with a live grenade like a lunatic."
     bDelayedDamage=True
     VehicleDamageScaling=0.100000
}
