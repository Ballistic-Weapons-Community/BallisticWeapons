class SRS600SecondaryFire extends BallisticFire;

simulated event ModeDoFire()
{
    if (!Instigator.IsLocallyControlled())
    	return;
	if (AllowFire())
		SRS600Rifle(Weapon).WeaponSpecial();
}

defaultproperties
{
     bUseWeaponMag=False
     bAISilent=True
     EffectString="Attach suppressor"
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.700000
     AmmoClass=Class'BallisticProV55.Ammo_RS762mm'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
