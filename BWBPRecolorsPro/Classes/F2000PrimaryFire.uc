//=============================================================================
// F2000PrimaryFire.
//
// Very automatic, bullet style instant hit. Shots have medium range and good
// power. Accuracy and ammo goes quickly with its faster than normal rate of fire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class F2000PrimaryFire extends BallisticRangeAttenFire;
	
var() Actor						SMuzzleFlash;		// Silenced Muzzle flash stuff
var() class<Actor>				SMuzzleFlashClass;
var() Name						SFlashBone;
var() float						SFlashScaleFactor;

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
    if (!F2000AssaultRifle(Weapon).bSilenced && MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);
    else if (F2000AssaultRifle(Weapon).bSilenced && SMuzzleFlash != None)
        SMuzzleFlash.Trigger(Weapon, Instigator);

	if (!bBrassOnCock)
		EjectBrass();
}

function SetSilenced(bool bSilenced)
{
	bAISilent = bSilenced;
	if (bSilenced)
	{
		Damage *= 0.65;
		RecoilPerShot *= 0.5;
		BW.RecoilXFactor *= 0.5;
		BW.RecoilYFactor *= 0.5;
		RangeAtten *= 1.55;
		XInaccuracy *= 0.25;
		YInaccuracy *= 0.25;
	}
	else
	{
     	RecoilPerShot = default.RecoilPerShot;
		Damage = default.Damage;
		BW.RecoilXFactor = BW.default.RecoilXFactor;
		BW.RecoilYFactor = BW.default.RecoilYFactor;
		RangeAtten = default.RangeAtten;
		XInaccuracy = default.XInaccuracy;
		YInaccuracy = default.YInaccuracy;
	}
}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (SMuzzleFlash);
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

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, F2000AssaultRifle(Weapon).bSilenced, WaterHitLoc);
}

function ServerPlayFiring()
{
	CheckClipFinished();

	if (AimedFireAnim != '')
	{
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
		if (BW.BlendFire())		
			BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
	}

	else
	{
		if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
			BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	}
	
	if (F2000AssaultRifle(Weapon) != None && F2000AssaultRifle(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
}

//Do the spread on the client side
function PlayFiring()
{
	if (F2000AssaultRifle(Weapon).bSilenced)
		Weapon.SetBoneScale (0, 1.0, F2000AssaultRifle(Weapon).SilencerBone);
	else
		Weapon.SetBoneScale (0, 0.0, F2000AssaultRifle(Weapon).SilencerBone);

	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);
		
	if (AimedFireAnim != '')
	{
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
		if (BW.BlendFire())		
			BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
	}

	else
	{
		if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
			BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	}
	
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	CheckClipFinished();

	if (F2000AssaultRifle(Weapon) != None && F2000AssaultRifle(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);
}

defaultproperties
{
     SMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
     SFlashBone="tip2"
     SFlashScaleFactor=1.000000
     CutOffDistance=5120.000000
     CutOffStartRange=2048.000000
     TraceRange=(Min=15000.000000,Max=15000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=32.000000
     MaxWalls=2
     Damage=25.000000
     DamageHead=50.000000
     DamageLimb=25.000000
     RangeAtten=0.350000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPRecolorsPro.DTF2000Assault'
     DamageTypeHead=Class'BWBPRecolorsPro.DTF2000AssaultHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DTF2000Assault'
     PenetrateForce=150
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BWBPRecolorsPro.MARSFlashEmitter'
     FlashScaleFactor=0.500000
     BrassClass=Class'BallisticProV55.Brass_MG'
     BrassOffset=(X=-80.000000,Y=1.000000)
     AimedFireAnim="SightFire"
     RecoilPerShot=150.000000
     FireChaos=0.032000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     SilencedFireSound=(Sound=Sound'PackageSounds4ProExp.MARS.F2000-SilFire2',Volume=1.100000,Radius=192.000000,bAtten=True)
     BallisticFireSound=(Sound=Sound'PackageSounds4ProExp.MARS.MARS-RapidFire',Volume=1.100000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.090000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_545mmSTANAG'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
