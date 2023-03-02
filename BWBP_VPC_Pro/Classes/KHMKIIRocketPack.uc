//=============================================================================
//Duel Rocket Packs on sides of chopper
//used for making a barrage of TOW missiles, or tracking TOW missiles.

// Now has the added feature of a fancy kind of reloading sequence,
// that also has easy to ajust variables that choose how it reloads, if it needs reloading,
// and even if it has infinite ammo or not, which would force it to only have ammo after it respawns.

// by Logan "BlackEagle" Richert.
// Copyright(c) 2008. All Rights Reserved.
//=============================================================================
class KHMKIIRocketPack extends ONSWeapon
	placeable
	config(BWBP_VPC_Pro);

var 			vector 			OldDir;
var 			rotator 		OldRot;
var(Rockets) 	float			VelocitySpreadFactor;
var(Rockets) 	config float 	MaxLockRange, LockAim; // MaxLockRange is the max distance that it can target from, LockAim is how accurate your aim must be for it to track.
var(Rockets) 	config int 		LoadedShotCount, MaxShotCount;	// LoadedShotCount = # of shots loaded in each pack, MaxShotCount = Max # to load in each pack.

var 			bool 			bReloaded;		// Have we filled up on rockets?, or are we empty?.
var(Rockets)	config 	float	ReloadTime;		// Time it takes to reload the # of rockets set by the 'LoadRate'.
var(Rockets)	config	bool	bRequiresReloading;		// Does it require Reloading before it can be fired.
var(Rockets)	config	bool	bRequiresFullLoad;	// Does it have to be fully loaded before it can be fired.

var(Rockets)	config int		LoadRate;		// # of rockets to load per 'ReloadTime'.
var(Rockets)	sound			LoadSound;		// Sound to play when loading a rocket.
var(Rockets)	float			LoadSoundVolume;		// Volume of the sound made when a rocket is loaded.
var(Rockets)	float			LoadSoundRadius;		// How far away can you hear the sound made when a rocket is loaded.

var(Rockets)	config int		EjectRate;		// # of rockets to kill per shot.
var(Rockets)	sound			EjectSound;		// Sound to play when ejecting a rocket.
var(Rockets)	float			EjectSoundVolume, EjectSoundRadius;	// Volume of the sound made when a rocket is ejected, and how far away can you hear it from.
var   			float			InitialSpread;
var				float			NewDualFireOffset;

replication
{
	unreliable if (Role < ROLE_Authority || Role == ROLE_Authority)
		LoadedShotCount, NewDualFireOffset;

	reliable if (Role < ROLE_Authority || Role == ROLE_Authority)
		bReloaded;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
// Activates the 'Timer' function to control it's reloading.
	Enable('timer');
	SetTimer(ReloadTime,true); // Here it controls the speed at which the rockets load, and wether it's reloading loops.

	NewDualFireOffset = DualFireOffset;

	InitialSpread = Spread;

	OldDir = Vector(CurrentAim);
}

// This cool function ensures that the rockets will allways fire in the direction the KHMKII is facing.
simulated function Tick(float Delta)
{
	local int i;
	local xPawn P;
	local vector NewDir, PawnDir;
    local coords WeaponBoneCoords;

    Super.Tick(Delta);

	if ( (Role == ROLE_Authority) && (Base != None) )
	{
	    WeaponBoneCoords = GetBoneCoords(YawBone);
		NewDir = WeaponBoneCoords.XAxis;
		if ( (Vehicle(Base).Controller != None) && (NewDir.Z < 0.9) )
		{
			for ( i=0; i<Base.Attached.Length; i++ )
			{
				P = XPawn(Base.Attached[i]);
				if ( (P != None) && (P.Physics != PHYS_None) && (P != Vehicle(Base).Driver) )
				{
					PawnDir = P.Location - WeaponBoneCoords.Origin;
					PawnDir.Z = 0;
					PawnDir = Normal(PawnDir);
					if ( ((PawnDir.X <= NewDir.X) && (PawnDir.X > OldDir.X))
						|| ((PawnDir.X >= NewDir.X) && (PawnDir.X < OldDir.X)) )
					{
						if ( ((PawnDir.Y <= NewDir.Y) && (PawnDir.Y > OldDir.Y))
							|| ((PawnDir.Y >= NewDir.Y) && (PawnDir.X < OldDir.Y)) )
						{
							P.SetPhysics(PHYS_Falling);
							P.Velocity = WeaponBoneCoords.YAxis;
							if ( ((NewDir - OldDir) Dot WeaponBoneCoords.YAxis) < 0 )
								P.Velocity *= -1;
							P.Velocity = 500 * (P.Velocity + 0.3*NewDir);
							P.Velocity.Z = 200;
						}
					}
				}
			}
		}
		OldDir = NewDir;
	}
}
// This cool function ajusts the 'spread' depending on the speed of the vehicle
simulated function SetSpread(float VehicleSpeed)
{
	Spread = InitialSpread + (VehicleSpeed / VelocitySpreadFactor);
}

