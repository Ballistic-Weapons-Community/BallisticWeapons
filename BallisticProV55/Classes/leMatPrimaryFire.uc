//=============================================================================
// leMatPrimaryFire.
//
// Medium power bullet fire for the Wilson DB 41 Revolver
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class leMatPrimaryFire extends BallisticRangeAttenFire;

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
     CutOffDistance=3072.000000
     CutOffStartRange=768.000000
     TraceRange=(Min=8000.000000,Max=8000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=24.000000
     MaxWalls=2
     Damage=35.000000
     DamageHead=70.000000
     DamageLimb=35.000000
     RangeAtten=0.250000
     WaterRangeAtten=0.600000
     DamageType=Class'BallisticProV55.DTleMatRevolver'
     DamageTypeHead=Class'BallisticProV55.DTleMatrevolverHead'
     DamageTypeArm=Class'BallisticProV55.DTleMatRevolver'
     KickForce=30000
     PenetrateForce=150
     bPenetrate=True
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.600000)
     MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
     FlashScaleFactor=0.600000
     AimedFireAnim="SightFire"
     RecoilPerShot=1024.000000
     FireChaos=0.300000
     XInaccuracy=128.000000
     YInaccuracy=128.000000
     BallisticFireSound=(Sound=Sound'BWBP4-Sounds.leMat.LM-Fire',Volume=1.200000)
     FireEndAnim=
     AmmoClass=Class'BallisticProV55.Ammo_leMat'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
