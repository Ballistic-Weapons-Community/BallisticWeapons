//=============================================================================
// RS8SecondaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SX45SecondaryFire extends BallisticFire;

simulated event ModeDoFire()
{
	if (!Instigator.IsLocallyControlled())
		return;
	if (AllowFire())
		SX45Pistol(Weapon).ToggleAmplifier();
}

defaultproperties
{
     bUseWeaponMag=False
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.700000
     AmmoClass=Class'BallisticProV55.Ammo_45HV'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