// Gets some settings to make the Primary rocket's Tracking behaviour depend on the 'MaxLockRange' and 'LockAim' variables.
simulated state ProjectileFireMode
{
	function Fire(Controller C)
	{
		local KHMKIITrackRocket R; // Name of the projectile that it uses, this must match the 'ProjectileClass'.
		local float BestAim, BestDist;

		R = KHMKIITrackRocket(SpawnProjectile(ProjectileClass, False));
		if (R != None)
		{
			if (AIController(C) != None)
				R.HomingTarget = C.Enemy;
			else
			{
				BestAim = LockAim;
				R.HomingTarget = C.PickTarget(BestAim, BestDist, vector(WeaponFireRotation), WeaponFireLocation, MaxLockRange);
			}
		}
	}
}
// This COOL.. function controls the firing of the rockets, and is what starts the relaoding process.
simulated event bool AttemptFire(Controller C, bool bAltFire)
{
  	if(Role != ROLE_Authority || bForceCenterAim)
		return False;

	CalcWeaponFire();

    NewDualFireOffset *= -1;

	if(LoadedShotCount >= MaxShotCount) // First it checks these variables to see how many rockets are loaded at present.
	{
		bReloaded=true; // then sets whether it is reloaded or not.
	}

	else if(LoadedShotCount<=0)//  bReloaded only has two states, when it's full and when it's empty, but nowhere between.
		bReloaded=false;

// Now it checks for some more variables to see how it should react.

	if(bRequiresReloading) // It will do the below only if the setting 'bRequiresReloading' is true.
	{
		if(bRequiresFullLoad) // It will do this if the setting 'bRequiresFullLoad' is true.
		{
			if(bAltFire && bReloaded) // checks wether it's an AltFire, and also if it's fully loaded.
			{
				FireSingle(C,true, true);
				FireCountdown = AltFireInterval;
			}
			else if(!bAltFire && bReloaded) // checks wether it's not an AltFire, and also if it's fully loaded.
			{
				FireSingle(C,false, true);
				FireCountdown = FireInterval;
			}
		}
		else // It will do this if the setting 'bRequiresFullLoad' is false.
		{
			if(bAltFire && LoadedShotCount >0) // checks wether it's an AltFire, and also if it has at least 1 rocket loaded.
			{
				FireSingle(C,true, true);
				FireCountdown = AltFireInterval;
			}
			else if(!bAltFire && LoadedShotCount >0) // checks wether it's not an AltFire, and also if it has at least 1 rocket loaded.
			{
				FireSingle(C,false, true);
				FireCountdown = FireInterval;
			}
		}
	}
// Now it will simply just fire constantly and without fail.

	else if(!bRequiresReloading) // It will do the below only if the setting 'bRequiresReloading' is false.
	{
		if(bAltFire)
		{
			FireSingle(C,true, false);
			FireCountdown = AltFireInterval;
		}
		else if(!bAltFire)
		{
			FireSingle(C,false, false);
			FireCountdown = FireInterval;
		}
	}
	return False;

}

// This cool function reloades the rockets, and is controlled by the 'LoadRate' and 'ReloadTime' variables.
simulated function Timer()
{
	if(LoadedShotCount >= MaxShotCount)
	{
		bReloaded=true;
	}

	else if(LoadedShotCount<=0)
		bReloaded=false;

	if (LoadedShotCount < MaxShotCount && !bReloaded)
	{
		LoadedShotCount += LoadRate;

		PlaySound(LoadSound,,LoadSoundVolume,,LoadSoundRadius);
		Instigator.MakeNoise(LoadSoundVolume);
	}

	if ( Bot(Instigator.Controller) != None )
		Vehicle(Instigator).Rise = 0;
}

