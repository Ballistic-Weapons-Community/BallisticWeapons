//=============================================================================
// RS8PrimaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RS8PrimaryFire extends BallisticProInstantFire;

var() Actor						SMuzzleFlash;		// Silenced Muzzle flash stuff
var() class<Actor>				SMuzzleFlashClass;
var() Name						SFlashBone;
var() float						SFlashScaleFactor;


simulated function OnEffectParamsChanged(int EffectIndex)
{
	super.OnEffectParamsChanged(EffectIndex);
	
    if (RS8Pistol(Weapon).bHasKnife)
        ApplyTacKnifeEffectParams();
}

simulated function ApplyTacKnifeEffectParams()
{
	FireRecoil *= 1.5;
	FireChaos = 1;
    XInaccuracy	= 256;
    YInaccuracy = 256;
}

function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if ((SMuzzleFlashClass != None) && ((SMuzzleFlash == None) || SMuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (SMuzzleFlash, SMuzzleFlashClass, Weapon.DrawScale*SFlashScaleFactor, weapon, SFlashBone);
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
    if (!RS8Pistol(Weapon).bSilenced && MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);
    else if (RS8Pistol(Weapon).bSilenced && SMuzzleFlash != None)
        SMuzzleFlash.Trigger(Weapon, Instigator);

	if (!bBrassOnCock)
		EjectBrass();
}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (SMuzzleFlash);
}
// End effect functions ----------------------------------------------------
function float ResolveDamageFactors(Actor Other, vector TraceStart, vector HitLocation, int PenetrateCount, int WallCount, int WallPenForce, Vector WaterHitLocation)
{
	if (RS8Pistol(Weapon).bSilenced)
		return Super.ResolveDamageFactors(Other, TraceStart, HitLocation, Penetratecount, WallCount, WallPenForce, WaterHitLocation) * 0.85;
	else
		return Super.ResolveDamageFactors(Other, TraceStart, HitLocation, Penetratecount, WallCount, WallPenForce, WaterHitLocation);
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, RS8Pistol(Weapon).bSilenced, WaterHitLoc);
}

function ServerPlayFiring()
{
	if (RS8Pistol(Weapon) != None && RS8Pistol(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();

	PlayFireAnimations();
}

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'OpenIdle';
		BW.ReloadAnim = 'OpenReload';
		//AimedFireAnim = 'SightFireOpen';
		AimedFireAnim='OpenFire';
		FireAnim = 'OpenFire';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		//AimedFireAnim = 'SightFire';
		AimedFireAnim='Fire';
		FireAnim = 'Fire';
	}

	if (RS8Pistol(Weapon).bSilenced || RS8Pistol(Weapon).bCompensated)
		Weapon.SetBoneScale (0, 1.0, RS8Pistol(Weapon).SilencerBone);
	else
		Weapon.SetBoneScale (0, 0.0, RS8Pistol(Weapon).SilencerBone);

	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);
		
	PlayFireAnimations();
	
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()
	
	if (RS8Pistol(Weapon) != None && RS8Pistol(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

	CheckClipFinished();
}

defaultproperties
{
	SMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
	SFlashBone="tip2"
	SFlashScaleFactor=0.25
	TraceRange=(Min=4000.000000,Max=4000.000000)
	DamageType=Class'BallisticProV55.DTRS8Pistol'
	DamageTypeHead=Class'BallisticProV55.DTRS8PistolHead'
	DamageTypeArm=Class'BallisticProV55.DTRS8Pistol'
	PenetrateForce=135
	bPenetrate=True
	MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
	BrassClass=Class'BallisticProV55.Brass_Pistol'
	BrassOffset=(X=-14.000000,Z=-5.000000)
	FireRecoil=192.000000
	FireChaos=0.250000
	XInaccuracy=96.000000
	YInaccuracy=96.000000
	SilencedFireSound=(Sound=Sound'BW_Core_WeaponSound.Pistol.RSP-SilenceFire',Volume=0.700000,Radius=48.000000,bAtten=True)
	BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.Pistol.RSP-Fire',Volume=1.100000)
	bPawnRapidFireAnim=True
	FireEndAnim=
	FireAnimRate=2
	AimedFireAnim='SightFire'
	FireRate=0.20000
	AmmoClass=Class'BallisticProV55.Ammo_RS8Bullets'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-3.00)
	ShakeOffsetRate=(X=-60.000000)
	ShakeOffsetTime=2.000000

	BotRefireRate=0.750000
}
