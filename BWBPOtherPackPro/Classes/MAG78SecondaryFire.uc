//=============================================================================
// EKS43SecondaryFire.
//
// Vertical/Diagonal held swipe for the EKS43. Uses swipe system and is prone
// to headshots because the highest trace that hits an enemy will be used to do
// the damage and check hit area.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MAG78SecondaryFire extends BallisticMeleeFire;

var() Pawn		HookedVictim;
var() float		HookTime;

var() sound		SawFreeLoop;
var() sound		SawHackLoop;
var() sound		SawStop;

var bool 			bHitThisTick;

//	SawStart		Normal to held
//	SawIdle			Saw Held
//	SawAttack		Saw Held and hitting
//	SawAttackEnd	Saw Held releasng target going to saw held
//	SawEnd			Saw Release

//	BWBP4-Sounds.DarkStar.Dark-
//	Saw			held, idle
//	SawOpen		Start saw mode
//	SawClose	Leaving saw mode
//	SawPitch	Attacking enemy with saw
//	SawHits		Looping impact sounds
//

simulated function bool AllowFire()
{
	if (!Super(BallisticFire).AllowFire())
	{
		if (bIsFiring)
		{
			StopFiring();
			bIsFiring=False;
		}
		return false;
	}
	return true;
}

//Do the spread on the client side
function PlayFiring()
{
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.0);

	if (MAG78Longsword(Weapon).bLatchedOn)
		Weapon.AmbientSound = SawHackLoop;
	else
		Weapon.AmbientSound = SawFreeLoop;

    if (FireCount == 0)
    {
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		BW.SafePlayAnim('SawStart', FireAnimRate, TweenTime, ,"FIRE");
	}
    else if (FireCount > 4)
    {
		if (MAG78Longsword(Weapon).bLatchedOn)
    		BW.SafeLoopAnim('SawAttack', FireAnimRate, TweenTime, ,"FIRE");
		else
    		BW.SafeLoopAnim('SawIdle', FireAnimRate, TweenTime, ,"FIRE");
    }
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
}

function ServerPlayFiring()
{
    if (FireCount == 0)
    {
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		BW.SafePlayAnim('SawStart', FireAnimRate, TweenTime, ,"FIRE");
	}
    else if (FireCount > 4)
    {
		if (MAG78Longsword(Weapon).bLatchedOn)
    		BW.SafeLoopAnim('SawAttack', FireAnimRate, TweenTime, ,"FIRE");
		else
    		BW.SafeLoopAnim('SawIdle', FireAnimRate, TweenTime, ,"FIRE");
    }
}

simulated event ModeDoFire()
{
	BW.GunLength = 1;
	
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

	if (MaxHoldTime > 0.0)
		HoldTime = FMin(HoldTime, MaxHoldTime);

	if (!bHitThisTick)
	{
		ConsumedLoad += Load;
		SetTimer(FMin(0.1, FireRate/2), false);
	}
	
	// server
	if (Weapon.Role == ROLE_Authority)
	{
		DoFireEffect();
		
		MAG78Longsword(Weapon).NextAmmoTickTime = Level.TimeSeconds + 2;
		if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
		if ( AIController(Instigator.Controller) != None )
			AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
		Instigator.DeactivateSpawnProtection();
	}
	else if (!BW.bUseNetAim && !BW.bScopeView)
		ApplyRecoil();
	
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
		else
			NextFireTime = Level.TimeSeconds + FireRate;
	}
	else
	{
		NextFireTime += FireRate * (1 + BW.MeleeFatigue);
		NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
	}
	
	BW.MeleeFatigue = FMin(BW.MeleeFatigue + FatiguePerStrike, 1);
	
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
	}
	BW.GunLength = BW.default.GunLength;
	if (BW.SprintControl != None && BW.SprintControl.bSprinting)
		BW.PlayerSprint(true);
}

