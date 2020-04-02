//=============================================================================
// XRS10SecondaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class XRS10SecondaryFire extends BallisticFire;

event ModeDoFire()
{
	if (Weapon.Role == ROLE_Authority)
		XRS10SubMachinegun(Weapon).ServerSwitchLaser(!XRS10SubMachinegun(Weapon).bLaserOn);
//	if (!Instigator.IsLocallyControlled())
//		return;
//	if (AllowFire())
//		XRS10SubMachinegun(Weapon).WeaponSpecial();
}

defaultproperties
{
     bUseWeaponMag=False
     EffectString="Laser sight"
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.700000
     AmmoClass=Class'BallisticProV55.Ammo_XRS10Bullets'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
