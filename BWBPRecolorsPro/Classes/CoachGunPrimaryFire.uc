//=============================================================================
// CoachGunPrimaryFire.
//
// Individual barrel fire for Coach Gun. Uses 10-gauge shells and has a longer
// barrel than the MRS138 and SKAS-21. Deals superior damage with good range.
// Lengthy reload after each shot balances the gun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CoachGunPrimaryFire extends BallisticProShotgunFire;

var() Actor			MuzzleFlash2;		// The muzzleflash actor
var() sound		SlugFireSound;

var Name			AimedFireEmptyAnim, FireEmptyAnim;

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();

	if (BW.HasNonMagAmmo(0))
	{
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
		if (BW.BlendFire())
			BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
	}
	
	else
	{
		BW.SafePlayAnim(FireEmptyAnim, FireAnimRate, TweenTime, ,"FIRE");
		if (BW.BlendFire())
			BW.SafePlayAnim(AimedFireEmptyAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
	}
}

//Do the spread on the client side
function PlayFiring()
{
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);
		
	if (BW.HasNonMagAmmo(0))
	{
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
		if (BW.BlendFire())
			BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
	}
	
	else
	{
		BW.SafePlayAnim(FireEmptyAnim, FireAnimRate, TweenTime, ,"FIRE");
		if (BW.BlendFire())
			BW.SafePlayAnim(AimedFireEmptyAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
	}

    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

simulated function SwitchWeaponMode (byte newMode)
{
	if (newMode == 1) //Slug Mode
	{
		XInaccuracy=32;
		YInaccuracy=32;
		
		TraceCount=1;
		
		TraceRange.Min=9000;
		TraceRange.Max=9000;
		
		CutOffDistance=3072;
     	RangeAtten=0.50000;
		
     	FlashScaleFactor=3.000000;
		
		Damage=55;
		DamageHead=83;
		DamageLimb=55;
		
		KickForce = 30000;
		
		PenetrateForce=500;
		bPenetrate=True;
		
		BallisticFireSound.Sound=SlugFireSound;
		BallisticFireSound.Volume=7.1;
		
		if (Weapon.ThirdPersonActor != None)
			CoachGunAttachment(Weapon.ThirdPersonActor).bSlugMode=true;
			
		DamageType=Class'DTCoachSlug';
		DamageTypeArm=Class'DTCoachSlug';
		DamageTypeHead=Class'DTCoachSlug';

		GotoState('Slug');

	}
	else //Shot Mode
	{
		XInaccuracy=default.XInaccuracy;
		YInaccuracy=default.YInaccuracy;
		
		TraceCount=default.TraceCount;
		
		TraceRange.Min=default.TraceRange.Min;
		TraceRange.Max=default.TraceRange.Max;
		
		CutOffDistance=default.CutOffDistance;
		RangeAtten=default.RangeAtten;
		
		FlashScaleFactor=default.FlashScaleFactor;
		
		Damage = Default.Damage;
		DamageHead = Default.DamageHead;
		DamageLimb = Default.DamageLimb;
		
		KickForce=default.KickForce;
		
		PenetrateForce=0;
		bPenetrate=False;
		
		RecoilPerShot=Default.RecoilPerShot;
		
		BallisticFireSound.Sound=default.BallisticFireSound.Sound;
		BallisticFireSound.Volume=default.BallisticFireSound.Volume;
		
		CoachGunAttachment(Weapon.ThirdPersonActor).bSlugMode=false;
		
		DamageType=Class'DTCoachShot';
		DamageTypeArm=Class'DTCoachShot';
		DamageTypeHead=Class'DTCoachShot';
		
		GotoState('');
	}
}

//=========================================
// Super Magnum code
//=========================================
simulated state Slug
{
	// Get aim then run several individual traces using different spread for each one
	function DoFireEffect()
	{	
	    local Vector StartTrace;
		local Rotator R, Aim;
		
		ConsumedLoad = BW.MagAmmo;

		Aim = GetFireAim(StartTrace);
		R = Rotator(GetFireSpread() >> Aim);
		
		if (ConsumedLoad == 2)
			DoubleTrace(StartTrace, R, vect(0,8,0));
		else
			DoTrace(StartTrace + (vect(0,-12,0) >> Rotator(StartTrace)), R);

		Super(BallisticFire).DoFireEffect();
	}
	
	// Do the trace to find out where bullet really goes
	function DoubleTrace (Vector InitialStart, Rotator Dir, Vector Offsetting)
	{
		local int						PenCount, WallCount, WallPenForce;
		local Vector					End, X, HitLocation, HitNormal, Start, WaterHitLoc, LastHitLoc, ExitNormal;
		local Material					HitMaterial, ExitMaterial;
		local float						Dist;
		local Actor						Other, LastOther;
		local bool						bHitWall;
		local byte						i;

		WallPenForce = WallPenetrationForce;

		for (i=0;i<2;i++)
		{
			// Work out the range
			Dist = TraceRange.Min + FRand() * (TraceRange.Max - TraceRange.Min);

			Start = InitialStart + ((Offsetting * ((2 * i) - 1)) >> Rotator(InitialStart));
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
						if (VSize(HitLocation - Start) > 1)
							WaterHitLoc=HitLocation;
						Start = HitLocation;
						Dist *= WaterRangeFactor;
						End = Start + X * Dist;
						Weapon.bTraceWater=false;
						continue;
					}

					LastHitLoc = HitLocation;
						
					// Got something interesting
					if (!Other.bWorldGeometry && Other != LastOther)
					{				
						OnTraceHit(Other, HitLocation, InitialStart, X, PenCount, WallCount, WallPenForce, WaterHitLoc);
		
						LastOther = Other;

						if (CanPenetrate(Other, HitLocation, X, PenCount))
						{
							PenCount++;
							Start = HitLocation + (X * Other.CollisionRadius * 2);
							End = Start + X * Dist;
							Weapon.bTraceWater=true;
							if (Vehicle(Other) != None)
								HitVehicleEffect (HitLocation, HitNormal, Other);
							continue;
						}
						else if (Vehicle(Other) != None)
							bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
						else if (Mover(Other) == None)
							break;
					}
					// Do impact effect
					if (Other.bWorldGeometry || Mover(Other) != None)
					{
						WallCount++;
						if (WallCount < MAX_WALLS && WallPenForce > 0 && GoThroughWall(Other, HitLocation, HitNormal, WallPenForce * ScaleBySurface(Other, HitMaterial), X, Start, ExitNormal, ExitMaterial))
						{
							WallPenForce -= VSize(Start - HitLocation) / ScaleBySurface(Other, HitMaterial);
			
							WallPenetrateEffect(Other, HitLocation, HitNormal, HitMaterial);
							WallPenetrateEffect(Other, Start, ExitNormal, ExitMaterial, true);
							Weapon.bTraceWater=true;
							continue;
						}
						bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
						break;
					}
					// Still in the same guy
					if (Other == Instigator || Other == LastOther)
					{
						Start = HitLocation + (X * FMax(32, Other.CollisionRadius * 2));
						End = Start + X * Dist;
						Weapon.bTraceWater=true;
						continue;
					}
					break;
				}
				else
				{
					LastHitLoc = End;
					break;
				}
			}
			// Never hit a wall, so just tell the attachment to spawn muzzle flashes and play anims, etc
			if (!bHitWall)
				NoHitEffect(X, InitialStart, LastHitLoc, WaterHitLoc);
				
			LastOther = None;
			PenCount = 0;
			WallCount = 0;
		}
	}

	// Even if we hit nothing, this is already taken care of in DoFireEffects()...
	function NoHitEffect (Vector Dir, optional vector Start, optional vector HitLocation, optional vector WaterHitLoc)
	{
		if (Weapon != None && level.NetMode != NM_Client)
		{
			if (HitLocation != vect(0,0,0) && HitLocation != WaterHitLoc)
				SendFireEffect(none, HitLocation, vect(0,0,0), 0, WaterHitLoc);
			else
				SendFireEffect(none, Start + Dir * TraceRange.Max, vect(0,0,0), 0, WaterHitLoc);
		}
	}

	// Spawn the impact effects here for StandAlone and ListenServers cause the attachment won't do it
	simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
	{
		local int Surf;

		if (!Other.bWorldGeometry && Mover(Other) == None && Vehicle(Other) == None || level.NetMode == NM_Client)
			return false;

		if (Vehicle(Other) != None)
			Surf = 3;
		else if (HitMat == None)
			Surf = int(Other.SurfaceType);
		else
			Surf = int(HitMat.SurfaceType);

		// Tell the attachment to spawn effects and so on
		SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
		if (!bAISilent)
			Instigator.MakeNoise(1.0);
		return true;
	}

	function OnTraceHit (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, int WallPenForce, optional vector WaterHitLocation)
	{
		Super(BallisticInstantFire).OnTraceHit(Other, HitLocation, TraceStart, Dir, PenetrateCount, WallCount, WallPenForce, WaterHitLocation);
	}
	
	// Returns normal for some random spread. This is seperate from GetFireDir for shotgun reasons mainly...
	simulated function vector GetFireSpread()
	{
		local float fX;
			local Rotator R;

		if (BW.bScopeView)
			return super(BallisticInstantFire).GetFireSpread();

		fX = frand();
		R.Yaw =  BW.ChaosAimSpread * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
		R.Pitch = BW.ChaosAimSpread * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
		return Vector(R);
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
		}
		
		if (!BW.bScopeView)
			BW.FireChaos = FClamp(BW.FireChaos + FireChaos, 0, 1);
		
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
			
			if (BW.HasNonMagAmmo(0))
				BW.ReloadState = RS_PreClipOut;
		}

	}
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
        if(BallisticTurret(Weapon.Owner) == None  && class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo) != None)
			class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo).AddFireStat(TraceCount, BW.InventoryGroup);
    }
    
	if (!BW.bScopeView)
		BW.FireChaos = FClamp(BW.FireChaos + FireChaos, 0, 1);
		
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
			
		if (BW.HasNonMagAmmo(0))
			BW.ReloadState = RS_PreClipOut;
	}
}

