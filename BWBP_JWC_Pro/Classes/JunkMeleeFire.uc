//=============================================================================
// JunkMeleeFire.
//
// The special, switching WeaponFire used by the junkweapon for melee fire.
// Properties and settings from the junkobjects are transferred to this
// WeaponFire to change a great deal of its behaviour.
// Everything from damage and range to anims and timing, etc, etc...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkMeleeFire extends BallisticMeleeFire;

var	  JunkObject	Junk;
var   JunkMeleeFireInfo	FireInfo;
var() Array<name> 	FireAnims;
var() Array<name> 	PreFireAnims;
var int 			FireAnimNum;
var() byte			AnimSwitchStyle;
var() byte			AnimTimedStyle;
var   bool			bWaitingForFireNotify;
var() bool			bAnimTimedSound;
var   bool			bPendingSoundNotify;

var	  JunkRangedFire RangedFire;

// Applies all the settings from a JunkMeleeFireInfo object and JunkObject
simulated function AssignFireInfo(JunkMeleeFireInfo NewFire, JunkObject JO)
{
	if (JunkRangedFire(Weapon.GetFireMode(1)) != None)
		RangedFire = JunkRangedFire(Weapon.GetFireMode(1));
	if (NewFire == None)
		return;

	JO.MeleeFireRestore(NewFire, JO);
	if (JO.MeleeFireAssign(NewFire, Junk))
		return;

	Junk		= JO;
	FireInfo	= NewFire;

	FireAnim			= NewFire.Anims[NewFire.Anims.length-1];
	PreFireAnim			= NewFire.PreFireAnims[NewFire.PreFireAnims.length-1];
	FireRate			= NewFire.RefireTime;
	FireAnimRate		= NewFire.AnimRate;
	BallisticFireSound  = NewFire.Sound;
	bFireOnRelease		= NewFire.bFireOnRelease;
	bWaitForRelease		= NewFire.bFireOnRelease;
	bNowWaiting			= NewFire.bFireOnRelease;
	AmmoPerFire			= NewFire.AmmoPerFire;

	AssignHitInfo(NewFire);

//						= NewFire.ImpactManager;
	FireAnims.length	= NewFire.Anims.Length;
	PreFireAnims.length = NewFire.PreFireAnims.length;
	FireAnims			= NewFire.Anims;
	PreFireAnims 		= NewFire.PreFireAnims;
	FireAnimNum			= Min(FireAnimNum, FireAnims.length-1);
	AnimSwitchStyle		= NewFire.AnimStyle;
	AnimTimedStyle		= NewFire.AnimTimedFire;
	bAnimTimedSound		= NewFire.bAnimTimedSound;
}
// Non anim and timing related props. Basically just the stuff used by DoFireEffect() and onwards...
simulated function AssignHitInfo(JunkMeleeFireInfo NewFire)
{
	if (NewFire == None)
		return;

	FireInfo	= NewFire;

	Damage 				= NewFire.Damage.Misc;
	KickForce		 	= NewFire.KickForce;
	DamageType			= NewFire.DamageType;
	DamageTypeHead		= NewFire.DamageType;
	DamageTypeArm		= NewFire.DamageType;
	TraceRange	 		= NewFire.MeleeRange;
	SwipePoints			= NewFire.SwipePoints;
	WallHitPoint		= NewFire.SwipeHitWallPoint;
	NumSwipePoints		= NewFire.SwipePoints.length;
//						= NewFire.ImpactManager;
	bUseRunningDamage	= NewFire.bUseRunningDamage;
	AimError			= NewFire.AimError;
	HookStopFactor		= NewFire.HookStopFactor;
	HookPullForce 		= NewFire.HookPullForce;
}

// Can't fire without junk
simulated function bool AllowFire()
{
	if (JunkWeapon(Weapon).Junk == None || !JunkWeapon(Weapon).Junk.bCanMelee || JunkWeapon(Weapon).bEmptyHanded)
		return false;
	return Super.AllowFire();
}
simulated function FireRecoil ()
{
//	BW.AddRecoil(RecoilPerShot, ThisModeNum);
}

// Tell the JunkWeapon that we fired...
simulated function JunkAttacked()
{
	if (JunkWeapon(Weapon) != None)
		JunkWeapon(Weapon).JunkAttacked();
}

simulated event ModeDoFire()
{
    if (!AllowFire())
        return;

	if (RangedFire.IsFiring())
		RangedFire.bDidMeleeFire = true;
	if (AnimSwitchStyle == 1/*ACS_Random*/)
	{
		FireAnim = FireAnims[Rand(FireAnims.length)];
		PreFireAnim = PreFireAnims[Rand(PreFireAnims.length)];
	}
	else
	{
		FireAnim = FireAnims[FireAnimNum];
		if (PreFireAnims.length > FireAnimNum)
			PreFireAnim = PreFireAnims[FireAnimNum];
		FireAnimNum++;
		if (FireAnimNum >= FireAnims.Length)
			FireAnimNum = 0;
	}

	BW.bPreventReload=true;
	BW.FireCount++;

    if (MaxHoldTime > 0.0)
        HoldTime = FMin(HoldTime, MaxHoldTime);

	Weapon.ConsumeAmmo(ThisModeNum,AmmoPerFire);
    // server
    if (Weapon.Role == ROLE_Authority)
    {
		if (AnimTimedStyle > 0)
			bWaitingForFireNotify = true;
	    else
	        DoFireEffect();
		JunkAttacked();
//		FireRecoil();
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
    }
	else
		JunkAttacked();
//		FireRecoil();

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

    Load = AmmoPerFire;
    HoldTime = 0;

    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    {
        bIsFiring = false;
        Weapon.PutDown();
    }
}

