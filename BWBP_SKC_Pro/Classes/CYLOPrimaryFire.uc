//=============================================================================
// CYLOPrimaryFire.
//
// For some really odd reason my UDE isn't liking the class names, so I have to
// change the names for UDE to recognize them every once in a while...
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CYLOPrimaryFire extends BallisticProInstantFire;

var() sound		RifleFireSound;
var() sound		MeleeFireSound;
var	bool	    bVariableFirerate;

simulated event ModeDoFire()
{
	if (bVariableFirerate)
	{
		if (level.Netmode == NM_Standalone)
		{
			FireRate = Params.FireInterval + (FRand() * 0.15);
		}
		else
		{
			FireRate = Params.FireInterval * 2.0;
		}
	}
	Super.ModeDoFire();
}

defaultproperties
{
     RifleFireSound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-Fire'
     MeleeFireSound=Sound'BW_Core_WeaponSound.A73.A73Stab'
     TraceRange=(Min=8000.000000,Max=12000.000000)
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
     FlashBone="Muzzle"
     FlashScaleFactor=0.500000
     FireRecoil=220.000000
     FireChaos=0.032000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=96.000000
     YInaccuracy=96.000000
     JamSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryRifle',Volume=0.900000)
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-Fire',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     PreFireAnim=
     FireEndAnim=
     FireRate=0.1050000
     UnjamMethod=UJM_Fire
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_CYLO'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