function DoFireEffect()
{
    local Vector StartTrace;
    local Rotator Aim, PointAim;
    local int i;

	Aim = GetFireAim(StartTrace);
	Aim = Rotator(GetFireSpread() >> Aim);

	// Do trace for each point
	for	(i=0;i<NumSwipePoints;i++)
	{
		if (SwipePoints[i].Weight < 0)
			continue;
		PointAim = Rotator(Vector(SwipePoints[i].Offset) >> Aim);
		MeleeDoTrace(StartTrace, PointAim, i==WallHitPoint, SwipePoints[i].Weight);
	}
	
	bHitThisTick = SwipeHits.Length > 0;

	// Do damage for each victim
	for (i=0;i<SwipeHits.length;i++)
	{
		OnTraceHit(SwipeHits[i].Victim, SwipeHits[i].HitLoc, StartTrace, SwipeHits[i].HitDir, 0, 0, 0);
		SwipeHits[i].Victim = None;
	}
	SwipeHits.Length = 0;

	Super(BallisticFire).DoFireEffect();
}

simulated function StopFiring()
{
	Weapon.PlayOwnedSound(SawStop,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius, 0.75 + MAG78Longsword(Weapon).ChainSpeed * 0.375 ,BallisticFireSound.bAtten);
	BW.GunLength = BW.default.GunLength;
	Weapon.PlayAnim(FireEndAnim, FireEndAnimRate, 0.0, 0);
}

simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	if (Weapon != None && Weapon.Role == ROLE_Authority)
		MAG78Longsword(Weapon).bLatchedOn = true;

	return super(BallisticMeleeFire).ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
}

function NoHitEffect (Vector Dir, optional vector Start, optional vector HitLocation, optional vector WaterHitLoc)
{
	if (Weapon != None && Weapon.Role == ROLE_Authority)
		MAG78Longsword(Weapon).bLatchedOn = false;

	super.NoHitEffect (Dir, Start, HitLocation, WaterHitLoc);
}

simulated event ModeTick(float DT)
{
	super(BallisticMeleeFire).ModeTick(DT);

	if (!IsFiring())
	{
		MAG78Longsword(Weapon).bLatchedOn = false;
		Weapon.AmbientSound = None;
	}
}

function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (Pawn(Target) != None && Pawn(Target).Health > 0)
	{
		HookedVictim = Pawn(Target);
		HookTime = Level.TimeSeconds;
	}

	MAG78Longsword(Weapon).bLatchedOn=true;
}

defaultproperties
{
     SawFreeLoop=Sound'BWBP4-Sounds.DarkStar.Dark-Saw'
     SawHackLoop=Sound'BWBP4-Sounds.DarkStar.Dark-SawPitched'
     SawStop=Sound'BWBP4-Sounds.DarkStar.Dark-SawClose'
     SwipePoints(0)=(offset=(Yaw=0))
     WallHitPoint=0
     NumSwipePoints=1
     TraceRange=(Min=150.000000,Max=150.000000)
     Damage=20.000000
     
     
     DamageType=Class'DT_MAGSAWStab'
     DamageTypeHead=Class'DT_MAGSAWStabHead'
     DamageTypeArm=Class'DT_MAGSAWStab'
	 FatiguePerStrike=0
     KickForce=500
     HookStopFactor=1.500000
     HookPullForce=150.000000
     ScopeDownOn=SDO_Fire
     BallisticFireSound=(Sound=Sound'BWBP4-Sounds.DarkStar.Dark-SawOpen',Volume=0.750000,Radius=256.000000)
     bAISilent=True
     PreFireAnim=
     FireAnim="SawStart"
     FireEndAnim="SawEnd"
     FireRate=0.100000
     AmmoClass=Class'Ammo_MAGSAWCharge'
     AmmoPerFire=1
     ShakeRotMag=(X=64.000000,Y=16.000000)
     ShakeRotRate=(X=1024.000000,Y=1024.000000,Z=512.000000)
     ShakeRotTime=1.000000
     WarnTargetPct=0.050000
}
