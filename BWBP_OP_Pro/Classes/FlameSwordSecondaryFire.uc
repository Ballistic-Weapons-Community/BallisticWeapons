//=============================================================================
// DragonsToothSecondaryFire.
//
// Lunge attack for the Dragons Tooth Sword. Does 100 damage regardless of area.
// Good for quick take downs, but bad against armored or healthier foes.
//
// REDACTED: Now is a double swipe.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FlameSwordSecondaryFire extends BallisticFire;

simulated function bool AllowFire()
{
    return ( Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire && !BW.bServerReloading && BW.MeleeState == MS_None);
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
     FireAnim="SpellShield"
     FireRate=2.000000
	 FireAnimRate=2
     AmmoClass=Class'BallisticProV55.Ammo_Knife'
     AmmoPerFire=0
	 //BallisticFireSound=(Sound=Sound'BWBP_OP_Sounds.FlameSword.FlameSword-Ignite',Volume=4.100000,Radius=256.000000,bAtten=True)
}
