//=============================================================================
// LK05SecondaryFire.
//
// Silencer
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class LK05SecondaryFire extends BallisticFire;

simulated event ModeDoFire()
{
    if (!Instigator.IsLocallyControlled())
    	return;
		LK05Carbine(Weapon).SwitchSilencer();
}

defaultproperties
{
     bUseWeaponMag=False
     bAISilent=True
     EffectString="Attach suppressor"
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=1.300000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_68mm'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
