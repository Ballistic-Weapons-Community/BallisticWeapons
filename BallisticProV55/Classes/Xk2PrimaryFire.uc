//=============================================================================
// XK2PrimaryFire.
//
// Very rapid, weak fire for XK2 SMG. can be silenced to reduce chances of
// detection and damage of weapon.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XK2PrimaryFire extends BallisticRangeAttenFire;

var() Actor						SMuzzleFlash;		// Silenced Muzzle flash stuff
var() class<Actor>				SMuzzleFlashClass;
var() Name						SFlashBone;
var() float						SFlashScaleFactor;

function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if ((SMuzzleFlashClass != None) && ((SMuzzleFlash == None) || SMuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (SMuzzleFlash, SMuzzleFlashClass, Weapon.DrawScale*SFlashScaleFactor, weapon, SFlashBone);
}

function SetSilenced(bool bSilenced)
{
	bAISilent = bSilenced;
	if (!bSilenced)
	{
		XInaccuracy *= 2;
		YInaccuracy *= 2;
		CutOffStartRange *= 1.25;
	}
	else
	{
		XInaccuracy = default.XInaccuracy;
		YInaccuracy = default.YInaccuracy;
		CutOffStartRange = default.CutOffStartRange;
	}
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
    if (!XK2SubMachinegun(Weapon).bSilenced && MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);
    else if (XK2SubMachinegun(Weapon).bSilenced && SMuzzleFlash != None)
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

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, XK2SubMachinegun(Weapon).bSilenced, WaterHitLoc);
}

function ServerPlayFiring()
{
	if (XK2SubMachinegun(Weapon) != None && XK2SubMachinegun(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	// Slightly modified Code from original PlayFiring()
	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else if(!BW.bScopeView || !Weapon.HasAnim(AimedFireAnim))
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	else BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, , "FIRE");
	// End code from normal PlayFiring()

	CheckClipFinished();
}

function PlayFiring()
{
	if (XK2SubMachinegun(Weapon).bSilenced)
		Weapon.SetBoneScale (0, 1.0, XK2SubMachinegun(Weapon).SilencerBone);
	else
		Weapon.SetBoneScale (0, 0.0, XK2SubMachinegun(Weapon).SilencerBone);
		
	// Slightly modified Code from original PlayFiring()
	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else if(!BW.bScopeView || !Weapon.HasAnim(AimedFireAnim))
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	else BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, , "FIRE");
	// End code from normal PlayFiring()

    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;

	if (XK2SubMachinegun(Weapon) != None && XK2SubMachinegun(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

	CheckClipFinished();
}

defaultproperties
{
     SMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
     SFlashBone="tip2"
     SFlashScaleFactor=1.000000
	 
     CutOffDistance=2560.000000
     CutOffStartRange=768.000000
     TraceRange=(Min=4000.000000,Max=4000.000000)
	 RangeAtten=0.2
	 WaterRangeAtten=0.200000
	 
     WallPenetrationForce=8.000000
     
     Damage=20.000000
     HeadMult=1.4f
     LimbMult=0.5f

     DamageType=Class'BallisticProV55.DTXK2SMG'
     DamageTypeHead=Class'BallisticProV55.DTXK2SMGHead'
     DamageTypeArm=Class'BallisticProV55.DTXK2SMG'
     PenetrateForce=150
     bPenetrate=True
     ClipFinishSound=(Sound=Sound'BallisticSounds3.Misc.ClipEnd-2',Volume=0.800000,Radius=72.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryPistol',Volume=0.700000)
     bDryUncock=True
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassOffset=(X=-25.000000,Z=-5.000000)
     AimedFireAnim="SightFire"
     FireRecoil=72.000000
     FireChaos=0.025000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
     XInaccuracy=32.000000
     YInaccuracy=32.000000
     SilencedFireSound=(Sound=Sound'BallisticSounds3.XK2.XK2-SilenceFire',Volume=0.50000,Radius=48.000000,bAtten=True)
     BallisticFireSound=(Sound=Sound'BallisticSounds3.XK2.XK2-Fire',Volume=0.500000,Radius=384.000000)
     bPawnRapidFireAnim=True
     FireRate=0.09000
     AmmoClass=Class'BallisticProV55.Ammo_9mm'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
}
