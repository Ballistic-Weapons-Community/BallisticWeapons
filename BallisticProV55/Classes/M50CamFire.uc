//=============================================================================
// M50CamFire.
//
// Does cam stuff for M50
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M50CamFire extends BallisticFire;

event ModeDoFire()
{
	if (Instigator.IsLocallyControlled())
		M50AssaultRifle(Weapon).WeaponSpecial();
}

defaultproperties
{
     bUseWeaponMag=False
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.700000
     AmmoClass=Class'BallisticProV55.Ammo_556mm'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
