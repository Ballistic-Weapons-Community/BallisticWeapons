//=============================================================================
// R78PrimaryFire.
//
// Very accurate, long ranged and powerful bullet fire. Headshots are
// especially dangerous.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class R78PrimaryFire extends BallisticProInstantFire;

var() Actor						SMuzzleFlash;		// Silenced Muzzle flash stuff
var() class<Actor>				SMuzzleFlashClass;
var() Name						SFlashBone;
var() float						SFlashScaleFactor;

//========================================================
// Suppressor Stuff
//
// 
//========================================================
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
    if (!R78Rifle(Weapon).bSilenced && MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);
    else if (R78Rifle(Weapon).bSilenced && SMuzzleFlash != None)
        SMuzzleFlash.Trigger(Weapon, Instigator);

	if (!bBrassOnCock)
		EjectBrass();
}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();
	class'BUtil'.static.KillEmitterEffect (SMuzzleFlash);
}

function ServerPlayFiring()
{
	if (R78Rifle(Weapon) != None && R78Rifle(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	PlayFireAnimations();

	CheckClipFinished();
}

//Do the spread on the client side
function PlayFiring()
{
	FireAnim = 'Fire';

	if (R78Rifle(Weapon).bSilenced)
	{
		Weapon.SetBoneScale (0, 1.0, R78Rifle(Weapon).SilencerBone);
	}
	else
	{
		Weapon.SetBoneScale (0, 0.0, R78Rifle(Weapon).SilencerBone);
	}

	PlayFireAnimations();

    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;

	if (R78Rifle(Weapon) != None && R78Rifle(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,SilencedFireSound.Pitch,true);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

	CheckClipFinished();
}

function SetSilenced(bool bSilenced)
{
	if (bSilenced)
	{
		FireRecoil *= 0.8;
		RangeAtten *= 1.2;
		XInaccuracy *= 0.75;
		YInaccuracy *= 0.75;

		BW.SightingTime = BW.default.SightingTime * 1.25;
	}
		
	else
	{
		FireRecoil = default.FireRecoil;
		RangeAtten = default.RangeAtten;
		XInaccuracy = default.XInaccuracy;
		YInaccuracy = default.YInaccuracy;

		BW.SightingTime = BW.default.SightingTime;
	}
}

defaultproperties
{
	SMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
	SFlashBone="tip2"
	SFlashScaleFactor=0.750000
	SilencedFireSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilenceFire',Pitch=0.85,Volume=1.000000,Radius=1536.000000,bAtten=True)
	TraceRange=(Min=30000.000000,Max=30000.000000)
	DamageType=Class'BallisticProV55.DTR78Rifle'
	DamageTypeHead=Class'BallisticProV55.DTR78RifleHead'
	DamageTypeArm=Class'BallisticProV55.DTR78Rifle'
	KickForce=3000
	PenetrateForce=0
	bPenetrate=False	
	WallPenetrationForce=0
	PDamageFactor=0.800000
	bCockAfterFire=True
	MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
	BrassClass=Class'BallisticProV55.Brass_Rifle'
	//bBrassOnCock=True
	BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
	FireRecoil=378.000000
	FireChaos=0.500000
	//BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78-Fire',Volume=2.000000,Radius=1024.000000)
	BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78NS-Fire',Volume=2.000000,Radius=1024.000000)
	FireEndAnim=
	FireRate=1.1
	AmmoClass=Class'BallisticProV55.Ammo_42Rifle'
	ShakeRotMag=(X=400.000000,Y=32.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-5.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=2.000000
	
	// AI
	bInstantHit=True
	bLeadTarget=False
	bTossed=False
	bSplashDamage=False
	bRecommendSplashDamage=False
	BotRefireRate=0.4
	WarnTargetPct=0.5
	
	aimerror=800.000000
}
