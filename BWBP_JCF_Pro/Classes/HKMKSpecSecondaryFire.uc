//=============================================================================
// HKMKSpecSecondaryFire.
//
// A semi-auto shotgun that uses its own magazine.
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HKMKSpecSecondaryFire extends BallisticProShotgunFire;

//===========================================================================
// AllowFire
//
// Check alternate magazine.
//===========================================================================
simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (HKMKSpecPistol(BW).AltAmmo < 1)
	{
		if (!bPlayedDryFire && DryFireSound.Sound != None)
		{
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			bPlayedDryFire=true;
		}
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		BW.EmptyFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
    return true;
}

function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'IdleOpen';
		BW.ReloadAnim = 'ReloadOpen';
		AimedFireAnim = 'SightFireAltOpen';
		FireAnim = 'FireAltOpen';
		HKMKSpecPistol(BW).ReloadAltAnim = 'ReloadAltOpen';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		AimedFireAnim = 'SightFireAlt';
		FireAnim = 'FireAlt';
		HKMKSpecPistol(BW).ReloadAltAnim = 'ReloadAlt';
	}

	if (HKMKSpecPistol(Weapon).bSilenced)
		Weapon.SetBoneScale (0, 1.0, HKMKSpecPistol(Weapon).SilencerBone);
	else
		Weapon.SetBoneScale (0, 0.0, HKMKSpecPistol(Weapon).SilencerBone);

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
	
	if (HKMKSpecPistol(Weapon) != None && HKMKSpecPistol(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

	CheckClipFinished();
}

//===========================================================================
// DoFireEffect
//
// Decrement weapon's dart reserve on fire.
//===========================================================================
function DoFireEffect()
{
	Super.DoFireEffect();
	HKMKSpecPistol(BW).AltAmmo--;
}

defaultproperties
{
     FlashBone="tip3"
	 DecayRange=(Min=1024,Max=1536)
     TraceCount=9
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=5000.000000,Max=5000.000000)
     Damage=4.000000
     
     
     RangeAtten=0.750000
     DamageType=Class'BWBP_SKC_Pro.DTCYLOShotgun'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLOShotgunHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLOShotgun'
     KickForce=400
     PenetrateForce=100
     bPenetrate=True
     bUseWeaponMag=False
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     bBrassOnCock=True
     BrassOffset=(X=-30.000000,Y=-5.000000,Z=5.000000)
     FireRecoil=512.000000
     FirePushbackForce=150.000000
     FireChaos=0.500000
     XInaccuracy=350.000000
     YInaccuracy=350.000000
     JamSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-1',Volume=0.900000)
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-FireSG',Volume=1.300000,Radius=256.000000)
     //bWaitForRelease=True
     FireAnim="FireSG"
     FireEndAnim=
     FireRate=0.700000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_CYLOSG'
     AmmoPerFire=0
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.700000
     WarnTargetPct=0.500000
}
