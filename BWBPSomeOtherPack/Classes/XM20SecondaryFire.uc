//=============================================================================
// CYLOSecondaryFire.
//
// A semi-auto shotgun that uses its own magazine.
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XM20SecondaryFire extends BallisticFire;

simulated event ModeDoFire()
{
    if (MaxHoldTime > 0.0)
        HoldTime = FMin(HoldTime, MaxHoldTime);

    if (!Instigator.IsLocallyControlled())
    	return;
		XM20AutoLas(Weapon).ShieldDeploy();

    // set the next firing time. must be careful here so client and server do not get out of sync
    if (bFireOnRelease)
    {
        if (bIsFiring)
            NextFireTime += MaxHoldTime + FireRate;
        else
            NextFireTime = Level.TimeSeconds + FireRate;
    }
    else
    {
        NextFireTime += FireRate;
        NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    }

    HoldTime = 0;
    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    {
        bIsFiring = false;
        Weapon.PutDown();
    }

}

defaultproperties
{
     bUseWeaponMag=False
     bAISilent=True
     bWaitForRelease=True
     FireRate=0.600000
     AmmoClass=Class'BWBPSomeOtherPack.Ammo_XM20Laser'
     AmmoPerFire=0
     BotRefireRate=0.300000
}