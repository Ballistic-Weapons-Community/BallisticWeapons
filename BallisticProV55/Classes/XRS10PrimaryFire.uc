//=============================================================================
// XRS10PrimaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class XRS10PrimaryFire extends BallisticProInstantFire;

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
	}
	else
	{
		XInaccuracy = default.XInaccuracy;
		YInaccuracy = default.YInaccuracy;
	}
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
    if (!XRS10SubMachinegun(Weapon).bSilenced && MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);
    else if (XRS10SubMachinegun(Weapon).bSilenced && SMuzzleFlash != None)
        SMuzzleFlash.Trigger(Weapon, Instigator);

	if (!bBrassOnCock)
		EjectBrass();
}

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (XRS10SubMachinegun(Weapon) != None && XRS10SubMachinegun(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
	PlayFireAnimations();
}


//Do the spread on the client side
function PlayFiring()
{
	PlayFireAnimations();
	
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (XRS10SubMachinegun(Weapon) != None && XRS10SubMachinegun(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);
		
	CheckClipFinished();
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
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, XRS10SubMachinegun(Weapon).bSilenced, WaterHitLoc);
}

defaultproperties
{
     SMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
     SFlashBone="tip2"
     SFlashScaleFactor=1.000000
     SilencedFireSound=(Sound=Sound'BW_Core_WeaponSound.TEC.RSMP-SilenceFire',Volume=0.5,Radius=128,bAtten=True)
     
     ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-2',Volume=0.800000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryPistol',Volume=0.700000)
     bDryUncock=True
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassOffset=(X=-26.000000,Z=-5.000000)
     
	 WaterRangeAtten=0.400000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.320000,OutVal=1),(InVal=0.500000,OutVal=1.500000),(InVal=1.000000,OutVal=2.250000)))
     
     bPawnRapidFireAnim=True
     AmmoClass=Class'BallisticProV55.Ammo_XRS10Bullets'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
}
