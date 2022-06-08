//=============================================================================
// TyphonPDWSecondaryFire.
//
// Activates a holo-shield. The shield can block up to 50 dmg. And holds 100 charge.
// Excessive damage will destroy the shield.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class TyphonPDWSecondaryFire extends BallisticFire;

simulated event ModeDoFire()
{
    if (MaxHoldTime > 0.0)
        HoldTime = FMin(HoldTime, MaxHoldTime);

    if (!Instigator.IsLocallyControlled())
    	return;
		TyphonPDW(Weapon).ShieldDeploy();

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
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_Laser'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
