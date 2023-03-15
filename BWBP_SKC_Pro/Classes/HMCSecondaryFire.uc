//=============================================================================
// E23PrimaryFire.
//
// Multi mode plasma fire for the E23
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class HMCSecondaryFire extends BallisticProInstantFire;

var   bool		bLaserFiring;
var   Actor		MuzzleFlashBeam;

var   Actor		MuzzleFlashBlue;
var   Actor		MuzzleFlashRed;
var int 		HealReductionMult;
var() sound		ChargeSound;
var() bool	bDoOverCharge;
//var() BUtil.FullSound	FireSoundLoop;
var() sound		FireSoundLoop;
var() sound		FireSoundLoopRed;
var   int SoundAdjust;
var   float		StopFireTime;
var   Emitter          LaserDot;

var Vector ZForce;

simulated function SwitchWeaponMode (byte NewMode)
{
	switch(NewMode)
	{
		case 0: GoToState(''); break;
		case 1: GoToState('RepulsorBeamMode'); break;
		case 2: GoToState('HealBeamMode'); break;
		default: GoToState('');
	}
}

function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
		local float				Dmg;
		local class<DamageType>	HitDT;
		local Actor				Victim;
		local Vector			RelativeVelocity, ForceDir;

		Dmg = GetDamage(Other, HitLocation, TraceStart, Dir, Victim, HitDT);
		if (RangeAtten != 1.0)
			Dmg *= Lerp(VSize(HitLocation-TraceStart)/TraceRange.Max, 1, RangeAtten);
		//if (WaterRangeAtten != 1.0 && WaterHitLocation != vect(0,0,0))
			//Dmg *= Lerp(VSize(HitLocation-WaterHitLocation) / (TraceRange.Max*WaterRangeFactor), 1, WaterRangeAtten);
		if (PenetrateCount > 0)
			Dmg *= PDamageFactor ** PenetrateCount;
		if (WallCount > 0)
			Dmg *= WallPDamageFactor ** WallCount;
		if (bUseRunningDamage)
		{
			RelativeVelocity = Instigator.Velocity - Other.Velocity;
			Dmg += Dmg * (VSize(RelativeVelocity) / RunningSpeedThresh) * (Normal(RelativeVelocity) Dot Normal(Other.Location-Instigator.Location));
		}
	
		if (HookStopFactor != 0 && HookPullForce != 0 && Pawn(Victim) != None && Pawn(Victim).bProjTarget && Pawn(Victim).DrivenVehicle == None && (Pawn(Victim).Controller == None || !Pawn(Victim).Controller.SameTeamAs(Instigator.Controller)))
		{
			ForceDir = Normal(Other.Location-TraceStart);
			if(Victim.Physics == PHYS_Falling)
			{
				ForceDir *= 0.3;
				Pawn(Victim).AddVelocity((ZForce * 0.25) + Normal(Victim.Acceleration) * HookStopFactor * -FMin(Pawn(Victim).GroundSpeed, VSize(Victim.Velocity)) - ForceDir* HookPullForce );
			}

			else Pawn(Victim).AddVelocity( ZForce + Normal(Victim.Acceleration) * HookStopFactor * -FMin(Pawn(Victim).GroundSpeed, VSize(Victim.Velocity)) - ForceDir * HookPullForce );
		}

		class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, KickForce * Dir, HitDT);
}

