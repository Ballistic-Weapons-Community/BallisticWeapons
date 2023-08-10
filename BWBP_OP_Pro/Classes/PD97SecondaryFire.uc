//=============================================================================
// PD97SecondaryFire
// 
// Taser fire.
//=============================================================================
class PD97SecondaryFire extends BallisticProjectileFire;

var PD97TazerProj ActiveProj;
var PD97TrackerProj ActiveTracker;
var   bool		bLoaded;

simulated function bool CheckTazer()
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (!bLoaded)
	{
		weapon.GetAnimParams(channel, seq, frame, rate);
		if (seq == PD97Bloodhound(Weapon).TazerLoadAnim)
			return false;
		PD97Bloodhound(Weapon).LoadTazer();
		bIsFiring=false;
		return false;
	}
	
	return true;
}

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing

	if(!Super.AllowFire() || !bLoaded)
	{
		if (DryFireSound.Sound != None)
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
		BW.EmptyFire(1);
		return false;	// Does not use ammo from weapon mag. Is there ammo in inventory
	}

    return true;
}

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		FireAnim = 'OpenTazerFire';
		BW.IdleAnim = 'OpenTazerIdle';
	}
	else
	{
		FireAnim = 'TazerFire';
		BW.IdleAnim = 'TazerIdle';
	}
	super.PlayFiring();
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	if (Proj != None)
	{
		Proj.Instigator = Instigator;
		PD97TazerProj(Proj).Master = PD97Attachment(BW.ThirdPersonActor);
		ActiveProj = PD97TazerProj(Proj);
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

	if (!CheckTazer())
		return;
		
	if (BW.Role == ROLE_Authority)
	{
		if (ActiveProj != None)
			ActiveProj.Destroy();
		//End tazing.
		else if (PD97Attachment(BW.ThirdPersonActor) != None)
			PD97Attachment(BW.ThirdPersonActor).TazeEnd();
	}
	
	if (PD97Bloodhound(BW) != None)
	{
		if (FireAnim == 'OpenTazerFire')
		{
			PD97Bloodhound(BW).IdleAnim = 'OpenIdle';
			PD97Bloodhound(BW).PlayAnim('OpenTazerEnd');
		}
		else
		{
			PD97Bloodhound(BW).IdleAnim = 'Idle';
			PD97Bloodhound(BW).PlayAnim('TazerEnd');
		}
	}
		
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
	
	bLoaded = false;
	
	HoldTime = 0;
}

state Tracker
{
	simulated function ApplyFireEffectParams(FireEffectParams params)
	{
		local ProjectileEffectParams effect_params;

		super(BallisticFire).ApplyFireEffectParams(params);

		effect_params = ProjectileEffectParams(params);

		ProjectileClass =  effect_params.ProjectileClass;
		SpawnOffset = effect_params.SpawnOffset;    
		default.ProjectileClass =  effect_params.ProjectileClass;
		default.SpawnOffset = effect_params.SpawnOffset;
		bFireOnRelease=false;
		bWaitForRelease = false;
		bNowWaiting = false;
	}
	
	function SpawnProjectile (Vector Start, Rotator Dir)
	{
		Proj = Spawn (ProjectileClass,,, Start, Dir);
		if (Proj != None)
		{
			Proj.Instigator = Instigator;
			PD97TrackerProj(Proj).Master = PD97Bloodhound(BW);
			ActiveTracker = PD97TrackerProj(Proj);
		}
	}

	simulated event ModeDoFire()
	{
		if (!AllowFire())
			return;

		if (!CheckTazer())
			return;
			
		if (BW.Role == ROLE_Authority)
		{
			//There can BE ONLY ONE
			if (ActiveTracker != None)
				ActiveTracker.Destroy();
			if (PD97Bloodhound(BW) != None && PD97Bloodhound(BW).ActiveBeacon != None)
			{
				PD97Bloodhound(BW).ActiveBeacon.Destroy();
			}
		}
		
		if (PD97Bloodhound(BW) != None)
		{
			if (FireAnim == 'OpenTazerFire')
			{
				PD97Bloodhound(BW).IdleAnim = 'OpenIdle';
				PD97Bloodhound(BW).PlayAnim('OpenTazerEnd');
			}
			else
			{
				PD97Bloodhound(BW).IdleAnim = 'Idle';
				PD97Bloodhound(BW).PlayAnim('TazerEnd');
			}
		}

		super.ModeDoFire();
	
		bLoaded = false;
		
	}
}
defaultproperties
{
	bLoaded=true
	SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
	bUseWeaponMag=False
	FlashBone="Tazer"
	BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
	bFireOnRelease=True
	PreFireAnim=
	FireAnim="TazerFire"
	FireForce="AssaultRifleAltFire"
	FireRate=0.900000
	AmmoClass=Class'BWBP_OP_Pro.Ammo_BloodhoundTazer'
	AmmoPerFire=1
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-8.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=2.000000
	ProjectileClass=Class'BWBP_OP_Pro.PD97TazerProj'
	BotRefireRate=0.300000
	WarnTargetPct=0.300000
}
