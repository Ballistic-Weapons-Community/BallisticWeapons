class WrenchPrimaryFire extends BallisticFire;

simulated function bool AllowFire()
{
    return ( Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire && !BW.bServerReloading && BW.MeleeState == MS_None);
}

simulated function SwitchWeaponMode(byte newMode)
{
	AmmoPerFire = WrenchWarpDevice(Weapon).Deployables[newMode].AmmoReq;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetTimer(0.8, true);	// XAVEDIT
}

function Timer()
{
	if (Weapon.Role < ROLE_Authority)
		return;
	if ( !Weapon.AmmoMaxed(0) /*&& Weapon.CurrentWeapon == WrenchWarpDevice */)	// XAVEDIT
		Weapon.AddAmmo(1, 0);
}

// ModeDoFire from WeaponFire.uc, but with a few changes
simulated event ModeDoFire()
{
    if (!AllowFire())
        return;

	if (BW != None)
	{
		BW.bPreventReload=true;
		BW.FireCount++;

		/* What the hell is this?
		if (BW.ReloadState != RS_None)
		{
			if (weapon.Role == ROLE_Authority)
				BW.bServerReloading=false;
			BW.ReloadState = RS_None;
		}*/
	}

	ConsumedLoad += Load;
    // server
    if (Weapon.Role == ROLE_Authority)
    {
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
    }
	
	BW.LastFireTime = Level.TimeSeconds;

    // client
    if (Instigator.IsLocallyControlled())
        PlayFiring();
    else // server
        ServerPlayFiring();


	NextFireTime += FireRate;
	NextFireTime = FMax(NextFireTime, Level.TimeSeconds);

	
    Load = AmmoPerFire;

    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    {
        bIsFiring = false;
        Weapon.PutDown();
    }
}

defaultproperties
{
     bUseWeaponMag=False
     bWaitForRelease=True
     FireAnim="Button"
	 FireAnimRate=1.5
     FireRate=1.000000
     AmmoClass=Class'BWBPOtherPackPro.Ammo_Wrench'
     AmmoPerFire=10
}
