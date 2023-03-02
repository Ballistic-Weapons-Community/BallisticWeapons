//=============================================================================
// M7A3SecondaryFire
// 
// Taser fire.
//=============================================================================
class M7A3SecondaryFire extends BallisticProjectileFire;

var M7A3TazerProj ActiveProj;

function SpawnProjectile (Vector Start, Rotator Dir)
{
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	if (Proj != None)
	{
		Proj.Instigator = Instigator;
		M7A3TazerProj(Proj).Master = M7A3Attachment(BW.ThirdPersonActor);
		ActiveProj = M7A3TazerProj(Proj);
	}
}

simulated event ModeHoldFire()
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
	SetTimer(FMin(0.1, FireRate/2), false);
    // server
    if (Weapon.Role == ROLE_Authority)
    {
        DoFireEffect();
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
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
    {
        ServerPlayFiring();
    }
    
    Load = AmmoPerFire;

    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    {
        bIsFiring = false;
        Weapon.PutDown();
    }

	if (BW != None)
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, ConsumedLoad);
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
		
	if (BW.Role == ROLE_Authority)
	{
		if (ActiveProj != None)
			ActiveProj.Destroy();
		//End tazing.
		else if (M7A3Attachment(BW.ThirdPersonActor) != None)
			M7A3Attachment(BW.ThirdPersonActor).TazeEnd();
	}
	
	/*if (M7A3AssaultRifle(BW) != None)
	{
		if (FireAnim == 'OpenTazerFire')
		{
			M7A3AssaultRifle(BW).IdleAnim = 'OpenIdle';
			M7A3AssaultRifle(BW).PlayAnim('OpenTazerEnd');
		}
		else
		{
			M7A3AssaultRifle(BW).IdleAnim = 'Idle';
			M7A3AssaultRifle(BW).PlayAnim('TazerEnd');
		}
	}*/
		
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
}

defaultproperties
{
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     bUseWeaponMag=False
     FlashBone="Tip2"
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
     bFireOnRelease=True
     PreFireAnim=
     FireAnim="DartFireSingle"
     FireForce="AssaultRifleAltFire"
     FireRate=0.900000
     AmmoClass=Class'BWBP_OP_Pro.Ammo_BloodhoundDarts'
     AmmoPerFire=0
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBP_JCF_Pro.M7A3TazerProj'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}
