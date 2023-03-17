//=============================================================================
// GRSXXPrimaryFire.
//
// High power, controllable gauss glock fire.
// Realism mode has a removable amp.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class GRSXXPrimaryFire extends BallisticProInstantFire;

var(GRSXX) Actor					MuzzleFlashNaked;		
var(GRSXX) class<Actor>				MuzzleFlashClassNaked;	
var(GRSXX) Name						NakedFlashBone;
var(GRSXX) float					NakedFlashScaleFactor;
var(GRSXX) bool						bAmped;
var(GRSXX) float					AmpDrainPerShot;
var(GRSXX) bool						bRemovableAmp;

// Effect related functions ------------------------------------------------
// Spawn the muzzleflash actor
function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if ((MuzzleFlashClassNaked != None) && ((MuzzleFlashNaked == None) || MuzzleFlashNaked.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashNaked, MuzzleFlashClassNaked, Weapon.DrawScale*NakedFlashScaleFactor, weapon, NakedFlashBone);

}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;

    if (MuzzleFlashNaked != None && GRSXXPistol(Weapon).CurrentWeaponMode != 3 && bRemovableAmp)
       	MuzzleFlashNaked.Trigger(Weapon, Instigator);
	else
		MuzzleFlash.Trigger(Weapon, Instigator);
		
	if (!bBrassOnCock)
		EjectBrass();
}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashNaked);
}

simulated function SwitchWeaponMode (byte NewMode)
{
	if (NewMode != 3 && bRemovableAmp) //Realism amp is limited
	{
		FlashBone=NakedFlashBone;
		bAmped=False;
	}
	else if (NewMode == 3) //Damage Amp
	{
		FlashBone=FlashBone;
		bAmped=True;
	}
	else // Regular gun is always amped
	{
		FlashBone=FlashBone;
		bAmped=True;
	}
	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;
}


//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'OpenIdle';
		BW.ReloadAnim = 'OpenReload';
		GRSXXPistol(BW).AmplifierOnAnim = 'AMPApplyOpen';
		GRSXXPistol(BW).AmplifierOffAnim = 'AMPRemoveOpen';
		AimedFireAnim = 'SightFireOpen';
		FireAnim = 'OpenFire';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		GRSXXPistol(BW).AmplifierOnAnim = 'AMPApply';
		GRSXXPistol(BW).AmplifierOffAnim = 'AMPRemove';
		AimedFireAnim = 'SightFire';
		FireAnim = 'Fire';
	}
	super.PlayFiring();
	if (bAmped && bRemovableAmp)
		GRSXXPistol(BW).AddHeat(AmpDrainPerShot);
}

// Get aim then run trace...
function DoFireEffect()
{
	Super.DoFireEffect();
	if (Level.NetMode == NM_DedicatedServer && bAmped && bRemovableAmp)
		GRSXXPistol(BW).AddHeat(AmpDrainPerShot);
}

defaultproperties
{
	 bAmped=True
	 AmpDrainPerShot=-0.15
	 NakedFlashBone="Muzzle2"
     NakedFlashScaleFactor=1.500000
	 
	 DecayRange=(Min=768,Max=2304)
     TraceRange=(Min=4000.000000,Max=4000.000000)
     WallPenetrationForce=8.000000
     
     Damage=24.000000
     HeadMult=1.4f
     LimbMult=0.5f
     
     RangeAtten=0.200000
     WaterRangeAtten=0.500000
     DamageType=Class'BWBP_SKC_Pro.DTGRSXXPistol'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTGRSXXPistolHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTGRSXXPistol'
     PenetrateForce=100
     bPenetrate=True
     MuzzleFlashClass=Class'BWBP_SKC_Pro.GRSXXFlashEmitter'
	 MuzzleFlashClassNaked=Class'BallisticProV55.XK2FlashEmitter_C'
     FlashScaleFactor=2.500000
     BrassClass=Class'BallisticProV55.Brass_GRSNine'
     BrassBone="tip"
     BrassOffset=(X=-30.000000,Y=1.000000)
     FireRecoil=150.000000
     FireChaos=0.120000
     XInaccuracy=72.000000
     YInaccuracy=72.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.Glock_Gold.GRSXX-Fire',Volume=1.100000)
     FireEndAnim=
	 AimedFireAnim='SightFire'
     FireAnimRate=1.700000
     FireRate=0.050000
     AmmoClass=Class'BallisticProV55.Ammo_GRSNine'
     ShakeRotMag=(X=64.000000,Y=32.000000)
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
     BotRefireRate=0.99
     WarnTargetPct=0.2
}
