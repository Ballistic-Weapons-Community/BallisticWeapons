//=============================================================================
// MDK Secondary Fire.
//
// Ice rounds. Inflict slow upon targets hit, but deal lesser damage than standard MDK rounds.
//=============================================================================
class MDKSecondaryFire extends BallisticFire;

simulated event ModeDoFire()
{
    if (!Instigator.IsLocallyControlled())
    	return;
	if (AllowFire())
		MDKSubMachinegun(Weapon).ScopeSpecial();
}

defaultproperties
{
     bUseWeaponMag=False
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=1.200000
     AmmoClass=Class'BWBP_SWC_Pro.Ammo_MDK9mm'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
