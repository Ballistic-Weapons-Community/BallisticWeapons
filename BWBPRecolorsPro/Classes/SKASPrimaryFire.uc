//=============================================================================
// M763PrimaryFire.
//
// Powerful shotgun blast with moderate spread and fair range for a shotgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SKASPrimaryFire extends BallisticProShotgunFire;
var() sound		SuperFireSound;
var() sound		ClassicFireSound;
var() sound		UltraFireSound;
var() sound		XR4FireSound;

simulated function SwitchWeaponMode (byte NewMode)
{
	if (NewMode == 2)
	{
		BallisticFireSound.Sound=SuperFireSound;
		FireRate=1.75;
		FireAnim='SemiFire';
		FireAnimRate=1.45;
    	KickForce=13000;
		RecoilPerShot=1536;
     	FireChaos=0.5;
     	FlashScaleFactor=2;
     	XInaccuracy=100.000000;
     	YInaccuracy=100.000000;
		CutOffDistance=4096;
		CutOffStartRange=2048;
	}
	
	else
	{
		FireRate=default.FireRate;
		RangeAtten=Default.RangeAtten;
		BallisticFireSound.Sound=default.BallisticFireSound.Sound;
		FireAnim=default.FireAnim;
		KickForce=Default.KickForce;
		RecoilPerShot=Default.RecoilPerShot;
     	FireChaos=Default.FireChaos;
		bCockAfterFire=False;
     	XInaccuracy=default.XInaccuracy;
     	YInaccuracy=default.YInaccuracy;
		CutOffDistance=	Default.CutOffDistance;
		CutOffStartRange=Default.CutOffStartRange;
	}
}


simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

defaultproperties
{
     SuperFireSound=Sound'PackageSounds4Pro.SKAS.SKAS-Power'
     ClassicFireSound=Sound'PackageSounds4Pro.SKAS.SKAS-Classic'
     UltraFireSound=Sound'PackageSounds4Pro.SKAS.SKAS-Ultra2'
     XR4FireSound=Sound'PackageSounds4Pro.XR4.XR4-Fire'
     CutOffDistance=3072.000000
     CutOffStartRange=1280.000000
     TraceCount=7
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=7000.000000,Max=7000.000000)
     Damage=13.000000
     DamageHead=26.000000
     DamageLimb=13.000000
     RangeAtten=0.250000
     DamageType=Class'BWBPRecolorsPro.DTSKASShotgun'
     DamageTypeHead=Class'BWBPRecolorsPro.DTSKASShotgunHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DTSKASShotgun'
     KickForce=10000
     PenetrateForce=100
     bPenetrate=True
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     BrassClass=Class'BallisticProV55.Brass_MRS138Shotgun'
     BrassOffset=(X=-1.000000,Z=-1.000000)
     RecoilPerShot=450.000000
     VelocityRecoil=180.000000
     FireChaos=0.300000
     XInaccuracy=310.000000
     YInaccuracy=310.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.SKAS.SKAS-Single',Volume=1.300000)
     FireAnim="FireRot"
     FireEndAnim=
     FireAnimRate=1.500000
     FireRate=0.300000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_SKASShells'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.400000
}
