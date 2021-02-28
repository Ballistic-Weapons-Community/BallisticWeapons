//=============================================================================
// Raygun Secondary Fire.
//
// Either a conventional charged shot or an irradiating shot.
//=============================================================================
class RaygunSecondaryFire extends BallisticProInstantFire;

var() Sound	ChargeSound;
var()	byte		ChargeSoundPitch;
var() float		ChargeTime, DecayCharge;

simulated function bool AllowFire()
{
	if (Raygun(BW).bShieldOn)
		return false;
	if (Raygun(BW).bLockSecondary)
		return false;
	return Super.AllowFire();
}

simulated function PlayStartHold()
{
	HoldTime = FMax(DecayCharge,0.1);
	
	Weapon.AmbientSound = ChargeSound;
	Weapon.ThirdPersonActor.AmbientSound = ChargeSound;
	
	Weapon.SoundVolume = 48 + FMin(ChargeTime, HoldTime)/ChargeTime * 128;
	Weapon.SoundPitch = ChargeSoundPitch + FMin(ChargeTime, HoldTime)/ChargeTime * ChargeSoundPitch;
	
	Weapon.ThirdPersonActor.SoundVolume = 48 + FMin(ChargeTime, HoldTime)/ChargeTime * 128;
	Weapon.ThirdPersonActor.SoundPitch = ChargeSoundPitch + FMin(ChargeTime, HoldTime)/ChargeTime * ChargeSoundPitch;
	//Abuse Channel 1 to dampen the animation if required.
	Raygun(BW).BlendFireHold();
	BW.bPreventReload=True;
	BW.SafeLoopAnim('ChargeLoop', 1.0, TweenTime, ,"IDLE");
}

simulated function ModeTick(float DeltaTime)
{
	Super.ModeTick(DeltaTime);
	
	if (bIsFiring)
	{
		Weapon.ThirdPersonActor.SoundVolume = 48 + FMin(ChargeTime, HoldTime)/ChargeTime * 128;
		Weapon.ThirdPersonActor.SoundPitch = ChargeSoundPitch + FMin(ChargeTime, HoldTime)/ChargeTime * ChargeSoundPitch;
		
		Weapon.SoundVolume = 48 + FMin(ChargeTime, HoldTime)/ChargeTime * 128;
		Weapon.SoundPitch = ChargeSoundPitch + FMin(ChargeTime, HoldTime)/ChargeTime * ChargeSoundPitch;
	}
	else if (DecayCharge > 0)
	{
		Weapon.ThirdPersonActor.SoundVolume = 48 + FMin(ChargeTime, DecayCharge)/ChargeTime * 128;
		Weapon.ThirdPersonActor.SoundPitch = ChargeSoundPitch + FMin(ChargeTime, DecayCharge)/ChargeTime * ChargeSoundPitch;
		
		Weapon.SoundVolume = 48 + FMin(ChargeTime, DecayCharge)/ChargeTime * 128;
		Weapon.SoundPitch = ChargeSoundPitch + FMin(ChargeTime, DecayCharge)/ChargeTime * ChargeSoundPitch;
		DecayCharge -= DeltaTime * 2.5;
		
		if (DecayCharge < 0)
		{
			DecayCharge = 0;
			Weapon.ThirdPersonActor.AmbientSound = None;
			Weapon.AmbientSound = None;
		}
	}
}

function bool AllowPlague(Actor Other)
{
	return 
		Pawn(Other) != None 
		&& Pawn(Other).Health > 0 
		&& Vehicle(Other) == None 
		&& (Pawn(Other).GetTeamNum() == 255 || Pawn(Other).GetTeamNum() != Instigator.GetTeamNum())
		&& Level.TimeSeconds - Pawn(Other).SpawnTime > DeathMatch(Level.Game).SpawnProtectionTime;
}

//===================================================
// ApplyDamage
//
// Irradiates struck targets
//===================================================
function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);

	if (Pawn(Target) != None && Pawn(Target).bProjTarget)
		TryPlague(Target);
}

function TryPlague(Actor Other)
{
	local RaygunPlagueEffect RPE;
	
	if (AllowPlague(Other))
	{
		foreach Other.BasedActors(class'RaygunPlagueEffect', RPE)
		{
			RPE.ExtendDuration(4);
		}
		if (RPE == None)
		{
			RPE = Spawn(class'RaygunPlagueEffect',Other,,Other.Location);// + vect(0,0,-30));
			RPE.Initialize(Other);
			if (Instigator!=None)
			{
				RPE.Instigator = Instigator;
				RPE.InstigatorController = Instigator.Controller;
			}
		}
	}
}

simulated event ModeDoFire()
{
	if (HoldTime >= ChargeTime || (Level.NetMode == NM_DedicatedServer && HoldTime >= ChargeTime - 0.1))
	{
		super.ModeDoFire();
		Raygun(BW).PassDelay(FireRate);
		Weapon.ThirdPersonActor.AmbientSound = None;
		Weapon.AmbientSound = None;
		DecayCharge = 0;
	}
	else
	{
		DecayCharge = FMin(ChargeTime, HoldTime);
		NextFireTime = Level.TimeSeconds + (DecayCharge * 0.35);
		//Blend out channel 1 manually, which we're using to dampen the charge animation.
		BW.AnimBlendParams(1, 0);
	}
		
	HoldTime = 0;
}

defaultproperties
{
    ChargeSound=Sound'IndoorAmbience.machinery18'
    ChargeSoundPitch=32
    ChargeTime=1.250000
    MuzzleFlashClass=Class'BWBP_OP_Pro.RaygunMuzzleFlash'
    FlashScaleFactor=4.000000
    AimedFireAnim="Fire"
    Damage=10
    MaxWaterTraceRange = 5000;
    FireRecoil=960.000000
    FireChaos=0.320000
    FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
    BallisticFireSound=(Sound=Sound'BWBP_OP_Sounds.Raygun.Raygun-FireBig',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
    bPawnRapidFireAnim=True
    bFireOnRelease=True
    MaxHoldTime=2.50000
    DamageType=Class'BWBP_OP_Pro.DTRaygunCharged'
    DamageTypeHead=Class'BWBP_OP_Pro.DTRaygunCharged'
    DamageTypeArm=Class'BWBP_OP_Pro.DTRaygunCharged'
    FireAnim="ChargedFire"
    FireEndAnim=
    FireRate=1.200000
    AmmoClass=Class'BWBP_OP_Pro.Ammo_RaygunCells'
    AmmoPerFire=8
    ShakeRotMag=(X=32.000000,Y=8.000000)
    ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
    ShakeRotTime=1.500000
    ShakeOffsetMag=(X=-3.000000)
    ShakeOffsetRate=(X=-1000.000000)
    ShakeOffsetTime=1.500000
    //ProjectileClass=Class'BWBP_OP_Pro.RaygunChargedProjectile'
    BotRefireRate=0.250000
    WarnTargetPct=0.500000
}
