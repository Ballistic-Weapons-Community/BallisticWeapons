//=============================================================================
// AY90PrimaryFire.
//
// Uncharged: Projectile with gravity that sticks and explodes after impact
// Charged: Instant hit that spawns sticky projectile with timed explosion
// Full Charge: Instant hit and instant explosion
//
// by Sarge based on code by RS and Jiffy
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A800MinigunSecondaryFire extends BallisticProjectileFire;

var rotator OldLookDir, TurnVelocity;
var float	LastFireTime, MuzzleBTime, MuzzleCTime, OldFireRate;
var A800SkrithMinigun Minigun;

var float	LagTime;

var	int		ProjectileCount;

var bool	bStarted;
var bool	b100Charge;
var bool	b75Charge;
var bool	b50Charge;
var bool	b25Charge;

var float	NextTVUpdateTime;

var() float ChargeTime;
var() Sound	ChargeSound;
var() float AutoFireTime;
var() int BurstSize;

var() sound		ChargeFireSound;
var() sound		MaxChargeFireSound;


// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if(Super.AllowFire() && BW.MagAmmo >= 10)
		return true;
	else
		return false;
}

simulated function PlayPreFire()
{
	Weapon.AmbientSound = ChargeSound;
	//if (!BW.bScopeView)
		BW.SafeLoopAnim('PreFire', 0.15, TweenTime, ,"IDLE");
}

function ModeHoldFire()
{
    if ( BW.HasMagAmmo(ThisModeNum))
    {
        Super.ModeHoldFire();
		BW.bPreventReload = True;
    }
}

