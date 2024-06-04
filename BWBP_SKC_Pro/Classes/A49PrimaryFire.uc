//=============================================================================
// A49 Skrith Blaster Primary.
//
// Craps out deadly projectiles.
//=============================================================================
class A49PrimaryFire extends BallisticProProjectileFire;

var() bool 	bChargable;
var() float ChargeRate;
var() int 	MaxChargeLevel;
var() int 	ChargeLevel;
var() int 	ChargeIncrement;
var()   sound	ChargeSound;
var()   sound	ChargeLoopSound;

var	bool  	bVariableHeatProps; //Gun heat changes accuracy and RoF
var float 	StopFireTime;

simulated function bool AllowFire()
{
	if ((A49SkrithBlaster(Weapon).HeatLevel >= 10) || !super.AllowFire())
		return false;
	return true;
}

simulated state ChargeFire
{
	simulated function ApplyFireEffectParams(FireEffectParams effect_params)
	{
		super(BallisticProProjectileFire).ApplyFireEffectParams(effect_params);
		bFireOnRelease=true;
		bModeExclusive=true;
		bChargable=true;
		ChargeIncrement = AmmoPerFire;
		
		if (bFireOnRelease)
			bWaitForRelease = true;

		if (bWaitForRelease)
			bNowWaiting = true;
	}

	function ModeHoldFire()
	{
		if ( BW.MagAmmo > ChargeIncrement )
		{
			Super.ModeHoldFire();
			GotoState('Hold');
		}
	}
	
}

state Hold
{
    simulated function BeginState()
    {
        ChargeLevel = 0;
        SetTimer(ChargeRate, true);
		Instigator.AmbientSound = ChargeSound;
        //Weapon.PlayOwnedSound(ChargeSound,SLOT_Interact,TransientSoundVolume,false);
        //Timer();
    }

    simulated function Timer()
    {
		if ( BW.MagAmmo > ChargeIncrement )
		{
			ChargeLevel++;
			BW.ConsumeMagAmmo(ThisModeNum, ChargeIncrement);
		}
		A49SkrithBlaster(BW).SetGlowSize(ChargeLevel/float(MaxChargeLevel));
        if (ChargeLevel == MaxChargeLevel || BW.AmmoAmount(ThisModeNum) < ChargeIncrement)
        {
            SetTimer(0.0, false);
			Instigator.AmbientSound = ChargeLoopSound;
			Instigator.SoundPitch = 150;
			Instigator.SoundRadius = 50;
			Instigator.SoundVolume = 250;
        }
    }

    simulated function EndState()
    {
		if ( (Instigator != None) && ((Instigator.AmbientSound == ChargeLoopSound) || (Instigator.AmbientSound == ChargeSound)) )
			Instigator.AmbientSound = None;
		A49SkrithBlaster(BW).SetGlowSize(0);
		Instigator.SoundPitch = Instigator.Default.SoundPitch;
		Instigator.SoundRadius = Instigator.Default.SoundRadius;
		Instigator.SoundVolume = Instigator.Default.SoundVolume;

    }
}

simulated event ModeDoFire()
{
	if (level.Netmode == NM_Standalone && bVariableHeatProps)
	{
		if (A49SkrithBlaster(BW).HeatLevel >= 5)
			FireRate = default.FireRate - FRand()/20 - (0.1/A49SkrithBlaster(BW).HeatLevel);
		else
			FireRate = default.FireRate - FRand()/8 + (A49SkrithBlaster(BW).HeatLevel/25);
	}
	Super.ModeDoFire();

}

simulated event ModeTick(float DT)
{
	Super.ModeTick(DT);

	if (Weapon.SoundPitch != 56)
	{
		if (Instigator.DrivenVehicle!=None)
			Weapon.SoundPitch = 56;
		else
			Weapon.SoundPitch = Max(56, Weapon.SoundPitch - 8*DT);
	}
	if (bVariableHeatProps)
	{
		XInaccuracy=FMax(16,A49SkrithBlaster(BW).HeatLevel*100);
		YInaccuracy=FMax(16,A49SkrithBlaster(BW).HeatLevel*100);
	}
}

function PlayFiring()
{
	Super.PlayFiring();
	if (bVariableHeatProps && A49SkrithBlaster(BW).HeatLevel < 5)
	{
		A49SkrithBlaster(BW).AddHeat((HeatPerShot+ChargeLevel)*1.6);
	}
	A49SkrithBlaster(BW).AddHeat(HeatPerShot+ChargeLevel);
}

// Get aim then run trace...
function DoFireEffect()
{
	Super.DoFireEffect();
	if (Level.NetMode == NM_DedicatedServer)
	{
		if (bVariableHeatProps && A49SkrithBlaster(BW).HeatLevel < 5)
		{
			A49SkrithBlaster(BW).AddHeat((HeatPerShot+ChargeLevel)*1.6);
		}
		A49SkrithBlaster(BW).AddHeat(HeatPerShot+ChargeLevel);
	}
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	if (bChargable)
		GotoState('ChargeFire');
	else
		GotoState('');
	
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	if (Proj != None && BallisticProjectile(Proj) != None && bChargable)
	{
		Proj.Damage += (BallisticProjectile(Proj).DamageSpecial * ChargeLevel/float(MaxChargeLevel));
		Proj.Instigator = Instigator;
		Proj.SetDrawScale((ChargeLevel+1)*Proj.default.DrawScale);
	}
	ChargeLevel=0;
}

defaultproperties
{
    ChargeRate=0.650000
    MaxChargeLevel=3
	ChargeIncrement=10
    ChargeSound=Sound'BWBP_SKC_Sounds.EP90.EP90-Overcharge'
	ChargeLoopSound=Sound'BW_Core_WeaponSound.A73.A73Hum1'
    FlashBone="MuzzleTip"
    FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
    bPawnRapidFireAnim=True
	HeatPerShot=0.5
    AmmoClass=Class'BallisticProV55.Ammo_Cells'
	
	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-3.00)
	ShakeOffsetRate=(X=-70.000000)
	ShakeOffsetTime=2.000000
     
	//AI
	bInstantHit=True
	bLeadTarget=True
	bTossed=False
	bSplashDamage=False
	bRecommendSplashDamage=False
	BotRefireRate=0.99
}
