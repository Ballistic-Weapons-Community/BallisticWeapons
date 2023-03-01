//=============================================================================
// BOGPSecondaryFire.
//
// A grenade that bonces off walls and detonates a certain time after impact
// Good for scaring enemies out of dark corners and not much else
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class BOGPSecondaryFire extends BallisticFire;

simulated function bool AllowFire()
{
	if (BOGPPistol(BW).IsSlave())
		return false;
		
	return Super.AllowFire();
}

event ModeDoFire()
{
	if (Weapon.Role == ROLE_Authority)
		BOGPPistol(Weapon).ServerSwitchWeaponMode(255);
}

defaultproperties
{
     bUseWeaponMag=False
     bWaitForRelease=True
     AmmoClass=Class'BallisticProV55.Ammo_BOGPGrenades'
     BotRefireRate=0.300000
}
