class M575SecondaryFire extends BallisticFire;

simulated event ModeDoFire()
{
    if (!Instigator.IsLocallyControlled())
    	return;
	M575MachineGun(Weapon).InitSwitchScope();
}

defaultproperties
{
	 ScopeDownOn=SDO_Fire
     bUseWeaponMag=False
     bAISilent=True
     EffectString="Swap Scope"
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=1.300000
     AmmoClass=Class'BallisticProV55.Ammo_556mmBelt'
     AmmoPerFire=0
     BotRefireRate=0.300000
}