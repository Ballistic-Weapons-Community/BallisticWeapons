//=============================================================================
// SRXPrimaryFire.
//
// Automatic fire. Battle rifle class - has a longer range and better accuracy than ARs, but main class has
// inferior hipfire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SRXPrimaryFire extends BallisticRangeAttenFire;

var() sound		SuperFireSound;
var() sound		MegaFireSound;
var() sound		ExtraFireSound;
var() sound		SilentFireSound;
var() sound		BlackFireSound;

var() sound		Amp1FireSound; //Incendiary Red
var() sound		Amp2FireSound; //???
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
	if (NewMode == 0) //Standard Fire
	{
		BallisticFireSound.Sound=default.BallisticFireSound.sound;
		BallisticFireSound.Volume=default.BallisticFireSound.Volume;
		FireRecoil=default.FireRecoil;
		FireChaos=default.FireChaos;
		Damage = default.Damage;
		DamageType=default.DamageType;
		DamageTypeHead=default.DamageTypeHead;
		DamageTypeArm=default.DamageTypeArm;
		FireRate=Default.FireRate;
		FlashScaleFactor=default.FlashScaleFactor;
		RangeAtten=default.RangeAtten;
	}
	else if (NewMode == 1) //Incendiary Amp
	{
		BallisticFireSound.Sound=Amp1FireSound;
		BallisticFireSound.Volume=1.500000;
		FireRecoil=256.000000;
		FireChaos=0.350000;
		Damage=45.000000;
		DamageType=class'DTSRXRifle_Incendiary';
		DamageTypeHead=class'DTSRXRifleHead_Incendiary';
		DamageTypeArm=class'DTSRXRifle_Incendiary';
		FireRate=0.280000;
		FlashScaleFactor=1.100000;
		RangeAtten=1.000000;
	}
	else if (NewMode == 2) //Acid Amp
	{
		BallisticFireSound.Sound=Amp2FireSound;
		BallisticFireSound.Volume=1.200000;
		FireRecoil=128.000000;
		FireChaos=0.150000;
		Damage=25.000000;
		DamageType=class'DTSRXRifle_Corrosive';
		DamageTypeHead=class'DTSRXRifleHead_Corrosive';
		DamageTypeArm=class'DTSRXRifle_Corrosive';
		FireRate=0.160000;
		FlashScaleFactor=0.400000;
		RangeAtten=1.000000;
	}
	else
	{
		BallisticFireSound.Sound=default.BallisticFireSound.sound;
		BallisticFireSound.Volume=default.BallisticFireSound.Volume;
		FireRecoil=default.FireRecoil;
		FireChaos=default.FireChaos;
		Damage = default.Damage;
		DamageType=default.DamageType;
		DamageTypeHead=default.DamageTypeHead;
		DamageTypeArm=default.DamageTypeArm;
		FireRate=Default.FireRate;
		FlashScaleFactor=default.FlashScaleFactor;
		RangeAtten=default.RangeAtten;
	}
	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;

}

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (SRXRifle(Weapon) != None && SRXRifle(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (SRXRifle(Weapon) != None && SRXRifle(Weapon).CurrentWeaponMode == 1 && Amp1FireSound != None)
		Weapon.PlayOwnedSound(Amp1FireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);
	else if (SRXRifle(Weapon) != None && SRXRifle(Weapon).CurrentWeaponMode == 2 && Amp2FireSound != None)
		Weapon.PlayOwnedSound(Amp2FireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

	CheckClipFinished();

	if (AimedFireAnim != '')
	{
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
		if (BW.BlendFire())		
			BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
	}

	else
	{
		if (FireCount == 0 && Weapon.HasAnim(FireLoopAnim))
			BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	}
}

//Do the spread on the client side
function PlayFiring()
{
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
		if (FireCount == 0 && Weapon.HasAnim(FireLoopAnim))
			BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	}
	
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (SRXRifle(Weapon) != None && SRXRifle(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (SRXRifle(Weapon) != None && SRXRifle(Weapon).CurrentWeaponMode == 1 && Amp1FireSound != None)
		Weapon.PlayOwnedSound(Amp1FireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);
	else if (SRXRifle(Weapon) != None && SRXRifle(Weapon).CurrentWeaponMode == 2 && Amp2FireSound != None)
		Weapon.PlayOwnedSound(Amp2FireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

	CheckClipFinished();
}

simulated function SetSilenced(bool bSilenced)
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
     Amp1FireSound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-LoudFire'
     Amp2FireSound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-SpecialFire'
	 AmpFlashBone="tip2"
     Amp1FlashScaleFactor=0.300000
	 Amp2FlashScaleFactor=0.300000
	 
	 SMuzzleFlashClass=Class'BWBP_SKC_Pro.SRXSilencedFlash'
	 MuzzleFlashClassAmp1=Class'BWBP_SKC_Pro.FG50FlashEmitter'
     MuzzleFlashClassAmp2=Class'BallisticProV55.A500FlashEmitter'
     SFlashBone="tip2"
     SFlashScaleFactor=0.750000
     CutOffDistance=6144.000000
     CutOffStartRange=3072.000000
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WallPenetrationForce=24.000000
     
     Damage=40.000000
     HeadMult=1.4f
     LimbMult=0.8f
     
     RangeAtten=0.450000
     WaterRangeAtten=0.800000
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
     FireRecoil=200.000000
     FireChaos=0.100000
     SilencedFireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-Fire2',Volume=0.500000,Radius=256.000000,bAtten=True)
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.185000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_SRXBullets'
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
