//=============================================================================
// SRXPrimaryFire.
//
// Automatic fire. Battle rifle class - has a longer range and better accuracy than ARs, but main class has
// inferior hipfire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SRXPrimaryFire extends BallisticProInstantFire;

var() sound		SuperFireSound;
var() sound		MegaFireSound;
var() sound		ExtraFireSound;
var() sound		SilentFireSound;
var() sound		BlackFireSound;

var() sound		RegularFireSound;
var() Actor						MuzzleFlashAmp1;		
var() class<Actor>				MuzzleFlashClassAmp1;	
var() Actor						MuzzleFlashAmp2;		
var() class<Actor>				MuzzleFlashClassAmp2;	
var() Name						AmpFlashBone;
var() float						Amp1FlashScaleFactor, Amp2FlashScaleFactor;

var() Actor						SMuzzleFlash;		// Silenced Muzzle flash stuff
var() class<Actor>				SMuzzleFlashClass;
var() Name						SFlashBone;
var() float						SFlashScaleFactor;
var(SRX) bool						bAmped;
var(SRX) float						AmpDrainPerShot;

function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if ((SMuzzleFlashClass != None) && ((SMuzzleFlash == None) || SMuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (SMuzzleFlash, SMuzzleFlashClass, Weapon.DrawScale*SFlashScaleFactor, weapon, SFlashBone);
	if ((MuzzleFlashClassAmp1 != None) && ((MuzzleFlashAmp1 == None) || MuzzleFlashAmp1.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashAmp1, MuzzleFlashClassAmp1, Weapon.DrawScale*Amp1FlashScaleFactor, weapon, FlashBone);
    if ((MuzzleFlashClassAmp2 != None) && ((MuzzleFlashAmp2 == None) || MuzzleFlashAmp2.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashAmp2, MuzzleFlashClassAmp2, Weapon.DrawScale*Amp2FlashScaleFactor, weapon, FlashBone);
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
		
    if (SRXRifle(Weapon).bSilenced && SMuzzleFlash != None)
        SMuzzleFlash.Trigger(Weapon, Instigator);
    else if (MuzzleFlashAmp1 != None && SRXRifle(Weapon).CurrentWeaponMode == 1)
       	MuzzleFlashAmp1.Trigger(Weapon, Instigator);
    else if (MuzzleFlashAmp2 != None && SRXRifle(Weapon).CurrentWeaponMode == 2)
        MuzzleFlashAmp2.Trigger(Weapon, Instigator);
	else
		MuzzleFlash.Trigger(Weapon, Instigator);

	if (!bBrassOnCock)
		EjectBrass();
}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();
	class'BUtil'.static.KillEmitterEffect (SMuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashAmp1);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashAmp2);
}

simulated function SwitchWeaponMode (byte NewMode)
{
	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;
		
	if (NewMode == 0) //Standard Fire
	{
		bAmped=False;
	}
	else if (NewMode == 1) //Cryo Amp
	{
		bAmped=True;
	}
	else if (NewMode == 2) //RAD Amp
	{
		bAmped=True;
	}
	else
	{
		bAmped=False;
	}
}

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (SRXRifle(Weapon) != None && SRXRifle(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

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

	if (SRXRifle(Weapon) != None && SRXRifle(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

	CheckClipFinished();
	
	if (bAmped)
		SRXRifle(BW).AddHeat(AmpDrainPerShot);
}

// Get aim then run trace...
function DoFireEffect()
{
	Super.DoFireEffect();
	if (Level.NetMode == NM_DedicatedServer)
		SRXRifle(BW).AddHeat(AmpDrainPerShot);
}

simulated function SetSilenced(bool bSilenced)
{
	if (bSilenced)
	{
		FireRecoil *= 0.8;
		RangeAtten *= 1.2;
		XInaccuracy *= 0.75;
		YInaccuracy *= 0.75;
		Damage *= 0.75;

		BW.SightingTime = BW.default.SightingTime * 1.25;
	}
		
	else
	{
		FireRecoil = default.FireRecoil;
		RangeAtten = default.RangeAtten;
		XInaccuracy = default.XInaccuracy;
		YInaccuracy = default.YInaccuracy;
		Damage = default.Damage;

		BW.SightingTime = BW.default.SightingTime;
	}
}

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (Victim.bProjTarget && BallisticShield(Victim) == None && SRXRifle(Weapon).CurrentWeaponMode == 1)
		BW.TargetedHurtRadius(Damage, 384, class'DTSRXRifle_Incendiary', 200, HitLocation, Pawn(Victim));
}

// Does something to make the effects appear
simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	local int Surf;

	if ((!Other.bWorldGeometry && Mover(Other) == None && Pawn(Other) == None) || level.NetMode == NM_Client)
		return false;

	if (Vehicle(Other) != None)
		Surf = 3;
	else if (HitMat == None)
		Surf = int(Other.SurfaceType);
	else
		Surf = int(HitMat.SurfaceType);
		
	if ((Other == None || Other.bWorldGeometry) && SRXRifle(Weapon).CurrentWeaponMode == 1)
		BW.TargetedHurtRadius(5, 150, class'DTSRXRifle_Incendiary', 50, HitLocation);

	// Tell the attachment to spawn effects and so on
	SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
	if (!bAISilent)
		Instigator.MakeNoise(1.0);
	return true;
}

defaultproperties
{
	 AmpDrainPerShot=-0.85
	 AmpFlashBone="tip2"
     Amp1FlashScaleFactor=0.300000
	 Amp2FlashScaleFactor=0.300000
	 MuzzleFlashClassAmp1=Class'BWBP_SKC_Pro.FG50FlashEmitter'
     MuzzleFlashClassAmp2=Class'BallisticProV55.A500FlashEmitter'
	 
	 SMuzzleFlashClass=Class'BWBP_SKC_Pro.SRXSilencedFlash'
     SFlashBone="tip2"
     SFlashScaleFactor=0.750000
	 
     TraceRange=(Min=30000.000000,Max=30000.000000)

     DamageType=Class'BWBP_SKC_Pro.DTSRXRifle'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTSRXRifleHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTSRXRifle'
     PenetrateForce=120
     bPenetrate=True
     ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-1',Volume=0.800000,Radius=48.000000,bAtten=True)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BWBP_SKC_Pro.SRXFlashEmitter'
     FlashScaleFactor=0.2000000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
     AimedFireAnim="SightFire"
     FireRecoil=192.000000
     FireChaos=0.300000
     SilencedFireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-Fire2',Volume=0.500000,Radius=256.000000,bAtten=True)
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.185000
     AmmoClass=Class'BallisticProV55.Ammo_RS762mm'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=800.000000
	 BurstFireRateFactor=0.30
}
