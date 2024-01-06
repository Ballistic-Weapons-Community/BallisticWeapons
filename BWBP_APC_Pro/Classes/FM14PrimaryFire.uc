//=============================================================================
// M763PrimaryFire.
//
// Powerful, ranged shotgun blast.
// Now automatic, due to inability to balance it any other way.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FM14PrimaryFire extends BallisticProShotgunFire;

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing
	
	if (BW.MagAmmo < AmmoPerFire)
	{
		if (!bPlayedDryFire && DryFireSound.Sound != None)
		{
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			bPlayedDryFire=true;
		}
		if (bDryUncock)
			BW.bNeedCock=true;
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		BW.EmptyFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
	else if (BW.bNeedReload)
		return false;
	else if (BW.bNeedCock || FM14Shotgun(BW).bAltLoaded)
		return false;		// Alt's loaded or needs cocking
    return true;
}

function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		AimedFireAnim = 'SightfireNoCock';
		FireAnim = 'FireNoCock';
	}
	else
	{
		AimedFireAnim='Sightfire';
		FireAnim = 'Fire';
	}
	super.PlayFiring();
}

function ServerPlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		AimedFireAnim = 'SightfireNoCock';
		FireAnim = 'FireNoCock';
	}
	else
	{
		AimedFireAnim='Sightfire';
		FireAnim = 'Fire';
	}
	super.ServerPlayFiring();
}

simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	BW.TargetedHurtRadius(5, 96, DamageType, 1, HitLocation,Pawn(Other));
	return super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
}

defaultproperties
{
     HipSpreadFactor=3.000000
	 DecayRange=(Min=1562,Max=3124)
     TraceCount=1
     TracerClass=Class'BWBP_APC_Pro.TraceEmitter_ShotgunFlame'
     ImpactManager=Class'BWBP_APC_Pro.IM_FireShot'
     TraceRange=(Min=3072.000000,Max=3072.000000)
     Damage=80.000000
     RangeAtten=0.15000
     DamageType=Class'BWBP_APC_Pro.DTFM14Shotgun'
     DamageTypeHead=Class'BWBP_APC_Pro.DTFM14ShotgunHead'
     DamageTypeArm=Class'BWBP_APC_Pro.DTFM14Shotgun'
     KickForce=5000
     PenetrateForce=0
	 bPenetrate=False
	 WallPenetrationForce=0
     MuzzleFlashClass=Class'BWBP_APC_Pro.FM14FlashEmitter'
     FlashScaleFactor=1.000000
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     BrassOffset=(X=-1.000000,Z=-1.000000)
     AimedFireAnim="FireCombinedSight"
     FireRecoil=768.000000
     FireChaos=0.30000
     XInaccuracy=150.000000
     YInaccuracy=150.000000
     BallisticFireSound=(Sound=Sound'BWBP_OP_Sounds.FM13.FM13-Fire',Volume=1.300000)
     FireAnim="FireCombined"
     FireEndAnim=
     FireAnimRate=0.9
     FireRate=0.85
     AmmoClass=Class'BWBP_APC_Pro.Ammo_FM14SlugGauge'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.7
     WarnTargetPct=0.5
}
