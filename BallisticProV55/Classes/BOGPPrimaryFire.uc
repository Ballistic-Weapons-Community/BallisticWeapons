//=============================================================================
// BOGPPrimaryFire.
//
// Fires either an explode on impact grenade, or a burning hot flare to set players ablaze!
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class BOGPPrimaryFire extends BallisticProProjectileFire;

var() BUtil.FullSound			FlareFireSound;

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
	if (!BOGPPistol(BW).CheckGrenade())
		return;
	Super.ModeDoFire();
}

function PlayFiring()
{
	BOGPPistol(Weapon).bHideHead = true;

	Super.PlayFiring();
}

defaultproperties
{
     bCockAfterFire=True
     bUseWeaponMag=False
     FlashBone="Muzzle"
     bTossed=True
     bModeExclusive=False
     FireForce="AssaultRifleAltFire"
     AmmoClass=Class'BallisticProV55.Ammo_BOGPGrenades'

     ShakeRotMag=(X=72.000000)
     ShakeRotRate=(X=1080.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-10.00)
     ShakeOffsetRate=(X=-200.000000)
     ShakeOffsetTime=2.000000

     BotRefireRate=0.300000
}