//AI: return the best fire mode for the situation
function byte BestMode()
{
	if ( (Instigator.Controller == None) || (Instigator.Controller.Target == None) )
		return 1;
	if ( (Pawn(Instigator.Controller.Target) != None) && !Pawn(Instigator.Controller.Target).bStationary && (Instigator.Controller.Focus == Instigator.Controller.Target) )
		return 0;
	return 1;
}
// Here it actually fires the rockets and kills the number of rockets loaded everytime it fires a rocket.
simulated function FireSingle(Controller C, bool bAltFire, optional bool bKill)
{
	if (bAltFire && bKill) // If 'bkill' is activated and if it's an alt fire it will do the below.
	{
		AltFire(C);
		LoadedShotCount -= EjectRate; // Kills the number of rockets set by 'EjectRate'.
		PlaySound(EjectSound,,EjectSoundVolume,,EjectSoundRadius); // Plays the sound set by 'EjectSound' and also sets it's volume and radius.
		Instigator.MakeNoise(EjectSoundVolume);
	}
	else if (!bAltFire && bKill) // If 'bkill' is activated and if it's not an alt fire it will do the below.
	{
		Fire(C);
		LoadedShotCount -= EjectRate; // Kills the number of rockets set by 'EjectRate'.
		PlaySound(EjectSound,,EjectSoundVolume,,EjectSoundRadius); // Plays the sound set by 'EjectSound' and also sets it's volume and radius.
		Instigator.MakeNoise(EjectSoundVolume);
	}
	else if (bAltFire && !bKill) // If 'bkill' is deactivated and if it's an alt fire it will do the below.
	{
		AltFire(C);
		PlaySound(EjectSound,,EjectSoundVolume,,EjectSoundRadius); // Plays the sound set by 'EjectSound' and also sets it's volume and radius.
		Instigator.MakeNoise(EjectSoundVolume);
	}
	else if (!bAltFire && !bKill) // If 'bkill' is deactivated and if it's not an alt fire it will do the below.
	{
		Fire(C);
		PlaySound(EjectSound,,EjectSoundVolume,,EjectSoundRadius); // Plays the sound set by 'EjectSound' and also sets it's volume and radius.
		Instigator.MakeNoise(EjectSoundVolume);
	}
}

simulated function CalcWeaponFire()
{
    local coords WeaponBoneCoords;
    local vector CurrentFireOffset;

    // Calculate fire offset in world space
    WeaponBoneCoords = GetBoneCoords(WeaponFireAttachmentBone);
    CurrentFireOffset = (WeaponFireOffset * vect(1,0,0)) + (NewDualFireOffset * vect(0,1,0));

    // Calculate rotation of the gun
    WeaponFireRotation = rotator(vector(CurrentAim) >> Rotation);

    // Calculate exact fire location
    WeaponFireLocation = WeaponBoneCoords.Origin + (CurrentFireOffset >> WeaponFireRotation);

    // Adjust fire rotation taking dual offset into account
    if (bDualIndependantTargeting)
        WeaponFireRotation = rotator(CurrentHitLocation - WeaponFireLocation);
}

defaultproperties
{
     VelocitySpreadFactor=5000.000000
     MaxLockRange=18000.000000
     LockAim=0.875000
     LoadedShotCount=8
     MaxShotCount=8
     ReloadTime=2.000000
     bRequiresReloading=True
     bRequiresFullLoad=True
     LoadRate=2
     LoadSound=SoundGroup'BWBP_Vehicles_Sound.Cobra.CobraLoadRockets'
     LoadSoundVolume=255.000000
     LoadSoundRadius=15.000000
     EjectRate=1
     EjectSound=Sound'BWBP_Vehicles_Sound.Cobra.CobraEjectRocket'
     EjectSoundVolume=0.500000
     EjectSoundRadius=600.000000
     YawStartConstraint=-3000.000000
     YawEndConstraint=3000.000000
     PitchBone="KHMKIIRocketPack"
     PitchUpLimit=3000
     PitchDownLimit=55500
     WeaponFireAttachmentBone="FireBone"
     DualFireOffset=192.000000
     RotationsPerSecond=0.075000
     bDualIndependantTargeting=True
     Spread=0.035000
     FireInterval=0.750000
     AltFireInterval=0.400000
     FireSoundClass=Sound'BWBP_Vehicles_Sound.Effects.MissileLaunch'
     FireSoundVolume=1024.000000
     FireSoundRadius=100.000000
     FireSoundPitch=64.000000
     AltFireSoundClass=Sound'BWBP_Vehicles_Sound.Effects.MissileLaunch'
     AltFireSoundVolume=1024.000000
     AltFireSoundRadius=100.000000
     ProjectileClass=Class'BWBP_VPC_Pro.KHMKIITrackRocket'
     AltFireProjectileClass=Class'BWBP_VPC_Pro.KHMKIIRocket'
     AIInfo(0)=(bTrySplash=True,bLeadTarget=True,WarnTargetPct=0.750000,RefireRate=0.800000)
     CullDistance=7000.000000
     Mesh=SkeletalMesh'BWBP_Vehicles_Anim.KHMKIIRocketPack'
     ScaleGlow=0.750000
     bFullVolume=True
     CollisionRadius=0.000000
}
