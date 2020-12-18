class XMV850TW_PrimaryFire extends XMV850MinigunPrimaryFire;

// ModeDoFire from WeaponFire.uc, but with a few changes
simulated event ModeDoFire()
{
    if (!AllowFire()) 
		return;
	
    BW.bPreventReload=true;
	BW.FireCount++;

	if (BW.ReloadState != RS_None)
		BW.ReloadState = RS_None;

    // server
    if (Weapon.Role == ROLE_Authority)
    {
        DoFireEffect();
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
		if(Instigator != None  && class'Mut_Ballistic'.static.GetBPRI(Instigator.PlayerReplicationInfo) != None)
			class'Mut_Ballistic'.static.GetBPRI(Instigator.PlayerReplicationInfo).AddFireStat(load, BW.InventoryGroup);
    }
	
	BW.LastFireTime = Level.TimeSeconds;

    // client
    if (Instigator.IsLocallyControlled())
    {
        ShakeView();
        PlayFiring();
        FlashMuzzleFlash();
        StartMuzzleSmoke();
    }
    else // server
        ServerPlayFiring();

	NextFireTime += FireRate;
	NextFireTime = FMax(NextFireTime, Level.TimeSeconds);

    Load = AmmoPerFire;
    HoldTime = 0;

    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    {
        bIsFiring = false;
        Weapon.PutDown();
    }

	BW.bNeedReload = BW.MayNeedReload(ThisModeNum, ConsumedLoad);
}

defaultproperties
{
     DamageType=Class'BallisticProV55.DTXMV850MGDeploy'
     DamageTypeHead=Class'BallisticProV55.DTXMV850MGDeployHead'
     DamageTypeArm=Class'BallisticProV55.DTXMV850MGDeploy'
     FireRecoil=48.000000
     FirePushbackForce=0.000000
     FireChaos=0.080000
     aimerror=0.000000
}
