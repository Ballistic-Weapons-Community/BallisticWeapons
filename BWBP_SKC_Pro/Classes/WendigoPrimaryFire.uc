//=============================================================================
// CYLOPrimaryFire.
//
// For some really odd reason my UDE isn't liking the class names, so I have to
// change the names for UDE to recognize them every once in a while...
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class WendigoPrimaryFire extends BallisticProInstantFire;

defaultproperties
{
	TraceRange=(Min=8000.000000,Max=12000.000000)
	WallPenetrationForce=24.000000
	
	Damage=35.000000

	RangeAtten=0.650000
	WaterRangeAtten=0.800000
	DamageType=Class'BWBP_SKC_Pro.DTCYLORifle'
	DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLORifleHead'
	DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLORifle'
	PenetrateForce=180
	bPenetrate=True
	RunningSpeedThresh=1000.000000
	ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-1',Volume=0.800000,Radius=48.000000,bAtten=True)
	DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryRifle',Volume=0.700000)
	bCockAfterEmpty=True
	MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
	FlashBone="tip"
	FlashScaleFactor=0.500000
	FireRecoil=220.000000
	FireChaos=0.032000
	FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
	XInaccuracy=64.000000
	YInaccuracy=64.000000
	BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.LS14-CarbineFire',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
	bPawnRapidFireAnim=True
	PreFireAnim=
	FireEndAnim=
	FireRate=0.063150
	AmmoClass=Class'BWBP_SKC_Pro.Ammo_CYLO'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-3.00)
	ShakeOffsetRate=(X=-70.000000)
	ShakeOffsetTime=2.000000

	WarnTargetPct=0.200000
	aimerror=900.000000
}
