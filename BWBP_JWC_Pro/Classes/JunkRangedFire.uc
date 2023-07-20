//=============================================================================
// JunkRangedFire.
//
// FIXME
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkRangedFire extends BallisticProjectileFire;

var   JunkObject 	Junk;
var   JunkThrowFireInfo	FireInfo;
var() Array<name> 	FireAnims;
var() Array<name> 	PreFireAnims;
var int 			FireAnimNum;
var() byte			AnimSwitchStyle;
var() byte			AnimTimedStyle;
var   bool			bWaitingForFireNotify;
var() bool			bAnimTimedSound;
var   bool			bPendingSoundNotify;

var	  JunkMeleeFire MeleeFire;
var   bool			bDidMeleeFire;
var   bool			bActLikeMelee;

simulated function AssignFireInfo(JunkThrowFireInfo NewFire, JunkObject JO)
{
	if (Instigator == None)
		Instigator = Weapon.Instigator;

	if (JunkMeleeFire(Weapon.GetFireMode(0)) != None)
		MeleeFire = JunkMeleeFire(Weapon.GetFireMode(0));

	if (NewFire == None)
		return;

	JO.RangeFireRestore(NewFire, JO);
	if (JO.RangeFireAssign(NewFire, Junk))
		return;

	Junk				= JO;
	FireInfo			= NewFire;

	FireAnim			= NewFire.Anims[NewFire.Anims.length-1];
	PreFireAnim			= NewFire.PreFireAnims[NewFire.PreFireAnims.length-1];
	FireRate			= NewFire.RefireTime;
	FireAnimRate		= NewFire.AnimRate;
	BallisticFireSound  = NewFire.Sound;
	bFireOnRelease		= NewFire.bFireOnRelease;
	bWaitForRelease		= NewFire.bFireOnRelease;
	bNowWaiting			= NewFire.bFireOnRelease;
	AmmoPerFire			= NewFire.AmmoPerFire;

	ProjectileClass		= NewFire.ProjectileClass;
	ProjectileClass.default.Speed = Newfire.ProjSpeed;
	SpawnOffset			= NewFire.ProjSpawnOffset;
	FireAnims.length	= NewFire.Anims.Length;
	PreFireAnims.length = NewFire.PreFireAnims.length;
	FireAnims			= NewFire.Anims;
	PreFireAnims		= NewFire.PreFireAnims;
	AnimSwitchStyle		= NewFire.AnimStyle;
	AnimTimedStyle		= NewFire.AnimTimedFire;
	bAnimTimedSound		= NewFire.bAnimTimedSound;
	AimError			= NewFire.AimError;
}

simulated function SwitchToRanged(JunkMeleeFireInfo NewFire)
{
	if (Junk.SwitchToRanged(self, NewFire))
		return;
	FireAnim			= FireInfo.Anims[FireInfo.Anims.length-1];
	PreFireAnim			= FireInfo.PreFireAnims[FireInfo.PreFireAnims.length-1];
	FireRate			= FireInfo.RefireTime;
	FireAnimRate		= FireInfo.AnimRate;
	BallisticFireSound  = FireInfo.Sound;
//	bFireOnRelease		= FireInfo.bFireOnRelease;
//	bWaitForRelease		= FireInfo.bFireOnRelease;
//	bNowWaiting			= FireInfo.bFireOnRelease;
	AmmoPerFire			= FireInfo.AmmoPerFire;

	FireAnims.length	= FireInfo.Anims.Length;
	PreFireAnims.length = FireInfo.PreFireAnims.length;
	FireAnims			= FireInfo.Anims;
	PreFireAnims		= FireInfo.PreFireAnims;
	FireAnimNum			= Min(FireAnimNum, FireAnims.length-1);
	AnimSwitchStyle		= FireInfo.AnimStyle;
	AnimTimedStyle		= FireInfo.AnimTimedFire;
	bAnimTimedSound		= NewFire.bAnimTimedSound;

//	MeleeFire.AssignHitInfo(NewFire);
	GotoState('Ranged');
}

simulated function SwitchToMelee(JunkMeleeFireInfo NewFire)
{
	if (NewFire == None)
		return;
	if (Junk != None && Junk.SwitchToMelee(self, NewFire))
		return;

	FireAnim			= NewFire.Anims[NewFire.Anims.length-1];
	PreFireAnim			= NewFire.PreFireAnims[NewFire.PreFireAnims.length-1];
	FireRate			= NewFire.RefireTime;
	FireAnimRate		= NewFire.AnimRate;
	BallisticFireSound  = NewFire.Sound;
//	bFireOnRelease		= NewFire.bFireOnRelease;
//	bWaitForRelease		= NewFire.bFireOnRelease;
//	bNowWaiting			= NewFire.bFireOnRelease;
	AmmoPerFire			= NewFire.AmmoPerFire;

	FireAnims.length	= NewFire.Anims.Length;
	PreFireAnims.length = NewFire.PreFireAnims.length;
	FireAnims			= NewFire.Anims;
	PreFireAnims		= NewFire.PreFireAnims;
	FireAnimNum			= Min(FireAnimNum, FireAnims.length-1);
	AnimSwitchStyle		= NewFire.AnimStyle;
	AnimTimedStyle		= NewFire.AnimTimedFire;
	bAnimTimedSound		= NewFire.bAnimTimedSound;

	MeleeFire.AssignHitInfo(NewFire);
	GotoState('Melee');
}

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if (bActLikeMelee && MeleeFire != None)
		return MeleeFire.AllowFire();
	if (JunkWeapon(Weapon).Junk == None || !JunkWeapon(Weapon).Junk.bCanThrow || JunkWeapon(Weapon).bEmptyHanded)
		return false;
	return Super.AllowFire();
}

