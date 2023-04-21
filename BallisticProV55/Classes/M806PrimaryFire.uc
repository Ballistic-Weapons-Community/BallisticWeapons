//=============================================================================
// M806PrimaryFire.
//
// Decent pistol shots that are accurate if the gun is steady enough
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M806PrimaryFire extends BallisticProInstantFire;

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'OpenIdle';
		BW.ReloadAnim = 'OpenReload';
		AimedFireAnim = 'SightFireOpen';
		FireAnim = 'OpenFire';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		AimedFireAnim = 'SightFire';
		FireAnim = 'Fire';
	}
	super.PlayFiring();
}

defaultproperties
{
     TraceRange=(Min=4000,Max=4000)
     WallPenetrationForce=8.000000
     DamageType=Class'BallisticProV55.DTM806Pistol'
     DamageTypeHead=Class'BallisticProV55.DTM806PistolHead'
     DamageTypeArm=Class'BallisticProV55.DTM806Pistol'
     PenetrateForce=150
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticProV55.M806FlashEmitter'
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassBone="tip"
     BrassOffset=(X=-30.000000,Y=1.000000)
     FireRecoil=256.000000
     FireChaos=0.2
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Fire',Volume=0.700000)
     FireEndAnim=
	 AimedFireAnim="SightFire"
     FireRate=0.25000
     FireAnimRate=2
     AmmoClass=Class'BallisticProV55.Ammo_45HV'

     ShakeRotMag=(X=72.000000)
     ShakeRotRate=(X=1080.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-10.00)
     ShakeOffsetRate=(X=-200.00)
     ShakeOffsetTime=2.000000

     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
