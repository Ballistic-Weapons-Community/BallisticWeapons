class XK2SecondaryFire extends BallisticFire;

simulated event ModeDoFire()
{
	if (!Instigator.IsLocallyControlled())
          return;
     if (AllowFire())
		XK2SubMachineGun(Weapon).ToggleAmplifier();
}

defaultproperties
{
     bUseWeaponMag=False
     bAISilent=True
     EffectString="Attach AMP"
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.200000
     AmmoClass=Class'BallisticProV55.Ammo_9mm'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