function ServerPlayFiring()
{
	if (bAnimTimedSound)
		bPendingSoundNotify = true;
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	JunkWeapon(Weapon).bPendingReload = true;

    if (FireCount > 0)
    {
        if (Weapon.HasAnim(FireLoopAnim))
            BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
        else
            BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
    }
    else
        BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
}

function PlayFiring()
{
    if (FireCount > 0)
    {
        if (Weapon.HasAnim(FireLoopAnim))
            BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
        else
            BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
    }
    else
        BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	JunkWeapon(Weapon).bPendingReload = true;

	if (bAnimTimedSound)
		bPendingSoundNotify = true;
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
}
// Anim says we should play fire sound
simulated function AnimSoundNotify()
{
	if (bAnimTimedSound && bPendingSoundNotify && BallisticFireSound.Sound != None)
   	{
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		bPendingSoundNotify = false;
	}
}
// Anim says now is when it should hit the wall or enemy
simulated function AnimFireNotify(byte TimingStyle)
{
   	if (Weapon.Role == ROLE_Authority && AnimTimedStyle > 0 && AnimTimedStyle == TimingStyle && bWaitingForFireNotify)
   	{
        DoFireEffect();
		bWaitingForFireNotify = false;
	}
}

simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	local bool bResult;
	bResult = super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
	JunkWeapon(Weapon).JunkHitActor(Other, self, FireInfo);
	return bResult;
}
function OldDoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
	local float				Dmg;
	local class<DamageType>	HitDT;
	local Actor				Victim;
	local Vector			RelativeVelocity;
	local int				Surf, OldHealth;
	local Vector			ForceDir;

	Dmg = GetDamage(Other, HitLocation, Dir, Victim, HitDT);
	if (RangeAtten != 1.0)
		Dmg *= Lerp(VSize(HitLocation-TraceStart)/TraceRange.Max, 1, RangeAtten);
	if (PenetrateCount > 0)
		Dmg *= PDamageFactor ** PenetrateCount;
	if (WallCount > 0)
		Dmg *= WallPDamageFactor ** WallCount;
	if (bUseRunningDamage)
	{
		RelativeVelocity = Instigator.Velocity - Other.Velocity;
		Dmg += Dmg * (VSize(RelativeVelocity) / RunningSpeedThresh) * (Normal(RelativeVelocity) Dot Normal(Other.Location-Instigator.Location));
	}
	if (Pawn(Victim) != None)
		OldHealth = Pawn(Victim).Health;

	if (HookStopFactor != 0 && HookPullForce != 0 && Pawn(Victim) != None)
	{
		ForceDir = Normal(Other.Location-TraceStart);
		ForceDir.Z *= 0.3;

		Pawn(Victim).AddVelocity( Normal(Victim.Acceleration) * HookStopFactor * -FMin(Pawn(Victim).GroundSpeed, VSize(Victim.Velocity)) - ForceDir * HookPullForce );
	}

	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, KickForce * Dir, HitDT);
	if ( (Junk==None || !Junk.SendDamageEffect(self, FireInfo, OldHealth, Victim, Dmg, HitLocation, Dir, HitDT)) &&
	(OldHealth < 1 || (Pawn(Victim) != None && Pawn(Victim).Health < OldHealth)) )
	{
		if (Vehicle(Victim) != None)
			Surf = 3;//EST_Metal
		else
			Surf = 6;//EST_Flesh
		if (Weapon != None)
			JunkWeaponAttachment(Weapon.ThirdPersonActor).JunkHitActor(Victim, HitLocation, -Normal(Dir), Surf, (FireInfo != Junk.MeleeAFireInfo));
	}
}
function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
	if (Junk==None || !Junk.DoDamage(self, FireInfo, Other, HitLocation, TraceStart, Dir, PenetrateCount, WallCount))
		OldDoDamage (Other, HitLocation, TraceStart, Dir, PenetrateCount, WallCount, WaterHitLocation);
	if (Weapon != None)
		JunkWeapon(Weapon).JunkHitActor(Other, self, FireInfo);
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	if (Junk==None || !Junk.SendFireEffect(self, FireInfo, Other, HitLocation, HitNormal, Surf, WaterHitLoc))
		BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, (FireInfo != Junk.MeleeAFireInfo), WaterHitLoc);
}

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
     FireAnims(0)="Hit1"
     FireAnims(1)="Hit2"
     FireAnims(2)="Hit3"
     SwipePoints(0)=(offset=(Pitch=2000,Yaw=4000))
     SwipePoints(1)=(offset=(Pitch=1000))
     SwipePoints(3)=(offset=(Pitch=1000,Yaw=-2000))
     SwipePoints(4)=(offset=(Pitch=2000,Yaw=-4000))
     SwipePoints(5)=(Weight=-1)
     SwipePoints(6)=(Weight=-1)
     TraceRange=(Min=96.000000,Max=96.000000)
     DamageType=Class'BWBP_JWC_Pro.DTJunkDamage'
     bReleaseFireOnDie=False
     BallisticFireSound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing',Radius=32.000000,bAtten=True)
     bAISilent=True
     PreFireAnim="PrepHit"
     FireAnim="Hit1"
     AmmoClass=Class'BWBP_JWC_Pro.Ammo_JunkWarAmmo'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=128.000000)
     ShakeRotRate=(X=2500.000000,Y=2500.000000,Z=2500.000000)
     ShakeRotTime=2.500000
     BotRefireRate=0.800000
     WarnTargetPct=0.100000
}
