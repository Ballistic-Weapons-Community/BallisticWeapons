class BX5SecondaryFire extends BallisticFire;

simulated event ModeDoFire()
{
    if (!Instigator.IsLocallyControlled())
    	return;
	if (AllowFire())
		BX5Mine(Weapon).SwitchSpringMode();
	NextFireTime += FireRate;
	NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
}

defaultproperties
{
     bUseWeaponMag=False
     bAISilent=True
     EffectString="Spring mode"
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.700000
     AmmoClass=Class'BallisticProV55.Ammo_BX5Mines'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
