//=============================================================================
// XK2PrimaryFire.
//
// Very rapid, weak fire for XK2 SMG. can be silenced to reduce chances of
// detection and damage of weapon.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XK2PrimaryFire extends BallisticProInstantFire;

var() Actor						SMuzzleFlash;		// Silenced Muzzle flash stuff
var() class<Actor>				SMuzzleFlashClass;
var() Name						SFlashBone;
var() float						SFlashScaleFactor;

var() Actor						MuzzleFlashAmp;		
var() class<Actor>				MuzzleFlashClassAmp;	
var() Name						AmpFlashBone;
var() float						AmpFlashScaleFactor;
var(XK2) bool						bAmped;
var(XK2) float						AmpDrainPerShot;

function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if ((SMuzzleFlashClass != None) && ((SMuzzleFlash == None) || SMuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (SMuzzleFlash, SMuzzleFlashClass, Weapon.DrawScale*SFlashScaleFactor, weapon, SFlashBone);
	if ((MuzzleFlashClassAmp != None) && ((MuzzleFlashAmp == None) || MuzzleFlashAmp.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashAmp, MuzzleFlashClassAmp, Weapon.DrawScale*AmpFlashScaleFactor, weapon, FlashBone);
}

function SetSilenced(bool bSilenced)
{
	bAISilent = bSilenced;

	if (!bSilenced)
	{
		XInaccuracy *= 2;
		YInaccuracy *= 2;
		DecayRange.Min *= 1.25f;
	}
	else
	{
		XInaccuracy = default.XInaccuracy;
		YInaccuracy = default.YInaccuracy;
		DecayRange.Min *= 0.8f;
	}
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
	if (XK2Submachinegun(Weapon).CurrentWeaponMode == 4 && XK2Submachinegun(Weapon).AmpCharge > 0 && MuzzleFlashAmp != None )
       	MuzzleFlashAmp.Trigger(Weapon, Instigator);
    else if (!XK2SubMachinegun(Weapon).bSilenced && XK2Submachinegun(Weapon).CurrentWeaponMode != 4 && MuzzleFlash != None)
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
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashAmp);
}

simulated function SwitchWeaponMode (byte NewMode)
{
	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;
		
	if (NewMode == 4) 
	{
		bAmped=True;
        
		WaterRangeAtten=0.600000;
		DecayRange.Max = 4200.000000;
		DecayRange.Min = 1500.000000;
		WallPenetrationForce=24.000000;
	}
	else
	{
		bAmped=False;//Standard Fire
	}
}

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{	
    super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);

    if (bAmped && Pawn(Victim) != None && Pawn(Victim).Health > 0 && Vehicle(Victim) == None)
    {
        class'BCSprintControl'.static.AddSlowTo(Pawn(Victim), 0.7, 0.2);
    }
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	if (!bAmped)
		BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, XK2SubMachinegun(Weapon).bSilenced, WaterHitLoc);
	else
		XK2Attachment(Weapon.ThirdPersonActor).IceUpdateHit(Other, HitLocation, HitNormal, Surf, , WaterHitLoc);
}

function ServerPlayFiring()
{
	if (XK2SubMachinegun(Weapon) != None && XK2SubMachinegun(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	PlayFireAnimations();

	CheckClipFinished();
}

function PlayFiring()
{
	if (XK2SubMachinegun(Weapon).bSilenced)
		Weapon.SetBoneScale (0, 1.0, XK2SubMachinegun(Weapon).SilencerBone);
	else
		Weapon.SetBoneScale (0, 0.0, XK2SubMachinegun(Weapon).SilencerBone);
		
	PlayFireAnimations();

    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;

	if (XK2SubMachinegun(Weapon) != None && XK2SubMachinegun(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

	CheckClipFinished();
	
	if (bAmped)
		XK2SubMachinegun(BW).AddHeat(AmpDrainPerShot);
}

// Get aim then run trace...
function DoFireEffect()
{
	Super.DoFireEffect();
	if (Level.NetMode == NM_DedicatedServer)
		XK2SubMachinegun(BW).AddHeat(AmpDrainPerShot);
}

defaultproperties
{
	AmpDrainPerShot=-0.3
	AmpFlashBone="tip2"
	AmpFlashScaleFactor=0.300000
	MuzzleFlashClassAmp=Class'BallisticProV55.XK2SilencedFlash'
	
	SMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
	SFlashBone="tip2"
	SFlashScaleFactor=1.000000

	TraceRange=(Min=4096.000000,Max=4096.000000)
	DamageType=Class'BallisticProV55.DTXK2SMG'
	DamageTypeHead=Class'BallisticProV55.DTXK2SMGHead'
	DamageTypeArm=Class'BallisticProV55.DTXK2SMG'
	PenetrateForce=150
	bPenetrate=True
	ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-2',Volume=0.800000,Radius=24.000000,bAtten=True)
	DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryPistol',Volume=0.700000)
	bDryUncock=True
	MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
	BrassClass=Class'BallisticProV55.Brass_Pistol'
	BrassOffset=(X=-5.000000,Z=-4.000000)
	AimedFireAnim="SightFire"
	FireRecoil=72.000000
	FireChaos=0.025000
	FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
	XInaccuracy=48.000000
	YInaccuracy=48.000000
	SilencedFireSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceFire',Volume=0.7,Radius=64.000000,bAtten=True)
	BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Fire',Volume=0.7,Radius=384.000000)
	bPawnRapidFireAnim=True
	FireRate=0.09000
	AmmoClass=Class'BallisticProV55.Ammo_9mm'

	ShakeRotMag=(X=24.000000)
	ShakeRotRate=(X=360.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-5.00)
	ShakeOffsetRate=(X=-100.000000)
	ShakeOffsetTime=2.000000
}
