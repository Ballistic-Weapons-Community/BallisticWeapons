//=============================================================================
// BOGPSecondaryFire.
//
// A grenade that bonces off walls and detonates a certain time after impact
// Good for scaring enemies out of dark corners and not much else
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class BOGPSecondaryFire extends BallisticFire;

simulated function bool AllowFire()
{
	if (BOGPPistol(BW).IsSlave())
		return false;
		
	return Super.AllowFire();
}

event ModeDoFire()
{
	if (Weapon.Role == ROLE_Authority)
		BOGPPistol(Weapon).ServerSwitchFlare(!BOGPPistol(Weapon).bUseFlare);
}

// It's over, dk.
simulated function vector GetFireSpread()
{
	local float fX;
    local Rotator R;

	if (BW.bScopeView)
		return super(BallisticProjectileFire).GetFireSpread();

	fX = frand();
	R.Yaw =  1024 * sin (FMin(sqrt(frand()), 1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
	if (frand() > 0.5)
		R.Yaw = -R.Yaw;
	R.Pitch = 1024 * sin (FMin(sqrt(frand()), 1)  * 1.5707963267948966) * cos(fX*1.5707963267948966);
	if (frand() > 0.5)
		R.Pitch = -R.Pitch;
	return Vector(R);
}

defaultproperties
{
     bUseWeaponMag=False
     EffectString="Switch grenade"
     bWaitForRelease=True
     FireRate=0.200000
     AmmoClass=Class'BallisticProV55.Ammo_BOGPGrenades'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