state RepulsorBeamMode
{
// This is called to DoDamage to an actor found by this fire.
// Adjsuts damage based on Range, Penetrates, WallPenetrates, relative velocities and runs Hurt() to do the deed...
function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
		local float				Dmg;
		local class<DamageType>	HitDT;
		local Actor				Victim;
		local Vector			RelativeVelocity, ForceDir;

		Dmg = GetDamage(Other, HitLocation, TraceStart, Dir, Victim, HitDT);
		if (RangeAtten != 1.0)
			Dmg *= Lerp(VSize(HitLocation-TraceStart)/TraceRange.Max, 1, RangeAtten);
		//if (WaterRangeAtten != 1.0 && WaterHitLocation != vect(0,0,0))
			//Dmg *= Lerp(VSize(HitLocation-WaterHitLocation) / (TraceRange.Max*WaterRangeFactor), 1, WaterRangeAtten);
		if (PenetrateCount > 0)
			Dmg *= PDamageFactor ** PenetrateCount;
		if (WallCount > 0)
			Dmg *= WallPDamageFactor ** WallCount;
		if (bUseRunningDamage)
		{
			RelativeVelocity = Instigator.Velocity - Other.Velocity;
			Dmg += Dmg * (VSize(RelativeVelocity) / RunningSpeedThresh) * (Normal(RelativeVelocity) Dot Normal(Other.Location-Instigator.Location));
		}
	
		if (HookStopFactor != 0 && HookPullForce != 0 && Pawn(Victim) != None && Pawn(Victim).bProjTarget && Pawn(Victim).DrivenVehicle == None && (Pawn(Victim).Controller == None || !Pawn(Victim).Controller.SameTeamAs(Instigator.Controller)))
		{
			ForceDir = Normal(TraceStart-Other.Location);
			if(Victim.Physics == PHYS_Falling)
			{
				ForceDir *= 0.3;
				Pawn(Victim).AddVelocity((ZForce * 0.25) +Normal(Victim.Acceleration) * HookStopFactor * -FMin(Pawn(Victim).GroundSpeed, VSize(Victim.Velocity)) - ForceDir * HookPullForce );
			}

			else Pawn(Victim).AddVelocity( ZForce +  Normal(Victim.Acceleration) * HookStopFactor * -FMin(Pawn(Victim).GroundSpeed, VSize(Victim.Velocity)) - ForceDir * HookPullForce );
		}

		class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, KickForce * Dir, HitDT);
	//	Victim.TakeDamage(Dmg, Instigator, HitLocation, KickForce * Dir, HitDT);
	}
}

state HealBeamMode
{
// This is called to DoDamage to an actor found by this fire.
// Adjsuts damage based on Range, Penetrates, WallPenetrates, relative velocities and runs Hurt() to do the deed...
function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
		local float				Dmg;
		local class<DamageType>	HitDT;
		local Actor				Victim;
		local Pawn 			HealTarget;

		Dmg = GetDamage(Other, HitLocation, TraceStart, Dir, Victim, HitDT);

		HealTarget = Pawn(Other);
			//bProjTarget is set False when a pawn is frozen in Freon.
			if ( HealTarget != None && HealTarget.PlayerReplicationInfo != None && HealTarget.PlayerReplicationInfo.Team == Instigator.PlayerReplicationInfo.Team)
			{
				if (BallisticPawn(Other) != None)
					BallisticPawn(HealTarget).GiveAttributedHealth(Dmg/HealReductionMult, HealTarget.SuperHealthMax, Instigator);
				else HealTarget.GiveHealth(Dmg/HealReductionMult, HealTarget.SuperHealthMax);
				return;
			}

			class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, KickForce * Dir, HitDT);
	}
}

function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if (MuzzleFlashBlue == None || MuzzleFlashBlue.bDeleteMe )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashBlue, class'HMCFlashEmitter', Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if (MuzzleFlashRed == None || MuzzleFlashRed.bDeleteMe )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashRed, class'HMCRedEmitter', Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
	MuzzleFlash = MuzzleFlashBlue;
}

// Remove effects
simulated function DestroyEffects()
{
	Super(WeaponFire).DestroyEffects();
}

simulated function bool AllowFire()
{
	if ((HMCBeamCannon(Weapon).Heat >= 1.0) || HMCBeamCannon(Weapon).bIsCharging || !super.AllowFire())
	{
		if (bLaserFiring)
			PlayFireEnd();
		return false;
	}
	return super.AllowFire();
}

function PlayFireEnd()
{
	if (bLaserFiring || bIsFiring)
	{
		super.PlayFireEnd();
		super.StopFiring();
	}
	StopFiring();
}


simulated function SpawnLaserDot(vector Loc)
{
     if (LaserDot == None)
	{
	  	if ( (Instigator.PlayerReplicationInfo.Team != None) && (Instigator.PlayerReplicationInfo.Team.TeamIndex == 0) || HMCBeamCannon(BW).bRedTeam )
			LaserDot = Spawn(class'BallisticProV55.IE_GRS9LaserHit',,,Loc);
		else
          	LaserDot = Spawn(class'BWBP_SKC_Pro.IE_HMCLase',,,Loc);
	}
}