simulated event ModeDoFire()
{
	if (BurstSize == 0)
	{
		if (HoldTime >= ChargeTime && BW.MagAmmo >= 40)
		{
			BurstSize=4;
		}
		else if (HoldTime >= (ChargeTime*0.75) && BW.MagAmmo >= 30)
		{
			BurstSize=3;
		}
		else if (HoldTime >= (ChargeTime/2) && BW.MagAmmo >= 20)
		{
			BurstSize=2;
		}
		else if (HoldTime >= (ChargeTime/4) && BW.MagAmmo >= 10)
		{
			BurstSize=1;
		}
		else
		{
			BurstSize=0;
		}
		Weapon.AmbientSound = Weapon.default.AmbientSound;
	}
	
	//Keep firing while we're in the burst
	if (BurstSize > 0)
	{
		BurstSize = BurstSize-1;
		
		if (BurstSize > 0)
			SetTimer(FireRate/4.0f, true);
		else
			SetTimer(FireRate, false);
			
		b100Charge=false;
		b75Charge=false;
		b50Charge=false;
		b25Charge=false;
			
		if (!AllowFire())
			return;

		//jam code removed

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

		if (MaxHoldTime > 0.0)
			HoldTime = FMin(HoldTime, MaxHoldTime);

		ConsumedLoad += Load; //Timer that was here is repurposed
		if (Weapon.Role == ROLE_Authority)
		{
			if (BW != None)
				BW.ConsumeMagAmmo(ThisModeNum,ConsumedLoad);
			else
				Weapon.ConsumeAmmo(ThisModeNum,ConsumedLoad);
			if (bPendingTryJam)
				TryJam();
		}
		ConsumedLoad=0;
		// server
		if (Weapon.Role == ROLE_Authority)
		{
			//Weapon.ConsumeAmmo(ThisModeNum, Load);
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

		// set the next firing time. must be careful here so client and server do not get out of sync
		if (bFireOnRelease)
		{
			if (bIsFiring)
				NextFireTime += MaxHoldTime + FireRate;
			else if (BurstSize > 0)
				NextFireTime = Level.TimeSeconds + FireRate/4.0;
			else
				NextFireTime = Level.TimeSeconds + FireRate;
		}
		else if (bBurstMode)
		{
			BurstCount++;
			if (BurstCount >= MaxBurst)
			{
				NextFireTime += FireRate * (1 + (MaxBurst * (1.0f - BurstFireRateFactor)));
				NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
				BurstCount = 0;
			}
			else
			{
				NextFireTime += FireRate * BurstFireRateFactor;
				NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
			}
		}
		else
		{
			NextFireTime += FireRate;
			NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
		}
		
		Load = AmmoPerFire;
		HoldTime = 0;

		if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
		{
			bIsFiring = false;
			Weapon.PutDown();
		}

		if (BW != None)
		{
			BW.bNeedReload = BW.MayNeedReload(ThisModeNum, ConsumedLoad);
			if (bCockAfterFire || (bCockAfterEmpty && BW.MagAmmo - ConsumedLoad < 1))
				BW.bNeedCock=true;
			BW.bPreventReload = False;
		}
	}
}

// Timer modified to handle firing a burst after the trigger is released, consumption delay code removed
simulated event Timer()
{
	//log("timer triggered");
	if (BurstSize > 0)
		ModeDoFire();
}

simulated function ModeTick(float DT)
{
	Super.ModeTick(DT);

    if (bIsFiring)
	{
		if (HoldTime >= AutoFireTime)
		{
			Weapon.StopFire(ThisModeNum);
			Weapon.AmbientSound = None;
		}
		if (HoldTime >= ChargeTime && BW.MagAmmo >= 40 && !b100Charge)
		{
			b100Charge=True;
			BW.PlaySound(Minigun.ChargeLoadSound, SLOT_None, 1.3, , 32, 1.0, true);
			A800SkrithMinigun(BW).SetGlowSize(1.00);
			BurstSize=4;
		}
		else if (HoldTime >= (ChargeTime*0.75) && BW.MagAmmo >= 30 && !b75Charge)
		{
			b75Charge=True;
			BW.PlaySound(Minigun.ChargeLoadSound, SLOT_None, 1.3, , 32, 1.0, true);
			A800SkrithMinigun(BW).SetGlowSize(0.75);
			BurstSize=3;
		}
		else if (HoldTime >= (ChargeTime/2) && BW.MagAmmo >= 20 && !b50Charge)
		{
			b50Charge=True;
			BW.PlaySound(Minigun.ChargeLoadSound, SLOT_None, 1.3, , 32, 1.0, true);
			A800SkrithMinigun(BW).SetGlowSize(0.50);
			BurstSize=2;
		}
		else if (HoldTime >= (ChargeTime/4) && BW.MagAmmo >= 10 && !b25Charge)
		{
			b25Charge=True;
			BW.PlaySound(Minigun.ChargeLoadSound, SLOT_None, 1.3, , 32, 1.0, true);
			A800SkrithMinigun(BW).SetGlowSize(0.25);
			BurstSize=1;
		}
	}
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	Proj.Instigator = Instigator;
	A800StickyBombProjectile(Proj).Master = A800SkrithMinigun(BW);
	if (A800SkrithMinigun(BW).Target != None)
		A800StickyBombProjectile(Proj).SetProjTarget(A800SkrithMinigun(BW).Target);
}


//Do the spread on the client side
function PlayFiring()
{
	super.PlayFiring();

	if (!bStarted)
	{
		bStarted = true;
		BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		BW.PlaySound(Minigun.BarrelStartSound, SLOT_None, 0.5, , 32, 1.0, true);
	}
}

function ServerPlayFiring()
{
	super.ServerPlayFiring();
	
	if (!bStarted)
	{
		bStarted = true;
		BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		BW.PlayOwnedSound(Minigun.BarrelStartSound, SLOT_None, 0.5, , 32, 1.0, true);
	}
}

function StopFiring()
{
	super.StopFiring();
	bStarted = false;
}

simulated event PostBeginPlay()
{
	OldLookDir = BW.GetPlayerAim();

	super.PostBeginPlay();
}

defaultproperties
{
     ChargeTime=4.000000
     AutoFireTime=5.000000
     ChargeSound=Sound'BWBP_SKC_Sounds.SkrithBow.SkrithBow-BoltCharge'
     ChargeFireSound=Sound'BWBP_SKC_Sounds.SkrithBow.SkrithBow-BoltBlast'
     MaxChargeFireSound=Sound'BWBP_SKC_Sounds.SkrithBow.SkrithBow-BoltBlastMax'
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BWBP_SKC_Pro.A73BFlashEmitter'
     //RecoilPerShot=256.000000
     //XInaccuracy=9.000000
     //YInaccuracy=6.000000
     AmmoPerFire=10
     BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.SkrithBow.SkrithBow-BoltShot',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	 bFireOnRelease=True
     FireEndAnim=
     TweenTime=0.000000
     FireRate=1.000000
     AmmoClass=Class'BallisticProV55.Ammo_Cells'
     ShakeRotMag=(X=32.000000,Y=10.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.750000
     ShakeOffsetMag=(X=-8.00)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.750000
     ProjectileClass=Class'BWBP_SKC_Pro.AY90BoltProjectile'
     WarnTargetPct=0.200000
}
