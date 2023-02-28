class SRXSecondaryFire extends BallisticFire;

simulated event ModeDoFire()
{
	if (!Instigator.IsLocallyControlled())
          return;
     if (AllowFire())
		SRXRifle(Weapon).ToggleAmplifier();
}

defaultproperties
{
     bUseWeaponMag=False
     bAISilent=True
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.200000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_SRXBullets'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
