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
     EffectString="Attach AMP"
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.200000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_SRXBullets'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
