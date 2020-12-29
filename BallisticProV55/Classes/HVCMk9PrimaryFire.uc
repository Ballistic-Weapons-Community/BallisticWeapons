//=============================================================================
// HVCMk9PrimaryFire.
//
// Will eventually bounce to hit multiple targets
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HVCMk9PrimaryFire extends BallisticProInstantFire;

var() 	bool		bDoOverCharge;
var 	Sound 	FireSoundLoop;
var   	bool	 	bPendingOwnerZap;
var	bool 		bZapping, bSoundActive;
var	float	NextMessageTime;

var int SuccessiveHits;

simulated function bool AllowFire()
{
	if (HVCMk9LightningGun(Weapon).HeatLevel >= 10 || HVCMk9LightningGun(Weapon).bIsVenting || !StreamAllowFire())
	{
		if (Instigator.Role == ROLE_Authority && HvCMk9Attachment(Weapon.ThirdPersonActor).bStreamOn)
			HvCMk9Attachment(Weapon.ThirdPersonActor).EndStream();
		return false;
	}
	
	return true;
}

simulated function bool StreamAllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading

	if (BW.MagAmmo < AmmoPerFire)
	{
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		BW.EmptyFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
	else if (BW.bNeedReload)
		return false;
    return true;
}

//===========================================================================
// ApplyDamage
//
// Damage of stream ramps with successive hits
//===========================================================================
function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	class'BallisticDamageType'.static.GenericHurt (Victim, Min(Damage + SuccessiveHits * 5, 30), Instigator, HitLocation, MomentumDir, DamageType);
}

function DoFireEffect()
{
	local Vector StartTrace;
	local Rotator Aim;

	Aim = GetFireAim(StartTrace);
	Aim = Rotator(GetFireSpread() >> Aim);

    if (Level.NetMode == NM_DedicatedServer)
        BW.RewindCollisions();
	
	DoTrace(StartTrace, Aim);

    if (Level.NetMode == NM_DedicatedServer)
        BW.RestoreCollisions();
	
	if (HvCMk9Attachment(Weapon.ThirdPersonActor).StreamEffect == None)
		HvCMk9Attachment(Weapon.ThirdPersonActor).StartStream();

	ApplyRecoil();
}

//manages self damage
event Timer()
{	
	Super.Timer();
	if (bPendingOwnerZap)
	{
		bPendingOwnerZap=false;
		class'BallisticDamageType'.static.GenericHurt (Instigator, 50, Instigator, Instigator.Location + vector(Instigator.GetViewRotation()) * Instigator.CollisionRadius, KickForce * vector(Instigator.GetViewRotation()), class'DT_HVCOverheat');
	}
}

//if we aren't overheated, go to old trace - else blow shit up
function DoTrace (Vector Start, Rotator Dir)
{
	local actor Victims;
	local vector X;
	local float f;

	if (!bDoOverCharge)
	{
		OldDoTrace(Start, Dir);
		return;
	}
	
	X = vector(Dir);
	SendFireEffect(level, Start+X*64, -X, 0);
	
	foreach Instigator.VisibleCollidingActors( class 'Actor', Victims, 192, Start + X * 64 )
		if(!Victims.IsA('FluidSurfaceInfo') && !Victims.bWorldGeometry && Victims.bCanBeDamaged)
		{
			if (Victims == Instigator)
			{
				bPendingOwnerZap = true;
				SetTimer(0.15, false);
			}
			else
				class'BallisticDamageType'.static.GenericHurt (Victims, 50, Instigator, Victims.Location - X * Victims.CollisionRadius, f * KickForce * X, class'DT_HVCOverheat');
		}
}

function OldDoTrace(Vector InitialStart, Rotator Dir)
{
	local Vector					End, X, HitLocation, Start, HitNormal, LastHitLoc;
	local Material					HitMaterial;
	local float						Dist;
	local Actor						Other, LastOther;
	local bool						bHitWall;

	// Work out the range
	Dist = MaxRange();

	Start = InitialStart;
	X = Normal(Vector(Dir));
	End = Start + X * Dist;
	LastHitLoc = End;
	Weapon.bTraceWater=true;

	while (Dist > 0)		// Loop traces in case we need to go through stuff
	{
		// Do the trace
		Other = Trace (HitLocation, HitNormal, End, Start, true, , HitMaterial);
		Weapon.bTraceWater=false;
		Dist -= VSize(HitLocation - Start);
		if (Level.NetMode == NM_Client && (Other.Role != Role_Authority || Other.bWorldGeometry))
			break;
		if (Other != None)
		{
			// Water
			if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
			{
				bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other);
				SuccessiveHits = 0;
				break;
			}
			LastHitLoc = HitLocation;
			// Got something interesting
			if (!Other.bWorldGeometry && Other != LastOther)
			{
				OnTraceHit(Other, HitLocation, InitialStart, X, 0, 0, 0);
				
				SuccessiveHits++;

				if (Vehicle(Other) != None)
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other);
				else if (Mover(Other) == None)
				{
					bHitWall = true;
					if (HitMaterial != None)
						SendFireEffect(Other, HitLocation, HitNormal, HitMaterial.SurfaceType);
					else SendFireEffect(Other, HitLocation, HitNormal, 0);
					break;
				}
			}
			// Do impact effect
			if (Other.bWorldGeometry || Mover(Other) != None)
			{
				bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other);
				SuccessiveHits = 0;
				break;
			}
			
			SuccessiveHits = 0;
			break;
		}
		else
		{
			LastHitLoc = End;
			SuccessiveHits = 0;
			break;
		}
	}
	// Never hit a wall, so just tell the attachment to spawn muzzle flashes and play anims, etc
	if (!bHitWall)
		NoHitEffect(X, InitialStart, LastHitLoc);
}

