//=============================================================================
// GRSXXSecondaryAmpFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class GRSXXSecondaryAmpFire extends BallisticFire;

simulated event ModeDoFire()
{
	if (!Instigator.IsLocallyControlled())
		return;
	if (AllowFire())
		GRSXXPistol(Weapon).ToggleAmplifier();
}

defaultproperties
{
     bUseWeaponMag=False
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.700000
     AmmoClass=Class'BallisticProV55.Ammo_GRSNine'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
