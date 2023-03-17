//=============================================================================
// M30PrimaryFire.
//
//[11:09:19 PM] Captain Xavious: make sure its noted to be an assault rifle
//[11:09:26 PM] Marc Moylan: lol Calypto
//[11:09:28 PM] Matteo 'Azarael': mp40 effective range
//[11:09:29 PM] Matteo 'Azarael': miles
//=============================================================================
class FMPPrimaryFire extends BallisticProInstantFire;

var(FMP) sound		AmpRedFireSound;
var(FMP) sound		AmpGreenFireSound;
var(FMP) sound		RegularFireSound;

var(FMP) Actor						MuzzleFlashRed;		// ALT: The muzzleflash actor
var(FMP) class<Actor>				MuzzleFlashClassRed;	// ALT: The actor to use for this fire's muzzleflash
var(FMP) Actor						MuzzleFlashGreen;		// ALT: The muzzleflash actor
var(FMP) class<Actor>				MuzzleFlashClassGreen;	// ALT: The actor to use for this fire's muzzleflash
var(FMP) Name						AmpFlashBone;
var(FMP) float						AmpFlashScaleFactor;
var(SX45) bool						bAmped;
var(FMP) float						AmpDrainPerShot;


// Effect related functions ------------------------------------------------
// Spawn the muzzleflash actor
function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if ((MuzzleFlashClassRed != None) && ((MuzzleFlashRed == None) || MuzzleFlashRed.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashRed, MuzzleFlashClassRed, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if ((MuzzleFlashClassGreen != None) && ((MuzzleFlashGreen == None) || MuzzleFlashGreen.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashGreen, MuzzleFlashClassGreen, Weapon.DrawScale*AmpFlashScaleFactor, weapon, FlashBone);

}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashRed);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashGreen);
}


//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
 
    if (MuzzleFlashRed != None && FMPMachinePistol(Weapon).CurrentWeaponMode == 1)
       	MuzzleFlashRed.Trigger(Weapon, Instigator);
    else if (MuzzleFlashGreen != None && FMPMachinePistol(Weapon).CurrentWeaponMode == 2)
        MuzzleFlashGreen.Trigger(Weapon, Instigator);
	else
		MuzzleFlash.Trigger(Weapon, Instigator);
		
	if (!bBrassOnCock)
		EjectBrass();
}


simulated function SwitchWeaponMode (byte NewMode)
{
	if (NewMode == 0) //Standard Fire
	{
		RangeAtten=default.RangeAtten;
		FlashBone=default.FlashBone;
		bAmped=False;
	}
	
	else if (NewMode == 1) //Incendiary Amp
	{
		RangeAtten=1.000000;
		FlashBone=default.AmpFlashBone;
		bAmped=True;
	}
	else if (NewMode == 2) //Corrosive Amp
	{
		RangeAtten=1.000000;
		FlashBone=AmpFlashBone;
		bAmped=True;
	}
	else
	{
		RangeAtten=default.RangeAtten;
		FlashBone=default.FlashBone;
		bAmped=False;
	}
	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;

}

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (FMPMachinePistol(Weapon) != None && FMPMachinePistol(Weapon).CurrentWeaponMode == 1 && AmpRedFireSound != None)
		Weapon.PlayOwnedSound(AmpRedFireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);
	else if (FMPMachinePistol(Weapon) != None && FMPMachinePistol(Weapon).CurrentWeaponMode == 2 && AmpGreenFireSound != None)
		Weapon.PlayOwnedSound(AmpGreenFireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);
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
	if (BW.MagAmmo - ConsumedLoad < 1)
    {
        BW.IdleAnim = 'IdleClosed';
        BW.ReloadAnim = 'ReloadEmpty';
        AimedFireAnim = 'SightFireClosed';
        FireAnim = 'FireClosed';
    }
    else
    {
        BW.IdleAnim = 'Idle';
        BW.ReloadAnim = 'Reload';
        AimedFireAnim = 'SightFire';
        FireAnim = 'Fire';
    }

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

	if (FMPMachinePistol(Weapon) != None && FMPMachinePistol(Weapon).CurrentWeaponMode == 1 && AmpRedFireSound != None)
		Weapon.PlayOwnedSound(AmpRedFireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);
	else if (FMPMachinePistol(Weapon) != None && FMPMachinePistol(Weapon).CurrentWeaponMode == 2 && AmpGreenFireSound != None)
		Weapon.PlayOwnedSound(AmpGreenFireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

	CheckClipFinished();
	
	if (bAmped)
		FMPMachinePistol(BW).AddHeat(AmpDrainPerShot);
}

// Get aim then run trace...
function DoFireEffect()
{
	Super.DoFireEffect();
	if (Level.NetMode == NM_DedicatedServer)
		FMPMachinePistol(BW).AddHeat(AmpDrainPerShot);
}


function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (Victim.bProjTarget && BallisticShield(Victim) == None && FMPMachinePistol(Weapon).CurrentWeaponMode == 1)
		BW.TargetedHurtRadius(Damage, 256, class'DT_MP40_Incendiary', 200, HitLocation, Pawn(Victim));
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
		
	if ((Other == None || Other.bWorldGeometry) && FMPMachinePistol(Weapon).CurrentWeaponMode == 1)
		BW.TargetedHurtRadius(3, 150, class'DT_MP40_Incendiary', 50, HitLocation);

	// Tell the attachment to spawn effects and so on
	SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
	if (!bAISilent)
		Instigator.MakeNoise(1.0);
	return true;
}

defaultproperties
{
	 AmpDrainPerShot=-0.50
     AmpRedFireSound=SoundGroup'BWBP_SKC_Sounds.MP40.MP40-HotFire'
     AmpGreenFireSound=SoundGroup'BWBP_SKC_Sounds.MP40.MP40-AcidFire'
	 MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
	 MuzzleFlashClassRed=Class'BallisticProV55.M50FlashEmitter'
     MuzzleFlashClassGreen=Class'BallisticProV55.A500FlashEmitter'
	 TraceRange=(Min=9000.000000,Max=9000.000000)
     Damage=25
     RangeAtten=0.700000
     WaterRangeAtten=0.700000
     DamageType=Class'BWBP_SKC_Pro.DT_MP40'
     DamageTypeHead=Class'BWBP_SKC_Pro.DT_MP40Head'
     DamageTypeArm=Class'BWBP_SKC_Pro.DT_MP40'
     KickForce=18000
     HookStopFactor=0.200000
     HookPullForce=-10.000000
     PenetrateForce=150
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-DryFire',Volume=0.700000)
     FlashScaleFactor=0.900000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     FlashBone="tip"
	 AmpFlashBone="tip2"
	 AmpFlashScaleFactor=0.300000
	 FireAnim="Fire"
	 AimedFireAnim="SightFire"
	 EmptyFireAnim="FireClosed"
	 EmptyAimedFireAnim="SightFireClosed"
     BrassOffset=(X=-50.000000,Y=1.000000)
     FireRecoil=90.000000
     XInaccuracy=32.000000
     YInaccuracy=32.000000
	 FireChaos=0.030000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.MP40.MP40-Fire',Volume=1.200000)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.105000
     AmmoClass=Class'BallisticProV55.Ammo_XRS10Bullets'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     aimerror=900.000000
}
