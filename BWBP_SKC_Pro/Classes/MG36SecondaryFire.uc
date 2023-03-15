//=============================================================================
// MG36SecondaryFire.
//
// Silencer
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MG36SecondaryFire extends BallisticFire;

simulated event ModeDoFire()
{
    if (!Instigator.IsLocallyControlled())
    	return;
		MG36Carbine(Weapon).SwitchSilencer();
}

defaultproperties
{
     bUseWeaponMag=False
     bAISilent=True
     //EffectString="Attach suppressor"
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=1.000000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_68mm'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
