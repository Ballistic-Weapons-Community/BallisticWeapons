//=============================================================================
// Raygun Primary Fire.
//=============================================================================
class RaygunPrimaryFire extends BallisticProProjectileFire;

simulated function ModeDoFire()
{
	if (Level.NetMode != NM_Client)
		Raygun(BW).bLockSecondary=True;
	Super.ModeDoFire();
}	

defaultproperties
{
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BWBPOtherPackPro.RaygunMuzzleFlashAlt'
     FlashScaleFactor=2.500000
     AimedFireAnim="SightFire"
     RecoilPerShot=100.000000
     FireChaos=0.070000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     BallisticFireSound=(Sound=Sound'BWBPOtherPackSound.Raygun.Raygun-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireAnim="FireSmall"
     FireEndAnim=
     FireRate=0.150000
     AmmoClass=Class'BWBPOtherPackPro.Ammo_RaygunCells'
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBPOtherPackPro.RaygunProjectile'
     BotRefireRate=0.70000
     WarnTargetPct=0.200000
}
