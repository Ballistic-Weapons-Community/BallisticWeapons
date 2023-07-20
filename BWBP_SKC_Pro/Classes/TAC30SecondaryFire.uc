//=============================================================================
// TAC30SecondaryFire.
//
// Activates laser sight for the cannon
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TAC30SecondaryFire extends BallisticFire;

event ModeDoFire()
{
	if (Weapon.Role == ROLE_Authority)
		TAC30Cannon(Weapon).ServerSwitchlaser(!TAC30Cannon(Weapon).bLaserOn);
}

defaultproperties
{
     bUseWeaponMag=False
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.200000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_20mmGrenade'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
