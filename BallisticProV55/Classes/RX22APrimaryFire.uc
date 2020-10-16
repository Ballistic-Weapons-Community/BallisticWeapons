//=============================================================================
// RX22APrimaryFire.
//
// A medium ranged stream of fire which easily sears players and goes into small
// spaces. Uses trace / projectile combo for hit detection.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RX22APrimaryFire extends BallisticInstantFire;

var   Actor		Ignition;
var   Actor		MuzzleFlame;
var   Actor		Heater;
var   bool		bIgnited;
var() sound		FireSoundLoop;

function float MaxRange()	{	return 1800;	}

function RX22AFireControl GetFireControl()
{
	return RX22AFlamer(Weapon).GetFireControl();
}

function DoFireEffect()
{
    local Vector Start, Dir, End, HitLocation, HitNormal;
    local Rotator Aim;
	local actor Other;
	local float Dist, NodeDist, DR;
	local int i;

    // the to-hit trace always starts right in front of the eye
    Start = Instigator.Location + Instigator.EyePosition();
	Aim = GetFireAim(Start);
	Aim = Rotator(GetFireSpread() >> Aim);

    Dir = Vector(Aim);
	End = Start + (Dir*MaxRange());
	Weapon.bTraceWater=true;
	for (i=0;i<20;i++)
	{
		Other = Trace(HitLocation, HitNormal, End, Start, true);
		if (Other == None || Other.bWorldGeometry || Mover(Other) != none || Vehicle(Other)!=None || FluidSurfaceInfo(Other) != None || (PhysicsVolume(Other) != None && PhysicsVolume(Other).bWaterVolume))
			break;
		Start = HitLocation + Dir * FMax(32, (Other.CollisionRadius*2 + 4));
	}
	Weapon.bTraceWater=false;

	if (Other == None)
		HitLocation = End;
	if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
		Other = None;

	Dist = VSize(HitLocation-Start);
	for (i=0;i<GetFireControl().GasNodes.Length;i++)
	{
		if (GetFireControl().GasNodes[i] == None || (RX22AGasCloud(GetFireControl().GasNodes[i]) == None && RX22AGasPatch(GetFireControl().GasNodes[i]) == None && RX22AGasSoak(GetFireControl().GasNodes[i]) == None))
			continue;
		NodeDist = VSize(GetFireControl().GasNodes[i].Location-Start);
		if (NodeDist > Dist)
			continue;
		DR = Dir Dot Normal(GetFireControl().GasNodes[i].Location-Start);
		if (DR < 0.75)
			continue;
		NodeDist = VSize(GetFireControl().GasNodes[i].Location - (Start + Dir * (DR * NodeDist)));
		if (NodeDist < 128)
			GetFireControl().GasNodes[i].TakeDamage(5, Instigator, GetFireControl().GasNodes[i].Location, vect(0,0,0), class'DTRX22ABurned');
	}


	if (Other != None && (Other.bWorldGeometry || Mover(Other) != none))
		GetFireControl().FireShot(Start, HitLocation, Dist, Other != None, HitNormal, Instigator, Other);
	else
		GetFireControl().FireShot(Start, HitLocation, Dist, Other != None, HitNormal, Instigator, None);

	SendFireEffect(Other, HitLocation, HitNormal, 0);
	
	Super(BallisticFire).DoFireEffect();
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
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
    if(InStr(Level.Game.GameName, "Freon") != -1 && class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo) != None)
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


//Do the spread on the client side
function PlayFiring()
{
//	BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;

	if (FireSoundLoop != None)
		Weapon.AmbientSound = FireSoundLoop;

	if (Ignition != None && !bIgnited)
	{
		BW.SafeLoopAnim(FireLoopAnim, FireAnimRate, TweenTime, ,"FIRE");
		Ignition.Trigger(Weapon, Instigator);
		bIgnited = true;
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
//	RX22AFlamer(Weapon).StartSprayFire();
	if (MuzzleFlame == None)
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlame, class'RX22AMuzzleFlame', Weapon.DrawScale*FlashScaleFactor, weapon, 'tip');
}

function ServerPlayFiring()
{
	if (!bIgnited)
	{
		bIgnited = true;
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
}

simulated function bool AllowFire()
{
	if (!super.AllowFire() || Instigator.HeadVolume.bWaterVolume)
	{
		if (bIgnited)
			StopFiring();
		return false;
	}
	return true;
}

function StopFiring()
{
	bIgnited = false;
	RX22AFlamer(Weapon).AmbientSound = None;
	if (MuzzleFlame != None)
	{
		Emitter(MuzzleFlame).Kill();
		MuzzleFlame = None;
	}
}

simulated function DestroyEffects()
{
	Super.DestroyEffects();
	if (Ignition != None)
		Ignition.Destroy();
	if (Heater != None)
		Heater.Destroy();
	if (MuzzleFlame != None)
		MuzzleFlame.Destroy();
}
simulated function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
	if (Heater == None || Heater.bDeleteMe )
		class'BUtil'.static.InitMuzzleFlash (Heater, class'RX22AHeater', Weapon.DrawScale*FlashScaleFactor, weapon, 'tip');
	RX22AHeater(Heater).SetHeat(0.0);
	RX22AFlamer(Weapon).Heater = RX22AHeater(Heater);
	if (Ignition == None || Ignition.bDeleteMe )
		class'BUtil'.static.InitMuzzleFlash (Ignition, class'RX22AIgniter', Weapon.DrawScale*FlashScaleFactor, weapon, 'tip2');
}

defaultproperties
{
     FireSoundLoop=Sound'BallisticSounds3.RX22A.RX22A-FireLoop'
     TraceRange=(Min=1800.000000,Max=1800.000000)
     Damage=14.000000
     DamageHead=14.000000
     DamageLimb=14.000000
     KickForce=1000
     PenetrateForce=50
     FireChaos=0.050000
     BallisticFireSound=(Sound=Sound'BallisticSounds3.RX22A.RX22A-Ignite',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireAnim="FireLoop"
     FireEndAnim=
     FireRate=0.090000
     AmmoClass=Class'BallisticProV55.Ammo_FlamerGas'
     ShakeRotMag=(X=64.000000,Y=64.000000,Z=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-10.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=True
	 bRecommendSplashDamage=False
	 BotRefireRate=0.99
     WarnTargetPct=0.4
}
