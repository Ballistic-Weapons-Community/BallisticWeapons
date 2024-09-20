class ParticleStreamSecondaryFire extends BallisticInstantFire;
var   ParticleStreamer			ProtonGun;	
var Actor LockedTarget;

var   Actor						MuzzleFlashFast;
var   Actor						MuzzleFlashSlow;
var   Actor						LightMuzzleFlash;

var() sound		FireSoundLoop;
var() sound		FireSound2;
var   bool		bIsZapping;

var   bool	bPendingOwnerZap;
var   float	PendingZapDamage;

var   bool			bChainZapping;

var   bool			bPowerDrain;
var		bool	bShouldUseAltColor;
var		bool	bNoUseAmmo;

struct ChainVic
{
	var float	ZapTime;
	var actor	ZapVic;
};
var   array<ChainVic>	ChainVics;

simulated function FiremodeChanged(byte NewMode)
{
	if(NewMode == 1)
		bPowerDrain=True;
	else
		bPowerDrain=False;
}	

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	ProtonGun = ParticleStreamer(Weapon);
}

function EndState()
{
	if (bIsZapping)
		StopLightning();
}

function float MaxRange()
{
	return ProtonGun.MaxStreamRange;
}

function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
	MuzzleFlash = MuzzleFlashSlow;
}

// ModeDoFire from WeaponFire.uc, but with a few changes
simulated event ModeDoFire()
{
if (!AllowFire())
		return;

	BW.FireCount++;

	// server
	if (Weapon.Role == ROLE_Authority)
	{
		ConsumedLoad += Load;
		SetTimer(FMin(0.1, FireRate/2), false);
		DoFireEffect();
		if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
		if ( AIController(Instigator.Controller) != None )
			AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
		Instigator.DeactivateSpawnProtection();
	}

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

	NextFireTime += FireRate;
	NextFireTime = FMax(NextFireTime, Level.TimeSeconds);

	Load = AmmoPerFire;
	HoldTime = 0;
	
	if (bNoUseAmmo)
		Load = 0;
	
	if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
	{
		bIsFiring = false;
		Weapon.PutDown();
	}
}

function DoFireEffect()
{
	local Actor Target, Victims, Other;
	local float TargetAngle, DR; //BHD
	local vector ForceDir, EndEffect;
	
  //local Rotator AimDir;
	local Vector HitLocation, HitNormal;
  //local DestroyableObjective HealObjective;
  //local Vehicle HealVehicle;
  //local int AdjustedDamage;
	local bool bWasAlive, bDidHeal;
  //local RSBlackHole BH;

		if (ParticleStreamAttachment(Weapon.ThirdPersonActor).StreamEffect == None)
	{
		ParticleStreamAttachment(Weapon.ThirdPersonActor).bUseAlt=True;	
		ParticleStreamAttachment(Weapon.ThirdPersonActor).StartStream();
	}
	ParticleStreamAttachment(Weapon.ThirdPersonActor).bUseAltColor=bShouldUseAltColor;
	bIsZapping=true;
	bNoUseAmmo=false;
	
	if (!bAISilent)
		Instigator.MakeNoise(1.0);

	TargetAngle = 0.92;
	foreach Instigator.VisibleCollidingActors( class 'Actor', Victims, 700, Instigator.Location )
	{
		if ( Victims != None && Victims != Instigator && Victims.Role == ROLE_Authority && !Victims.IsA('FluidSurfaceInfo') &&
			!Victims.bWorldGeometry && Victims.bCanBeDamaged &&
			(!Victims.PhysicsVolume.bWaterVolume || (Pawn(Victims)!=None && !Pawn(Victims).HeadVolume.bWaterVolume)) )
		{
			DR = Normal(Victims.Location - Instigator.Location) Dot vector(Instigator.GetViewRotation());
			if (DR > TargetAngle)
			{
				Target = Victims;
				TargetAngle = DR;
			}
			
		}
	}
	if (Target != None)
	{
		LockedTarget = Target;
		ParticleStreamAttachment(Weapon.ThirdPersonActor).SetLockedTarget(Target);

		if (Pawn(Target) != None && Instigator.Controller.SameTeamAs(Pawn(Target).Controller))
		{
			bDidHeal=True;
			return;
		}

		if (xPawn(Target) != None && Pawn(Target).Health > 0)
		{
			if (Monster(Target) == None || Pawn(Target).default.Health > 100)
				bWasAlive = true;
		}
		else if (Vehicle(Target) != None && Vehicle(Target).Driver!=None && Vehicle(Target).Driver.Health > 0)
			bWasAlive = true;
		ForceDir = (Instigator.Location + vector(Instigator.GetViewRotation()) * 700) - Target.Location;
		if (bDidHeal)
		{
			//class'BallisticDamageType'.static.GenericHurt (Target, 0, Instigator, Target.Location + (Normal(Target.Location - Instigator.Location))*-24, 10000 * FMax(0.1, 1-(VSize(ForceDir)/2000)) * Normal(ForceDir), class'DTProtonStreamer');
			ParticleStreamer(BW).BoostTarget = Pawn(Other);
			bShouldUseAltColor=true;
		}
		else
		{
			//class'BallisticDamageType'.static.GenericHurt (Target, Damage, Instigator, Target.Location + (Normal(Target.Location - Instigator.Location))*-24, 30000 * FMax(0.1, 1-(VSize(ForceDir)/2000)) * Normal(ForceDir), class'DTProtonStreamer');
			ParticleStreamer(BW).DrainTarget = Pawn(Other);
			bShouldUseAltColor=false;
		}
		/*if (bWasAlive && Pawn(Target).Health <= 0)
			class'RSNovaSoul'.static.SpawnSoul(Target.Location, Instigator, Pawn(Target), Weapon);

		NovaStaff.SetTargetZap(Target, false);*/
	}
	else 
	{
		EndEffect = Instigator.Location + Normal(Vector(Instigator.GetViewRotation())) * ProtonGun.MaxStreamRange;
		Trace(HitLocation,HitNormal,EndEffect,Instigator.Location,true);
		if (VSize(Instigator.Location - EndEffect) < ProtonGun.MaxStreamRange)
			EndEffect = HitLocation;
		ParticleStreamAttachment(Weapon.ThirdPersonActor).SetLockedTarget(None);
		ParticleStreamAttachment(Weapon.ThirdPersonActor).SetUnlockedEnd(EndEffect);
	}/*ParticleStreamAttachment(Weapon.ThirdPersonActor).EndStream();	*/
}