/*
event ModeHoldFire()
{
	if (bActLikeMelee && MeleeFire != None)
	{
		MeleeFire.ModeHoldFire();
		return;
	}
	super.ModeHoldFire();
}
*/
/*
//// client animation ////
function PlayPreFire()
{
	if (bActLikeMelee && MeleeFire != None)
	{
		MeleeFire.PlayPreFire();
		return;
	}
	super.PlayPreFire();
}
*/

simulated function IncrementAnims()
{
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
}
simulated function FireRecoil ()
{
//	BW.AddRecoil(RecoilPerShot, ThisModeNum);
}

simulated function JunkAttacked()
{
	if (JunkWeapon(Weapon) != None)
		JunkWeapon(Weapon).JunkAttacked();
}
state Melee
{
	function BeginState()
	{
		bActLikeMelee=true;
	}
	function EndState()
	{
		bActLikeMelee=false;
	}

	simulated event ModeDoFire()
	{
    	if (!AllowFire())
	        return;
    	if (bDidMeleeFire)
	    {
			bDidMeleeFire=false;
			return;
    	}
    	IncrementAnims();

		BW.bPreventReload=true;
		BW.FireCount++;

	    if (MaxHoldTime > 0.0)
    	    HoldTime = FMin(HoldTime, MaxHoldTime);

			Weapon.ConsumeAmmo(MeleeFire.ThisModeNum,MeleeFire.AmmoPerFire);
	    // server
    	if (Weapon.Role == ROLE_Authority)
	    {
			if (AnimTimedStyle > 0)
				bWaitingForFireNotify = true;
		    else
		        MeleeFire.DoFireEffect();
			JunkAttacked();
//			FireRecoil();
        	if ( (Instigator == None) || (Instigator.Controller == None) )
				return;
	        if ( AIController(Instigator.Controller) != None )
        	    AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
    	    Instigator.DeactivateSpawnProtection();
	    }
		else
			JunkAttacked();
//			FireRecoil();

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
	simulated function AnimFireNotify(byte TimingStyle)
	{
	   	if (AnimTimedStyle > 0 && AnimTimedStyle == TimingStyle && bWaitingForFireNotify)
	   	{
	   		if (Weapon.Role == ROLE_Authority)
	       		MeleeFire.DoFireEffect();
			bWaitingForFireNotify = false;
		}
	}
}

auto state Ranged
{
	simulated event ModeDoFire()
	{
		if (bActLikeMelee && MeleeFire != None)
		{
			MeleeFire.ModeDoFire();
			return;
		}
    	if (!AllowFire())
        	return;
	    if (bDidMeleeFire)
    	{
			bDidMeleeFire=false;
			return;
    	}

    	IncrementAnims();

		BW.bPreventReload=true;
		BW.FireCount++;

	    if (MaxHoldTime > 0.0)
    	    HoldTime = FMin(HoldTime, MaxHoldTime);

	    // server
    	if (Weapon.Role == ROLE_Authority)
	    {
			if (BW != None)
				BW.ConsumeMagAmmo(ThisModeNum,AmmoPerFire);
			else
				Weapon.ConsumeAmmo(ThisModeNum,AmmoPerFire);
			if (AnimTimedStyle > 0)
				bWaitingForFireNotify = true;
		    else
		        DoFireEffect();
			JunkAttacked();
//			FireRecoil();
        	if ( (Instigator == None) || (Instigator.Controller == None) )
				return;
	        if ( AIController(Instigator.Controller) != None )
    	        AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        	Instigator.DeactivateSpawnProtection();
	    }
		else
			JunkAttacked();
//			FireRecoil();
		if (AnimTimedStyle == 0)
			JunkWeapon(Weapon).JunkThrown();

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
	simulated function AnimFireNotify(byte TimingStyle)
	{
	   	if (bWaitingForFireNotify && AnimTimedStyle > 0 && AnimTimedStyle == TimingStyle)
	   	{
			JunkWeapon(Weapon).JunkThrown();
	   		if (Weapon.Role == ROLE_Authority)
	    	    DoFireEffect();
			bWaitingForFireNotify = false;
		}
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

	if (Weapon.Role < ROLE_Authority && AnimTimedStyle > 0)
		bWaitingForFireNotify = true;
	if (bAnimTimedSound)
		bPendingSoundNotify = true;
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
}

simulated function AnimSoundNotify()
{
	if (bAnimTimedSound && bPendingSoundNotify && BallisticFireSound.Sound != None)
   	{
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		bPendingSoundNotify = false;
	}
}
simulated function AnimFireNotify(byte TimingStyle);

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
//	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, (self != JunkWeapon(Weapon).MeleeFire), WaterHitLoc);
	JunkWeaponAttachment(Weapon.ThirdPersonActor).JunkUpdateThrow();
}

simulated function bool HasAmmo()
{
	return true;
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	super.SpawnProjectile(Start, Dir);
	JunkProjectile(Proj).InitJunkClass(Junk.class);
}

defaultproperties
{
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     bUseWeaponMag=False
     BallisticFireSound=(Sound=SoundGroup'BWBP_JW_Sound.Crowbar.Crowbar-Swing')
     bTossed=True
     bFireOnRelease=True
     PreFireAnim="Hit2"
     FireAnim="Hit1"
     FireForce="AssaultRifleAltFire"
     FireRate=2.000000
     AmmoClass=Class'BWBP_JWC_Pro.Ammo_JunkWarAmmo'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBP_JWC_Pro.JunkProjectile'
     BotRefireRate=0.300000
     WarnTargetPct=0.200000
}