function PlayFiring()
{
		if (!bSoundActive)
		{
			if (FireSoundLoop != None)
			Instigator.AmbientSound = FireSoundLoop;
			Instigator.SoundRadius=512;
			Instigator.SoundVolume = 255;
			bSoundActive = True;
		}
		
		if (Weapon.HasAnim(FireLoopAnim))
            BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	    ClientPlayForceFeedback(FireForce);  // jdf
    	FireCount++;
    	
    	if(Level.NetMode == NM_Client)
    	HvCMk9LightningGun(BW).AddHeat(0.3);
    	
	    if (Level.NetMode != NM_Client && !bDoOverCharge && HVCMk9LightningGun(Weapon).HeatLevel > 10)
		{
			bDoOverCharge = true;
			Weapon.PlaySound(HVCMk9LightningGun(Weapon).OverHeatSound,Slot_None,0.7,,64,1.0,true);
			HVCMk9LightningGun(Weapon).ClientOverCharge();
			Weapon.ServerStopFire(ThisModeNum);
		}

		CheckClipFinished();
}

function ServerPlayFiring()
{
		if (!bSoundActive)
		{
			if (FireSoundLoop != None)
			Instigator.AmbientSound = FireSoundLoop;
			Instigator.SoundRadius=512;
			Instigator.SoundVolume = 255;
			bSoundActive = True;
		}
		
		if (Weapon.Role == Role_Authority && !bDoOverCharge && HVCMk9LightningGun(Weapon).HeatLevel > 10)
		{
			bDoOverCharge = true;
			Weapon.PlaySound(HVCMk9LightningGun(Weapon).OverHeatSound,Slot_None,0.7,,64,1.0,true);
			HVCMk9LightningGun(Weapon).ClientOverCharge();
			Weapon.ServerStopFire(ThisModeNum);
		}
		
		if (Weapon.HasAnim(FireLoopAnim))
            BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	    ClientPlayForceFeedback(FireForce);  // jdf
    	FireCount++;

		CheckClipFinished();
}

function StopFiring()
{
		Super.StopFiring();
		
		if (Instigator.Role == ROLE_Authority)
			HvCMk9Attachment(Weapon.ThirdPersonActor).EndStream();
		
		if (bDoOverCharge)
		{
			NextFireTime += 2.0;
			bDoOverCharge = false;
		}
		bZapping=False;
		bSoundActive = False;
		Instigator.AmbientSound = None;
		Instigator.SoundVolume = Weapon.default.SoundVolume;
}


// ModeDoFire from WeaponFire.uc, but with a few changes
simulated event ModeDoFire()
{
    if (!AllowFire())
        return;
    if (bIsJammed)
    {
    	if (BW.FireCount == 0)
    	{
    		bIsJammed=false;
			if (bJamWastesAmmo && Weapon.Role == ROLE_Authority)
			{
				ConsumedLoad += Load;
				Timer();
			}
	   		if (UnjamMethod == UJM_FireNextRound)
	   		{
		        NextFireTime += FireRate;
   			    NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
				BW.FireCount++;
    			return;
    		}
    		if (!AllowFire())
    			return;
    	}
    	else
    	{
	        NextFireTime += FireRate;
   		    NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    		return;
   		}
    }

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

	ConsumedLoad += Load;
	SetTimer(FMin(0.1, FireRate/2), false);
    // server
    if (Weapon.Role == ROLE_Authority)
    {
        DoFireEffect();
        HVCMk9LightningGun(Weapon).AddHeat(0.15);
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
        if(BallisticTurret(Weapon.Owner) == None  && class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo) != None)
			class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo).AddFireStat(load, 1);
    }
	else if (!BW.bScopeView)
	{
		ApplyRecoil();
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

//    Weapon.IncrementFlashCount(ThisModeNum);

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

	if (BW != None)
	{
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, ConsumedLoad);
		if (bCockAfterFire || (bCockAfterEmpty && BW.MagAmmo - ConsumedLoad < 1))
			BW.bNeedCock=true;
	}

}

defaultproperties
{
     FireSoundLoop=Sound'BW_Core_WeaponSound.LightningGun.LG-FireLoop'
     Damage=10.000000
     HeadMult=1f
     LimbMult=1f
     
     DamageType=Class'BallisticProV55.DT_HVCLightning'
     DamageTypeHead=Class'BallisticProV55.DT_HVCLightning'
     DamageTypeArm=Class'BallisticProV55.DT_HVCLightning'
     KickForce=2000
	 MaxWaterTraceRange=9000
     bNoPositionalDamage=True
     FireChaos=0.000000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-FireStart')
     bPawnRapidFireAnim=True
     FireRate=0.070000
     AmmoClass=Class'BallisticProV55.Ammo_HVCCells'
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=50.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=1.000000,Y=1.000000,Z=1.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=2.000000
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.99
     WarnTargetPct=0.3
}
