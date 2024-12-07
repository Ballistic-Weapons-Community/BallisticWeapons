//=============================================================================
// M2020GaussPrimaryFire.
//
// Gauss fire. Magnetic acceleration. Physics. Pv=nRT. A1V1=A2V2. Llammas.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M2020GaussPrimaryFire extends BallisticProInstantFire;
var() sound		SpecialFireSound;
var() sound		LowPowerFireSound;
var bool		bFlashAlt;
var() Actor						MuzzleFlash2;		// ALT: The muzzleflash actor
var() class<Actor>				MuzzleFlashClass2;	// ALT: The actor to use for this fire's muzzleflash

//Disable fire anim when scoped
function PlayFiring()
{
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);

	// Slightly modified Code from original PlayFiring()
	PlayFireAnimations();

    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}


// Effect related functions ------------------------------------------------
// Spawn the muzzleflash actor
function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if ((MuzzleFlashClass2 != None) && ((MuzzleFlash2 == None) || MuzzleFlash2.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash2, MuzzleFlashClass2, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);

}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlash2);
}


//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
    	if (MuzzleFlash != None && !bFlashAlt)
        	MuzzleFlash.Trigger(Weapon, Instigator);
    	else if (MuzzleFlash2 != None && bFlashAlt)
        	MuzzleFlash2.Trigger(Weapon, Instigator);
	if (!bBrassOnCock)
		EjectBrass();
}

function StartBerserk()
{
	switch(BW.CurrentWeaponMode)
	{
		case 0: FireRate = default.FireRate * 0.75; break;
		case 1: FireRate = 1.0 * 0.75; break;
		default: FireRate = 0.2 * 0.75;
	}
    FireAnimRate = default.FireAnimRate/0.75;
    FireRecoil = default.FireRecoil * 0.75;
    FireChaos = default.FireChaos * 0.75;
}

function StopBerserk()
{
	switch(BW.CurrentWeaponMode)
	{
		case 0: FireRate = default.FireRate; break;
		case 1: FireRate = 1.0; break;
		default: FireRate = 0.2;
	}
    FireAnimRate = default.FireAnimRate;
    FireRecoil = default.FireRecoil;
    FireChaos = default.FireChaos;
}

simulated function SwitchWeaponMode (byte NewMode)
{
	if (NewMode == 0)	//gauss normal
	{
		FirePushbackForce=default.FirePushbackForce;
		bFlashAlt=false;
		KickForce = default.KickForce;
		M2020GaussAttachment(Weapon.ThirdPersonActor).bNoEffect=false;
	}
	
	else if (NewMode == 1)	//gauss power
	{
		FirePushbackForce=120.000000;
		KickForce=1000;
		bFlashAlt=false;
		M2020GaussAttachment(Weapon.ThirdPersonActor).bNoEffect=false;
	}
	else if (NewMode == 2 || NewMode == 3)	//gauss offline or gauss deflection
	{
		FirePushbackForce=0.000000;
		bFlashAlt=true;
		KickForce = default.KickForce;
		M2020GaussAttachment(Weapon.ThirdPersonActor).bNoEffect=true;

	}
}

defaultproperties
{
	SpecialFireSound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFireSuper'
	LowPowerFireSound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFireLow'
	MuzzleFlashClass2=Class'BallisticProV55.M50FlashEmitter'
	TraceRange=(Min=30000.000000,Max=30000.000000)
	DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
	DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
	DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
	PenetrateForce=600
	bPenetrate=True
	PDamageFactor=0.750000
	WallPDamageFactor=0.750000
	MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
	FlashScaleFactor=1.200000
	BrassClass=Class'BallisticProV55.Brass_Rifle'
	BrassBone="ejector"
	BrassOffset=(X=-30.000000,Y=1.000000)
	FireRecoil=320.000000
	FireChaos=0.600000
	BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFire',Volume=6.700000)
	FireEndAnim=
	FireRate=0.325000
	AmmoClass=Class'BWBP_SKC_Pro.Ammo_42HVG'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-15.00)
	ShakeOffsetRate=(X=-300.000000)
	ShakeOffsetTime=2.000000

	BotRefireRate=0.500000
	WarnTargetPct=0.400000
	aimerror=800.000000
}
