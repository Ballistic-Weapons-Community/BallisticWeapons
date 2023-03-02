//=============================================================================
// A2-W Primary Fire
// Azarael note: This is pretty bright. Maybe use this elsewhere
//=============================================================================
class A2WPrimaryFire extends BallisticProInstantFire;

defaultproperties
{
     TraceRange=(Min=8000.000000,Max=8000.000000)
     WallPenetrationForce=8.000000
     Damage=50.000000
     PenetrateForce=140
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
	 FlashScaleFactor=0.100000
     FireRecoil=150.000000
     FireChaos=0.300000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-SecFire',Volume=0.800000)
     FireEndAnim=
     FireRate=0.300000
     AmmoClass=Class'BallisticProV55.Ammo_Cells'
     ShakeRotMag=(X=200.000000,Y=16.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=-2.500000)
     ShakeOffsetRate=(X=-500.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.99
     WarnTargetPct=0.30000
     aimerror=800.000000
}
