//=============================================================================
// MarlinPrimaryFire.
//
// Accurate rifle fire for Deermaster
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MarlinPrimaryFire extends BallisticRangeAttenFire;

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

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

	CheckClipFinished();
}

defaultproperties
{
	 CutOffStartRange=3072
	 CutOffDistance=6144
	 RangeAtten=0.75
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WallPenetrationForce=24.000000
     
     Damage=80.000000
     DamageHead=160.000000
     DamageLimb=80.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DTMarlinRifle'
     DamageTypeHead=Class'BallisticProV55.DTMarlinRifleHead'
     DamageTypeArm=Class'BallisticProV55.DTMarlinRifle'
     KickForce=6000
     PenetrateForce=150
     bPenetrate=True
     bCockAfterFire=True
     MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     bBrassOnCock=True
     BrassOffset=(X=-70.000000,Y=-12.000000,Z=10.000000)
     AimedFireAnim="SightFireCock"
     RecoilPerShot=768.000000
     FireChaos=0.800000
     BallisticFireSound=(Sound=Sound'BWBP4-Sounds.Marlin.Mar-Fire')
     FireEndAnim=
     FireAnimRate=1.250000
     FireRate=0.750000
     AmmoClass=Class'BallisticProV55.Ammo_Marlin'
     ShakeRotMag=(X=400.000000,Y=32.000000)
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
	 BotRefireRate=0.7
     WarnTargetPct=0.5
}
