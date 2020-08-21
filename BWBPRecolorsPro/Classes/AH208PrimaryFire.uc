//=============================================================================
// AH208PrimaryFire.
// The Pro equivalent of the Golden Gun.
//=============================================================================
class AH208PrimaryFire extends BallisticRangeAttenFire;

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'OpenIdle';
          BW.ReloadAnim = 'OpenReload';
          
          if (BW.bScopeView)
               FireAnim = 'OpenSightFire';
          else 
               FireAnim = 'OpenFire';
	}
	else
	{
		BW.IdleAnim = 'Idle';
          BW.ReloadAnim = 'Reload';
          
          if (BW.bScopeView)
               FireAnim='SightFire';
          else
               FireAnim = 'Fire';
	}
	super.PlayFiring();
}

defaultproperties
{
     CutOffDistance=3072.000000
     CutOffStartRange=1536.000000
     TraceRange=(Min=6000.000000,Max=6000.000000)
     WallPenetrationForce=16.000000
     
     Damage=90.000000
     DamageHead=115.000000
     DamageLimb=90.000000
     RangeAtten=0.350000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPRecolorsPro.DTAH208Pistol'
     DamageTypeHead=Class'BWBPRecolorsPro.DTAH208PistolHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DTAH208Pistol'
     KickForce=2500
     PenetrateForce=200
     bPenetrate=True
     AimedFireAnim='SightFire'
     MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
     FlashScaleFactor=0.500000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassBone="tip"
     BrassOffset=(X=-30.000000,Y=1.000000)
     RecoilPerShot=768.000000
     VelocityRecoil=300.000000
     FireChaos=0.350000
     XInaccuracy=32.000000
     YInaccuracy=32.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4ProExp.Eagle.Eagle-Fire4',Volume=4.100000)
     FireEndAnim=
     FireRate=0.650000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_44Gold'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
