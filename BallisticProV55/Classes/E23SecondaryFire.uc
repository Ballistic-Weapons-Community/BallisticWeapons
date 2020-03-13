//=============================================================================
// E23 Secondary Fire
//
// Laser
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class E23SecondaryFire extends BallisticProInstantFire;

var   	bool		bLaserFiring;
var	Actor		MuzzleFlashBeam;
var	Sound	FireSoundLoop;
var byte		SuccessiveHits;

// Remove effects
simulated function DestroyEffects()
{
	Super(WeaponFire).DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlashBeam);
}

simulated function bool AllowFire()
{
	if (!super.AllowFire())
	{
		if (bLaserFiring)
			StopFiring();
		return false;
	}
	return true;
}

simulated function bool CheckWeaponMode()
{
	return true;
}

function DoFireEffect()
{
	E23PlasmaRifle(Weapon).SwitchLaser(true);
	super.DoFireEffect();
}

function LaserDoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir)
{
	local float				Dmg;
	local class<DamageType>	HitDT;
	local Actor				Victim;
	local Vector			BoneTestLocation, ClosestLocation;
	local DestroyableObjective HealObjective;
	local Vehicle HealVehicle;
	local int AdjustedDamage;
	
	//Locational damage code from Mr Evil under test here
	if(Other.IsA('xPawn'))
	{
		//Find a point on the victim's Z axis at the same height as the HitLocation.
		ClosestLocation = Other.Location;
		ClosestLocation.Z += (HitLocation - Other.Location).Z;
		
		//Extend the shot along its direction to a point where it is closest to the victim's Z axis.
		BoneTestLocation = Dir;
		BoneTestLocation *= VSize(ClosestLocation - HitLocation);
		BoneTestLocation *= normal(ClosestLocation - HitLocation) dot normal(HitLocation - TraceStart);
		BoneTestLocation += HitLocation;
		
		Dmg = GetDamage(Other, BoneTestLocation, Dir, Victim, HitDT);
	}
	
	else Dmg = GetDamage(Other, HitLocation, Dir, Victim, HitDT);
	//End locational damage code test

	if (Instigator != None)
	{
		AdjustedDamage = Dmg * Instigator.DamageScaling * DamageType.default.VehicleDamageScaling;
		if (Instigator.HasUDamage())
			AdjustedDamage *= 2;
	}

	HealObjective = DestroyableObjective(Other);
	if ( HealObjective == None )
		HealObjective = DestroyableObjective(Other.Owner);
	if ( HealObjective != None && HealObjective.TeamLink(Instigator.GetTeamNum()) )
	{
		HealObjective.HealDamage(AdjustedDamage, Instigator.Controller, HitDT);
		return;
	}

	HealVehicle = Vehicle(Other);
	if ( HealVehicle != None && HealVehicle.TeamLink(Instigator.GetTeamNum()) )
	{
		HealVehicle.HealDamage(AdjustedDamage, Instigator.Controller, HitDT);
		return;
	}

	class'BallisticDamageType'.static.GenericHurt (Victim, FMin(Dmg + SuccessiveHits, 16), Instigator, HitLocation, KickForce * Dir, HitDT);
}

function DoTrace (Vector InitialStart, Rotator Dir)
{
	local Vector					End, X, HitLocation, HitNormal, Start, LastHitLoc;
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
				LaserDoDamage (Other, HitLocation, InitialStart, X);
				
				if (Pawn(Other) != None)
					++SuccessiveHits;
				
				if (Vehicle(Other) != None)
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other);
				
				else if (Mover(Other) == None)
				{
					bHitWall = true;
					SendFireEffect(Other, HitLocation, HitNormal, HitMaterial.SurfaceType);
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
    ClientPlayForceFeedback(FireForce);  // jdf
	FireCount++;

	CheckClipFinished();

	if (!bLaserFiring)
	{
		if (FireSoundLoop != None)
			Instigator.AmbientSound = FireSoundLoop;
			Instigator.SoundVolume = 255;
			Instigator.SoundRadius = 280;
		if (MuzzleFlashBeam == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlashBeam, class'E23LaserFlashEmitter', Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
		bLaserFiring=true;
	}
}

function ServerPlayFiring()
{
	CheckClipFinished();

	if (FireSoundLoop != None && !bLaserFiring)
	{
		Instigator.SoundVolume = 255;
		Instigator.SoundRadius = 280;
		Instigator.AmbientSound = FireSoundLoop;
		bLaserFiring=true;
	}
}

function StopFiring()
{
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashBeam);
	MuzzleFlashBeam=None;
	E23PlasmaRifle(Weapon).SwitchLaser(false);
	bLaserFiring=false;
	Instigator.AmbientSound = None;
	Instigator.SoundVolume = Instigator.default.SoundVolume;
	Instigator.SoundRadius = Instigator.default.SoundRadius;
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, true, WaterHitLoc);
}

defaultproperties
{
     FireSoundLoop=Sound'BWBP4-Sounds.VPR.VPR-LaserLoop'
     TraceRange=(Min=10000.000000,Max=10000.000000)
     Damage=10.000000
     DamageHead=15.000000
     DamageLimb=10.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DTVPRLaser'
     DamageTypeHead=Class'BallisticProV55.DTVPRLaserHead'
     DamageTypeArm=Class'BallisticProV55.DTVPRLaser'
     PenetrateForce=200
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticProV55.E23FlashEmitter'
     FlashScaleFactor=0.750000
     FireChaos=0.010000
     BallisticFireSound=(Sound=Sound'BWBP4-Sounds.VPR.VPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireAnim=
     FireLoopAnim="'"
     FireEndAnim=
     FireRate=0.085000
     AmmoClass=Class'BallisticProV55.Ammo_E23Cells'
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.99
     WarnTargetPct=0.2
}
