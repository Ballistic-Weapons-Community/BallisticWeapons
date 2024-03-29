//=============================================================================
// SRS900PrimaryFire.
//
// Automatic rifle fire. More damage, penetrating power and recoil than M50.
// Silencer support.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SRS900PrimaryFire extends BallisticProInstantFire;

var() Actor						SMuzzleFlash;		// Silenced Muzzle flash stuff
var() class<Actor>				SMuzzleFlashClass;
var() Name						SFlashBone;
var() float						SFlashScaleFactor;

simulated function ApplyRecoil()
{
	BW.AddRecoil(FireRecoil, FireChaos, ThisModeNum);

	if (FirePushbackForce != 0)
	{
		if (Instigator.Physics == PHYS_Falling)
			Instigator.Velocity -= Vector(Instigator.GetViewRotation()) * FirePushbackForce * 0.25;
		else
			Instigator.Velocity -= Vector(Instigator.GetViewRotation()) * FirePushbackForce;
	}
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
    if (!SRS900Rifle(Weapon).bSilenced && MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);
    else if (SRS900Rifle(Weapon).bSilenced && SMuzzleFlash != None)
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

/*
// End effect functions ----------------------------------------------------
function float GetDamage (Actor Other, vector HitLocation, vector Dir, out Actor Victim, optional out class<DamageType> DT)
{
	if (SRS900Rifle(Weapon).bSilenced)
		return Super.GetDamage (Other, HitLocation, Dir, Victim, DT) * 0.8;
	else
		return Super.GetDamage (Other, HitLocation, Dir, Victim, DT);
}*/

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, SRS900Rifle(Weapon).bSilenced, WaterHitLoc);
}

// FIXME:
// Shouldn't be doing overrides for this.
// Unfortunately, it's compositional
function ServerPlayFiring()
{
	if (SRS900Rifle(Weapon) != None && SRS900Rifle(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();

	PlayFireAnimations();
}

//Do the spread on the client side
function PlayFiring()
{
	FireAnim = 'Fire';

	if (SRS900Rifle(Weapon).bSilenced)
	{
		SRS900Rifle(Weapon).StealthImpulse(0.3);
		Weapon.SetBoneScale (0, 1.0, SRS900Rifle(Weapon).SilencerBone);
	}
	else
	{
		SRS900Rifle(Weapon).StealthImpulse(0.3);
		Weapon.SetBoneScale (0, 0.0, SRS900Rifle(Weapon).SilencerBone);
	}

	PlayFireAnimations();

    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;

	if (SRS900Rifle(Weapon) != None && SRS900Rifle(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
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
	TraceRange=(Min=30000.000000,Max=30000.000000)
	DamageType=Class'BallisticProV55.DTSRS900Rifle'
	DamageTypeHead=Class'BallisticProV55.DTSRS900RifleHead'
	DamageTypeArm=Class'BallisticProV55.DTSRS900Rifle'
	PenetrateForce=180
	bPenetrate=True
	ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-1',Volume=0.800000,Radius=48.000000,bAtten=True)
	bCockAfterEmpty=True
	MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
	FlashScaleFactor=0.500000
	BrassClass=Class'BallisticProV55.Brass_Rifle'
	BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
	FireRecoil=192.000000
	FireChaos=0.070000
	FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
	SilencedFireSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilenceFire',Volume=1.000000,Radius=768.000000,bAtten=True)
	BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-Fire',Radius=1536.000000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
	bPawnRapidFireAnim=True
	FireEndAnim=
	FireRate=0.20000
	AmmoClass=Class'BallisticProV55.Ammo_RS762mm'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-8.00)
	ShakeOffsetRate=(X=-160.000000)
	ShakeOffsetTime=2.000000
	
	WarnTargetPct=0.200000
	aimerror=800.000000
	BurstFireRateFactor=0.55
}
