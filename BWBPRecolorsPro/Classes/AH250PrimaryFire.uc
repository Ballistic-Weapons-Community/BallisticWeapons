//=============================================================================
// AH250 primary fire.
// For the scoped Eagle.
//=============================================================================
class AH250PrimaryFire extends BallisticRangeAttenFire;

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'OpenIdle';
		BW.ReloadAnim = 'OpenReload';
		FireAnim = 'OpenFire';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		FireAnim = 'Fire';
	}
	super.PlayFiring();
}

defaultproperties
{
     CutOffDistance=4096.000000
     CutOffStartRange=2048.000000
     TraceRange=(Min=8000.000000,Max=9000.000000)
     WallPenetrationForce=16.000000
     
     Damage=50.000000
     DamageHead=75.000000
     DamageLimb=50.000000
     RangeAtten=0.50000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPRecolorsPro.DTAH250Pistol'
     DamageTypeHead=Class'BWBPRecolorsPro.DTAH250PistolHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DTAH250Pistol'
     KickForce=2500
     PenetrateForce=200
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
     FlashScaleFactor=0.500000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassBone="tip"
     BrassOffset=(X=-30.000000,Y=1.000000)
     FireRecoil=768.000000
     FirePushbackForce=150.000000
     FireChaos=0.200000
     XInaccuracy=8.000000
     YInaccuracy=8.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.Eagle.Eagle-Fire3',Volume=4.100000)
     FireEndAnim=
     FireRate=0.40000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_44MagnumScope'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
