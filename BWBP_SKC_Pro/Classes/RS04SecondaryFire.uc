//=============================================================================
// Rs04SecondaryFire.
//
// Activates flashlight
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RS04SecondaryFire extends BallisticFire;

simulated event ModeDoFire()
{
    if (!Instigator.IsLocallyControlled())
    	return;
	if (AllowFire())
		RS04Pistol(Weapon).WeaponSpecial();
}

defaultproperties
{
     bUseWeaponMag=False
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.200000
     AmmoClass=Class'BallisticProV55.Ammo_45HV'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
