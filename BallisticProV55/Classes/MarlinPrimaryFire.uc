//=============================================================================
// MarlinPrimaryFire.
//
// Accurate rifle fire for Deermaster
// Has a layout for charged gauss shots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MarlinPrimaryFire extends BallisticProInstantFire;


var() 	BUtil.FullSound			GaussSound;	//extra Gauss sound to play
var 	bool					bGauss;


//// server propagation of firing ////
function ServerPlayFiring()
{
	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	if (GaussSound.Sound != None && bGauss)
		Weapon.PlayOwnedSound(GaussSound.Sound,GaussSound.Slot,GaussSound.Volume,GaussSound.bNoOverride,GaussSound.Radius,GaussSound.Pitch,GaussSound.bAtten);

	CheckClipFinished();

	if (AimedFireAnim != '')
	{
		if (!BW.bScopeView)
			BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
		else
			BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, , "AIMEDFIRE");
	}

	else
	{
		if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
			BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
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
		if (!BW.bScopeView)
			BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
		else
			BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, , "AIMEDFIRE");
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

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	if (GaussSound.Sound != None && bGauss)
		Weapon.PlayOwnedSound(GaussSound.Sound,GaussSound.Slot,GaussSound.Volume,GaussSound.bNoOverride,GaussSound.Radius,GaussSound.Pitch,GaussSound.bAtten);

	CheckClipFinished();
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
		
	bGauss = (MarlinRifle(BW).bHasGauss && MarlinRifle(BW).GaussLevel == MarlinRifle(BW).MaxGaussLevel);

	super.ModeDoFire();
	
	if (bGauss)
	{
		MarlinRifle(BW).GaussGlow1.bHidden=true;
		MarlinRifle(BW).GaussGlow2.bHidden=true;
		MarlinRifle(BW).GaussLevel = 0;			
		MarlinRifle(BW).ServerSwitchWeaponMode(0);
		MarlinRifle(BW).ClientSwitchWeaponMode(0);
	}
}

simulated function SendFireEffect(Actor Other, Vector HitLocation, Vector HitNormal, int Surf, optional Vector WaterHitLoc)
{
	MarlinAttachment(Weapon.ThirdPersonActor).bGauss = bGauss;
	super.SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
}


defaultproperties
{
	 GaussSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-FireStart2',Volume=0.800000,Radius=1024.000000,Pitch=1.000000,bNoOverride=True)
	 RangeAtten=0.75
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WallPenetrationForce=24.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DTMarlinRifle'
     DamageTypeHead=Class'BallisticProV55.DTMarlinRifleHead'
     DamageTypeArm=Class'BallisticProV55.DTMarlinRifle'
     PenetrateForce=150
     bPenetrate=True
     bCockAfterFire=True
     MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     bBrassOnCock=True
     BrassOffset=(X=-70.000000,Y=-12.000000,Z=10.000000)
     AimedFireAnim="SightFireCock"
     FireRecoil=768.000000
     FireChaos=0.800000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.Marlin.Mar-Fire')
     FireEndAnim=
     FireAnimRate=1.150000
     FireRate=0.80000
     AmmoClass=Class'BallisticProV55.Ammo_Marlin'

     ShakeRotMag=(X=72.000000)
     ShakeRotRate=(X=1080.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-10.00)
     ShakeOffsetRate=(X=-200.00)
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
