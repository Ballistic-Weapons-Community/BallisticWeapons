//=============================================================================
// XMB500secondaryFire.
//
// Activates laser sight for minigun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XMV500SecondaryFire extends BallisticFire;

event ModeDoFire()
{
	if (Weapon.Role == ROLE_Authority)
		XMV500Minigun(Weapon).ServerSwitchlaser(!XMV500Minigun(Weapon).bLaserOn);
}

defaultproperties
{
     bUseWeaponMag=False
     bWaitForRelease=True
     bModeExclusive=False
     FireEndAnim=
     FireRate=0.200000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_MinigunInc'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
