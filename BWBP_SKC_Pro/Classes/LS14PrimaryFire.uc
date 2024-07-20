//=============================================================================
// LS-14 Primary Fire.
//
// Laser weapon with overheating mechanism. Deals more damage the lower the weapon's heat level is.
// Does not cut out if maximum heat is reached.
//
// Azarael note: This is pretty bright. Maybe use this elsewhere
//=============================================================================
class LS14PrimaryFire extends BallisticProInstantFire;

var() Actor			MuzzleFlash2;		// The muzzleflash actor
var   bool			bSecondBarrel;
var   bool			bIsDouble;
var		bool		bAnimatedOverheat; //overheat plays special anims

var() sound		FireSoundLoop;
var() sound		FireSoundLoopRapid;
var() sound		SpinUpSound;
var() sound		SpinDownSound;
var   float		StopFireTime;
var   bool		bLaserFiring;
var   bool 		bPreventFire;	//prevent fire/recharging when laser is cooling

var 	float 		SelfHeatPerShot, SelfHeatPerShotDouble, SelfHeatDeclineDelay;

simulated function bool AllowFire()
{
	if ((LS14Carbine(Weapon).SelfHeatLevel >= 10) || !super.AllowFire())
		return false;
	return true;
}

function PlayFiring()
{
	Super.PlayFiring();
	LS14Carbine(BW).AddHeat(SelfHeatPerShot, 0, SelfHeatDeclineDelay);
}

// Get aim then run trace...
function DoFireEffect()
{
	Super.DoFireEffect();
	if (Level.NetMode == NM_DedicatedServer)
		LS14Carbine(BW).AddHeat(SelfHeatPerShot, 0, SelfHeatDeclineDelay);
}

