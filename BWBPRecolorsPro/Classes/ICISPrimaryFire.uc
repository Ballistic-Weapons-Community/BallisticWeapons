//=============================================================================
// ICISPrimaryFire.
//
// Self injection with the stimulant pack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ICISPrimaryFire extends BallisticFire;

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing

	return Weapon.AmmoAmount(ThisModeNum) > 0;
}

defaultproperties
{
     BallisticFireSound=(Sound=SoundGroup'BallisticSounds_25.X4.X4_Melee',Radius=4.000000,bAtten=True)
     bAISilent=True
     EffectString="80 temporary HP"
     bFireOnRelease=True
     bWaitForRelease=True
     PreFireAnim="PrepSelfMedicate"
     FireAnim="SelfMedicate"
     FireRate=1.700000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_ICISStim'
     AmmoPerFire=0
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
}
