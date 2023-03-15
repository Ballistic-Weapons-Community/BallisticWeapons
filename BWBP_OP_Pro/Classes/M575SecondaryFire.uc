//=============================================================================
// M575SecondaryFire.
//
// by SK
// Copyright(c) 2023 SK
//=============================================================================
class M575SecondaryFire extends BallisticFire;

simulated event ModeDoFire()
{
	if (!Instigator.IsLocallyControlled())
		return;
	if (AllowFire())
		M575Machinegun(Weapon).ToggleAmplifier();
}

defaultproperties
{
     bUseWeaponMag=False
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.700000
     AmmoClass=Class'BWBP_OP_Pro.Ammo_762mmBelt'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