simulated function bool AllowFire()
{
	if (!super.AllowFire() || Instigator.PhysicsVolume.bWaterVolume)
	{
		if (bIsZapping)
		{
			PlayFireEnd();
		}
		return false;
	}
	if (BW.MagAmmo < AmmoPerFire || ParticleStreamer(BW).bShieldOn)
		return false;
	return true;
}

function ServerPlayFiring()
{
	if (BW.FireCount < 2)
	{
		if (BallisticFireSound.Sound != None)
			Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	if (FireSoundLoop != None)
	{
		Instigator.AmbientSound = FireSoundLoop;
		Instigator.SoundVolume = 255;
	}
}

function PlayFiring()
{
	if (Instigator.PhysicsVolume.bWaterVolume)
	{
		StopLightning();
		super.PlayFireEnd();
		if (Weapon.HasAnim(FireLoopAnim))
			BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		NextFireTime+=2.0;
		return;
	}
	if (FireCount < 1)
	{
		if (Weapon.HasAnim(FireLoopAnim))
			BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		if (BallisticFireSound.Sound != None)
			Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	else if (FireCount == Max(1, level.TimeDilation * 5.0))
		Weapon.PlayOwnedSound(FireSound2,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	ClientPlayForceFeedback(FireForce);  // jdf
	FireCount++;

	if (level.NetMode == NM_Client)
	{
		bIsZapping=true;
	}

	if (LightMuzzleFlash == None || LightMuzzleFlash.bDeleteMe)
		class'BUtil'.static.InitMuzzleFlash (LightMuzzleFlash, class'BWBP_APC_Pro.ParticleFlashEmitter', Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);

	if (FireSoundLoop != None)
	{
		Instigator.AmbientSound = FireSoundLoop;
		Instigator.SoundVolume = 255;
	}
}

function PlayFireEnd()
{
	if (bIsZapping)
		super.PlayFireEnd();
	StopLightning();
	ParticleStreamAttachment(Weapon.ThirdPersonActor).EndStream();
}

function StopFiring()
{
	super.StopFiring();
	ParticleStreamer(BW).DrainTarget = None;
	ParticleStreamer(BW).BoostTarget = None;
	StopLightning();
	if (Instigator.Role == ROLE_Authority)
		ParticleStreamAttachment(Weapon.ThirdPersonActor).EndStream();	
}

function StopLightning()
{
	bIsZapping=false;
	if (LightMuzzleFlash != None)
	{	Emitter(LightMuzzleFlash).Kill();	LightMuzzleFlash = None;	}
	Instigator.AmbientSound = BW.UsedAmbientSound;
	Instigator.SoundVolume = Weapon.default.SoundVolume;
}

function FlashMuzzleFlash();

defaultproperties
{
     DamageType=Class'BWBP_OP_Pro.DTProtonStreamer'
     MuzzleFlashClass=Class'BWBP_APC_Pro.ParticleFlashEmitter'
     FireRecoil=1.000000
     bPawnRapidFireAnim=True
     FireAnim="FireLoop"
     FireRate=0.070000
     AmmoClass=Class'BWBP_OP_Pro.Ammo_ProtonCharge'
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     WarnTargetPct=0.200000
}
