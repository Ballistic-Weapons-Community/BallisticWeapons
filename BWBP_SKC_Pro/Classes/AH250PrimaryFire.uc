//=============================================================================
// AH250 primary fire.
// For the scoped Eagle.
//=============================================================================
class AH250PrimaryFire extends BallisticProInstantFire;

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'OpenIdle';
		BW.ReloadAnim = 'OpenReload';
          AimedFireAnim = 'OpenSightFire';
		FireAnim = 'OpenFire';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
          AimedFireAnim= 'SightFire';
		FireAnim = 'Fire';
	}
	super.PlayFiring();
}

defaultproperties
{
     TraceRange=(Min=8000.000000,Max=9000.000000)
     DamageType=Class'BWBP_SKC_Pro.DTAH250Pistol'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTAH250PistolHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTAH250Pistol'
     PenetrateForce=200
     bPenetrate=True
     AimedFireAnim='SightFire'
     MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
     FlashScaleFactor=0.500000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassBone="tip"
     BrassOffset=(X=-30.000000,Y=1.000000)
     FireRecoil=512.000000
     FirePushbackForce=150.000000
     FireChaos=0.200000
     XInaccuracy=2.000000
     YInaccuracy=2.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-Fire3',Volume=4.100000)
     FireEndAnim=
     FireRate=0.40000
     AmmoClass=Class'BallisticProV55.Ammo_44Magnum'

	ShakeRotMag=(X=64.000000)
	ShakeRotRate=(X=960.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-8.00)
	ShakeOffsetRate=(X=-100.000000)
	ShakeOffsetTime=2.000000

     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
