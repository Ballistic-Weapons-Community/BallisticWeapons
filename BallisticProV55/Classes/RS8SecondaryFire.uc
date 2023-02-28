//=============================================================================
// RS8SecondaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RS8SecondaryFire extends BallisticFire;

event ModeDoFire()
{
	if (Weapon.Role == ROLE_Authority)
		RS8Pistol(Weapon).ServerSwitchlaser(!RS8Pistol(Weapon).bLaserOn);
}

defaultproperties
{
     bUseWeaponMag=False
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.700000
     AmmoClass=Class'BallisticProV55.Ammo_RS8Bullets'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
