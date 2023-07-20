//=============================================================================
// AK-490's primary fire.
//
// Assault rifle fire.
// DPS is greater than normal, but so too is recoil.
//=============================================================================
class AK490PrimaryFire extends BallisticProInstantFire;

defaultproperties
{
	TraceRange=(Min=12000.000000,Max=13000.000000)

	DamageType=Class'BWBP_SKC_Pro.DT_AK490Bullet'
	DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK490BulletHead'
	DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK490Bullet'
	PenetrateForce=180
	bPenetrate=True
	DryFireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-DryFire',Volume=0.700000)
	MuzzleFlashClass=Class'AK490FlashEmitter'
	FlashScaleFactor=0.800000
	BrassClass=Class'BallisticProV55.Brass_Rifle'
	BrassBone="tip"
	BrassOffset=(X=-80.000000,Y=1.000000)
	FireRecoil=192.000000
	FireChaos=0.04000
	FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
	XInaccuracy=48.000000
	YInaccuracy=48.000000
	BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AK47.AK47-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	bPawnRapidFireAnim=True
	FireEndAnim=
	FireRate=0.11000
	AmmoClass=Class'BWBP_SKC_Pro.Ammo_AK762mm'

	ShakeRotMag=(X=32.000000)
	ShakeRotRate=(X=480.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-10.00)
	ShakeOffsetRate=(X=-200.00)
	ShakeOffsetTime=2.000000

	WarnTargetPct=0.200000
	aimerror=900.000000
}