function InitEffects()
{
	super.InitEffects();
    if ((MuzzleFlashClass != None) && ((MuzzleFlash2 == None) || MuzzleFlash2.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash2, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, 'tip2');
}
	// Charge Beam Code
simulated state GatlingLaser
{

	simulated function PlayPreFire()
	{    
		//if (!bLaserFiring)
			Weapon.PlayOwnedSound(SpinUpSound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

		//Instigator.AmbientSound = SpinUpSound;
		Instigator.SoundVolume = 255;
		super.PlayPreFire();
	}

	//Intent is for the laser to begin firing once it has spooled up
	simulated event ModeDoFire()
	{
		if (!AllowFire())
			return;
		if (LS14Carbine(BW).bRapid && LS14Carbine(BW).LaserCharge < LS14Carbine(BW).MaxCharge || bPreventFire)
			return;
		super.ModeDoFire();
	}

	simulated function ModeTick(float DT)
	{
		if (LS14Carbine(BW).bRapid)
		{
			if (bIsFiring && !bPreventFire && BW.MagAmmo > 0)
				LS14Carbine(BW).SetLaserCharge(FMin(LS14Carbine(BW).LaserCharge + LS14Carbine(BW).ChargeRate * DT * (1 + 2*int(BW.bBerserk)), LS14Carbine(BW).MaxCharge));
			else if (LS14Carbine(BW).LaserCharge > 0)
			{
				if (level.TimeSeconds > StopFireTime)
					StopFiring();
					
				bPreventFire=true;
				LS14Carbine(BW).SetLaserCharge(FMax(0.0, LS14Carbine(BW).LaserCharge - LS14Carbine(BW).CoolRate * DT * (1 + 2*int(BW.bBerserk))));
				
				if (LS14Carbine(BW).LaserCharge <= 0)
					bPreventFire=false;
			}
		}
		Super.ModeTick(DT);
	}
	
	//Server fire
	function DoFireEffect()
	{
		bLaserFiring=true;
		super.DoFireEffect();
	}

	//Client fire
	function PlayFiring()
	{
		super.PlayFiring();
		if (FireSoundLoopRapid != None && LS14Carbine(BW).bRapid)
		{
			Instigator.AmbientSound = FireSoundLoopRapid;
			Instigator.SoundVolume = 255;
		}
		else if (FireSoundLoop != None)
		{
			Instigator.AmbientSound = FireSoundLoop;
			Instigator.SoundVolume = 255;
		}
		bLaserFiring=true;
	}

	//Server fire
	function ServerPlayFiring()
	{
		super.ServerPlayFiring();
		if (FireSoundLoopRapid != None && LS14Carbine(BW).bRapid)
		{
			Instigator.AmbientSound = FireSoundLoopRapid;
			Instigator.SoundVolume = 255;
		}
		else if (FireSoundLoop != None)
		{
			Instigator.AmbientSound = FireSoundLoop;
			Instigator.SoundVolume = 255;
		}
		bLaserFiring=true;
	}

	function StopFiring()
	{
		if (bLaserFiring)
			Weapon.PlayOwnedSound(SpinDownSound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

		Instigator.AmbientSound = LS14Carbine(BW).UsedAmbientSound;
		Instigator.SoundVolume = Instigator.Default.SoundVolume;
		bLaserFiring=false;
		StopFireTime = level.TimeSeconds;
	}	
}


simulated function SwitchWeaponMode (byte NewMode)
{
	Super.SwitchWeaponMode(NewMode);
	
	if (NewMode == 0)
	{
		bIsDouble=false;
		SelfHeatPerShot=default.SelfHeatPerShot;
		SelfHeatDeclineDelay=default.SelfHeatDeclineDelay;
	}
	
	else
	{
		bIsDouble=true;
		SelfHeatPerShot=default.SelfHeatPerShotDouble;
		SelfHeatDeclineDelay=default.SelfHeatDeclineDelay*2;
	}
}

//The LS-14 deals increased damage to targets which have already been heated up by a previous strike.
function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{	
	if (Pawn(Target) != None && Pawn(Target).bProjTarget)
		Damage += LS14Carbine(BW).ManageHeatInteraction(Pawn(Target), HeatPerShot);
	
	super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
}

simulated event ModeDoFire()
{
	if (AllowFire() && !LS14Carbine(Weapon).bIsReloadingGrenade)
	{
		//[2.5] Classic Heat Anims
		if (bAnimatedOverheat)
		{
			if (LS14Carbine(Weapon).SelfHeatLevel >= 8.5)
				FireAnim='Overheat';
			else if (bIsDouble && LS14Carbine(Weapon).SelfHeatLevel >= 6.5)
				FireAnim='FiddleOne';
			else if ((LS14Carbine(Weapon).SelfHeatLevel > 6.5 && LS14Carbine(Weapon).SelfHeatLevel < 8.5) || bIsDouble)
				FireAnim='FireBig';
			else
				FireAnim='Fire';
		}
		else
		{
			if (bIsDouble)
				FireAnim='FireBig';
			else
				FireAnim='Fire';
		}

		AimedFireAnim = FireAnim;

		if (!bSecondBarrel)
		{
			bSecondBarrel=true;
			LS14Carbine(Weapon).bBarrelsOnline=true;
		}
		else
		{
			bSecondBarrel=false;
			LS14Carbine(Weapon).bBarrelsOnline=false;
		}
		
		super.ModeDoFire();	
	}
	
	if (LS14Carbine(Weapon).bIsReloadingGrenade)
		LS14Carbine(Weapon).bWantsToShoot=true;
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
	local Coords C;
	local vector Start, X, Y, Z;

    	if ((Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;

    	if ((bIsDouble) && MuzzleFlash2 !=None && MuzzleFlash != None)
	{
        	MuzzleFlash2.Trigger(Weapon, Instigator);
        	MuzzleFlash.Trigger(Weapon, Instigator);
	}

    	if (bSecondBarrel && MuzzleFlash2 != None) //Checks to alternate
    	{
		C = Weapon.GetBoneCoords('tip2');
        	MuzzleFlash2.Trigger(Weapon, Instigator);
    	}
    	else if (MuzzleFlash != None)
    	{
		C = Weapon.GetBoneCoords('tip');
        	MuzzleFlash.Trigger(Weapon, Instigator);
    	}

    	if (!class'BallisticMod'.default.bMuzzleSmoke)
    		return;
    	Weapon.GetViewAxes(X,Y,Z);
	Start = C.Origin + X * -180 + Y * 3;
}

defaultproperties
{
	FireSoundLoop=Sound'BWBP_SKC_Sounds.LS440.LS440-FireLoop'
	FireSoundLoopRapid=Sound'BWBP_SKC_Sounds.LS440.LS440-FireLoopRapid'
	SpinUpSound=Sound'BWBP_SKC_Sounds.LS440.LS440-SpinUp'
	SpinDownSound=Sound'BWBP_SKC_Sounds.LS440.LS440-SpinDown'
	SelfHeatPerShot=0.600000
	SelfHeatPerShotDouble=1.500000
	SelfHeatDeclineDelay=0.5
	bAnimatedOverheat=False
	TraceRange=(Min=30000.000000,Max=30000.000000)
	DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
	DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
	DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
	PenetrateForce=500
	bPenetrate=True
	ClipFinishSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-LastShot',Volume=1.000000,Radius=48.000000,bAtten=True)
	DryFireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-Empty',Volume=1.200000)
	MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
	FlashScaleFactor=0.400000
	FireRecoil=150.000000
	FireChaos=0.300000
	BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.LS14.Gauss-Fire',Volume=0.900000)
	FireEndAnim=
	FireRate=0.150000
	AmmoClass=Class'BWBP_SKC_Pro.Ammo_Laser'
PreFireAnim="Fire"
	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-3.00)
	ShakeOffsetRate=(X=-60.000000)
	ShakeOffsetTime=2.000000

	BotRefireRate=0.99
	WarnTargetPct=0.30000
	aimerror=800.000000
}
