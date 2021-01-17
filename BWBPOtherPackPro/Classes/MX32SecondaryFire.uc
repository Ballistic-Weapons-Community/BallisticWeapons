class MX32SecondaryFire extends BallisticProProjectileFire;

var() int 		Rockets;

simulated function AdjustLaserParams(bool bLaserOn)
{
	if (bLaserOn)
	{	
		//properties for directed rockets
		FireRate=0.18;
		FireRecoil/=2;
		FireChaos/=1.3;
		XInaccuracy/=1.2;
		YInaccuracy/=1.2;
	}

	else
	{
		//properties for normal rockets
		FireRate=default.FireRate;
		FireRecoil=default.FireRecoil;
		FireChaos=default.FireChaos;
		XInaccuracy=default.XInaccuracy;
		YInaccuracy=default.YInaccuracy;
	}
}

simulated function bool CheckRockets()
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (Rockets <= 0)
	{
		weapon.GetAnimParams(channel, seq, frame, rate);
		if (seq == MX32Weapon(Weapon).RocketsLoadAnim)
			return false;
		MX32Weapon(Weapon).LoadRockets();
		bIsFiring=false;
		return false;
	}
	
	return true;
}

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	/*

	//Force noobs to scope.
	if ((BW.BCRepClass.default.bSightFireOnly || class'BallisticWeapon'.default.SightsRestrictionLevel > 0) && BW.bUseSights && BW.SightingState != SS_Active && !BW.bScopeHeld && Instigator.IsLocallyControlled() && PlayerController(Instigator.Controller) != None)
		BW.ScopeView();
	if (!BW.bScopeView && (class'BallisticWeapon'.default.SightsRestrictionLevel > 1 || (class'BallisticWeapon'.default.SightsRestrictionLevel > 0 && BW.ZoomType != ZT_Irons)))
		return false;
		
	*/	
		
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing

	if(!Super.AllowFire() || Rockets <= 0)
	{
		if (DryFireSound.Sound != None)
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
		BW.EmptyFire(1);
		return false;	// Does not use ammo from weapon mag. Is there ammo in inventory
	}

    return true;
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;

	if (!CheckRockets())
		return;
		
	Super.ModeDoFire();
	
	if (Rockets > 0)
		Rockets--;
}

function StopFiring()
{
	local int channel;
	local name seq;
	local float frame, rate;
	
	weapon.GetAnimParams(channel, seq, frame, rate);
	if (Seq == PreFireAnim)
		Weapon.PlayAnim(Weapon.IdleAnim, 1.0, 0.5);
}

function DoFireEffect()
{	
	if (MX32Weapon(Weapon).bLaserOn)
		ProjectileClass = class'BWBPOtherPackPro.MX32SeekerRocket';
	else
		ProjectileClass = class'BWBPOtherPackPro.MX32Rocket';
	
	Super.DoFireEffect();
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	super.SpawnProjectile(Start, Dir);
	if (MX32Weapon(Weapon).bLaserOn)
	{
		MX32SeekerRocket(Proj).Weapon = MX32Weapon(BW);
		MX32SeekerRocket(Proj).LastLoc = MX32Weapon(BW).GetRocketDir();
	}
}

defaultproperties
{
	 bUseWeaponMag=False
	 Rockets=12
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     FlashBone="RocketTip6"
     FlashScaleFactor=0.500000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.AIMS-Fire2',Volume=1.000000)
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bModeExclusive=False
	 FireAnim="RocketFire"
     AimedFireAnim="SightFire"
     FireRate=0.125000
	 FireRecoil=192
	 FireChaos=0.06
	 XInaccuracy=96.000000
     YInaccuracy=48.000000
     AmmoClass=Class'BWBPOtherPackPro.Ammo_MX32Rockets'
     AmmoPerFire=1
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBPOtherPackPro.MX32Rocket'
     BotRefireRate=0.600000
     WarnTargetPct=0.300000
     aimerror=600.000000
}