function DoFireEffect()
{
	HMCBeamCannon(Weapon).ServerSwitchLaser(true);
	
	if ( (Instigator.PlayerReplicationInfo.Team != None) && (Instigator.PlayerReplicationInfo.Team.TeamIndex == 0) || HMCBeamCannon(BW).bRedTeam )
		Instigator.AmbientSound = FireSoundLoopRed;
	else
		Instigator.AmbientSound = FireSoundLoop;
	
	if (level.Netmode == NM_DedicatedServer)
		HMCBeamCannon(BW).AddHeat(0.02);

	super.DoFireEffect();
}

function PlayFiring()
{
	HMCBeamCannon(BW).AddHeat(0.02);
		
	ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;

	bLaserFiring=true;
}

function ServerPlayFiring()
{
	if (FireSoundLoop != None && !bLaserFiring)
		Instigator.AmbientSound = FireSoundLoop;
	bLaserFiring=true;
}

function StopFiring()
{
	HMCBeamCannon(Weapon).ServerSwitchLaser(false);
	StopFireTime = level.TimeSeconds;
	super.StopFiring();
	bLaserFiring=false;
	
	if (MuzzleFlash != None)
		MuzzleFlash = None;	

	Instigator.AmbientSound = BW.UsedAmbientSound;
	Instigator.SoundVolume = Instigator.default.SoundVolume;
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
	if (HMCBeamCannon(Weapon).Heat >= 1.1)
	{
		NextFireTime = Level.TimeSeconds + 1.5;
		DoJam();
		BW.ClientJamMode(1);
	}
	
    BallisticFireSound.Sound = None;
    BallisticFireSound.Volume=0.7;
    BallisticFireSound.Radius=280.0;
    
	super.ModeDoFire();
}

simulated event ModeTick(float DT)
{
	if (HMCBeamCannon(Weapon).Heat > 1.0)
	{
		HMCBeamCannon(Weapon).ClientOverCharge();
		HMCBeamCannon(Weapon).ServerStopFire(1);
		DoJam();
		BW.ClientJamMode(1);
	}
	if ( (Instigator.PlayerReplicationInfo.Team != None) && (Instigator.PlayerReplicationInfo.Team.TeamIndex == 0) || HMCBeamCannon(BW).bRedTeam )
		MuzzleFlash = MuzzleFlashRed;
	else
		MuzzleFlash = MuzzleFlashBlue;
		
	super.ModeTick(DT);
	
	if (!bIsFiring)
		return;
		
	if (Instigator.PhysicsVolume.bWaterVolume)
		HMCBeamCannon(Weapon).AddHeat(DT*8);

}

simulated function ModeHoldFire()
{
	Instigator.SoundVolume = 255;
	Instigator.SoundRadius = 280;
	Super.ModeHoldFire();
}

defaultproperties
{
     HealReductionMult=2
     ChargeSound=Sound'BWBP_SKC_SoundsExp.BeamCannon.Beam-Loop'
     FireSoundLoop=Sound'BWBP_SKC_SoundsExp.BeamCannon.Beam-Loop'
     FireSoundLoopRed=Sound'BWBP_SKC_SoundsExp.BeamCannon.RedBeam-Loop'
     ZForce=(Z=225.000000)
     TraceRange=(Min=6000.000000,Max=6000.000000)
     Damage=6.000000
     RangeAtten=0.750000
     WaterRangeAtten=0.600000
     DamageType=Class'BWBP_SKC_Pro.DTHMCBeam'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTHMCBeamHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTHMCBeam'
     HookStopFactor=0.300000
     HookPullForce=240.000000
     PenetrateForce=200
     bPenetrate=True
     MuzzleFlashClass=Class'BWBP_SKC_Pro.HMCFlashEmitter'
     FlashScaleFactor=0.700000
     FireChaos=0.000000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Volume=1.200000,Radius=255.000000,Slot=SLOT_Interact,bNoOverride=False)
     UnjamMethod=UJM_Fire
     bModeExclusive=False
     FireAnim="FireLoop"
     FireEndAnim=
     FireRate=0.080000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_HVPCCells'
     BotRefireRate=0.999000
     WarnTargetPct=0.010000
     aimerror=400.000000
}
