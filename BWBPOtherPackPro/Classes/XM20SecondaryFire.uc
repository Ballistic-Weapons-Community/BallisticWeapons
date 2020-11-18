//=============================================================================
// CYLOSecondaryFire.
//
// A semi-auto shotgun that uses its own magazine.
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XM20SecondaryFire extends BallisticFire;

simulated function bool AllowFire()
{
    return (!XM20AutoLas(BW).bBroken && Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire && !BW.bServerReloading && BW.MeleeState == MS_None);
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

		if (BW.ReloadState != RS_None)
		{
			if (weapon.Role == ROLE_Authority)
				BW.bServerReloading=false;
			BW.ReloadState = RS_None;
		}
	}
	
	XM20AutoLas(Weapon).ShieldDeploy();
	
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
     FireAnim="Cock"
     FireRate=1.000000
	 FireAnimRate=1.00
     AmmoClass=Class'BWBPOtherPackPro.Ammo_XM20Laser'
     AmmoPerFire=0
}