// Get aim then run several individual traces using different spread for each one
function DoFireEffect()
{
	local Vector StartTrace;
	local Rotator R, Aim;
	local int i;

	ConsumedLoad = BW.MagAmmo;

	Aim = GetFireAim(StartTrace);
	for (i=0;i<TraceCount * ConsumedLoad;i++)
	{
		R = Rotator(GetFireSpread() >> Aim);
		DoTrace(StartTrace, R);
	}

	ApplyHits();
		
	// Tell the attachment the aim. It will calculate the rest for the clients
	SendFireEffect(none, Vector(Aim)*TraceRange.Max, StartTrace, 0);
	if (ConsumedLoad == 2)
		SendFireEffect(none, Vector(Aim)*TraceRange.Max, StartTrace, 0);

	Super(BallisticFire).DoFireEffect();
}

function InitEffects()
{
	super.InitEffects();
    if ((MuzzleFlashClass != None) && ((MuzzleFlash2 == None) || MuzzleFlash2.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash2, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, 'tip2');
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
	local Coords C;
	local Actor MuzzleSmoke;
	local vector Start, X, Y, Z;

    if ((Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;

	if(ConsumedLoad == 2)
	{
		C = Weapon.GetBoneCoords('tip2');
		MuzzleFlash2.Trigger(Weapon, Instigator);
	}
	C = Weapon.GetBoneCoords('tip');
	MuzzleFlash.Trigger(Weapon, Instigator);
    if (!class'BallisticMod'.default.bMuzzleSmoke)
    	return;
    Weapon.GetViewAxes(X,Y,Z);
	Start = C.Origin + X * -180 + Y * 3;
	MuzzleSmoke = Spawn(class'MRT6Smoke', weapon,, Start, Rotator(X));

	if (!bBrassOnCock)
		EjectBrass();
}
//Check Sounds and damage types.

defaultproperties
{
	SlugFireSound=Sound'PackageSounds4ProExp.Redwood.SuperMagnum-Fire'
	AimedFireEmptyAnim="SightFire"
	FireEmptyAnim="Fire"
	HipSpreadFactor=4.000000
	CutOffDistance=2560.000000
	CutOffStartRange=1024.000000
	MaxSpreadFactor=2
	TraceCount=5
	TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
	ImpactManager=Class'BallisticProV55.IM_Shell'
	TraceRange=(Min=5000.000000,Max=7000.000000)
	WallPenetrationForce=24
	
	Damage=14.000000
	DamageHead=21.000000
	DamageLimb=14.000000
	RangeAtten=0.250000
	DamageType=Class'BWBPRecolorsPro.DTCoachShot'
	DamageTypeHead=Class'BWBPRecolorsPro.DTCoachShot'
	DamageTypeArm=Class'BWBPRecolorsPro.DTCoachShot'
	KickForce=8000
	MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
	FlashScaleFactor=1.500000
	BrassBone="EjectorR"
	BrassOffset=(X=-30.000000,Y=-5.000000,Z=5.000000)
	AimedFireAnim="SightFireCombined"
	RecoilPerShot=2048.000000
	VelocityRecoil=450.000000
	FireChaos=1.000000
	XInaccuracy=300.000000
	YInaccuracy=300.000000
	BallisticFireSound=(Sound=Sound'PackageSounds4ProExp.Redwood.Redwood-Fire',Volume=1.200000)
	FireAnim="FireCombined"
	FireAnimRate=0.800000
	FireRate=0.550000
	AmmoClass=Class'BWBPRecolorsPro.Ammo_CoachShells'
	ShakeRotMag=(X=128.000000,Y=64.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-30.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=2.000000
	BotRefireRate=0.60000
	WarnTargetPct=0.500000
}
