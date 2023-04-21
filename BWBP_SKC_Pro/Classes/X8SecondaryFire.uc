//=============================================================================
// X8 secondary fire.
//
// Launches a ballistic knife.
//=============================================================================
class X8SecondaryFire extends BallisticProjectileFire;

defaultproperties
{
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-KnifeFire',Radius=32.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     bWaitForRelease=True
     PreFireAnim="PrepShoot"
     FireAnim="Shoot"
     FireRate=1.700000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_X8Knife'
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-7.00)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBP_SKC_Pro.X8ProjectileHeld'
}
