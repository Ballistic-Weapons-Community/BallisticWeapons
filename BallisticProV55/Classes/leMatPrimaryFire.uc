//=============================================================================
// leMatPrimaryFire.
//
// Medium power bullet fire for the Wilson DB 41 Revolver
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class leMatPrimaryFire extends BallisticProInstantFire;

function ServerPlayFiring()
{
	super.ServerPlayFiring();
	leMatRevolver(Weapon).RevolverFired();
}

//Do the spread on the client side
function PlayFiring()
{
	super.PlayFiring();
	leMatRevolver(Weapon).RevolverFired();
}

defaultproperties
{
     DecayRange=(Min=768,Max=2816)
     TraceRange=(Min=8000.000000,Max=8000.000000)
     DamageType=Class'BallisticProV55.DTleMatRevolver'
     DamageTypeHead=Class'BallisticProV55.DTleMatrevolverHead'
     DamageTypeArm=Class'BallisticProV55.DTleMatRevolver'
     PenetrateForce=150
     bPenetrate=True
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-DryFire',Volume=0.600000)
     MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
     FlashScaleFactor=0.600000
     AimedFireAnim="SightFire"
     FireRecoil=300.000000
     FireChaos=0.0400000
     XInaccuracy=64.000000
     YInaccuracy=64.000000
	 FireAnimRate=1.5
	 FireRate=0.32
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-Fire',Volume=1.200000)
     FireEndAnim=
     AmmoClass=Class'BallisticProV55.Ammo_leMat'
	 
     ShakeRotMag=(X=48.000000)
     ShakeRotRate=(X=640.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-8.00)
     ShakeOffsetRate=(X=-160.000000)
     ShakeOffsetTime=2.000000
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.9
     WarnTargetPct=0.35
}
