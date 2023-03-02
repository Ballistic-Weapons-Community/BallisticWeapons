//=============================================================================
// M99SecondaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class M99SecondaryFire extends BallisticFire;

event ModeDoFire()
{
	if (Weapon.Role == ROLE_Authority)
		M99Rifle(Weapon).InitLaser();
}

defaultproperties
{
     bUseWeaponMag=False
     //EffectString="Laser sight"
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.700000
     AmmoClass=Class'BWBP_JCF_Pro.Ammo_50ECSRifle'
     AmmoPerFire=0
     BotRefireRate=0.300000
}