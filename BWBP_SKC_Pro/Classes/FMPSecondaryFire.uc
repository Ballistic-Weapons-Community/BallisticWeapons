//=============================================================================
// M30PrimaryFire.
//
//[11:09:19 PM] Captain Xavious: make sure its noted to be an assault rifle
//[11:09:26 PM] Marc Moylan: lol Calypto
//[11:09:28 PM] Matteo 'Azarael': mp40 effective range
//[11:09:29 PM] Matteo 'Azarael': miles
//=============================================================================
class FMPSecondaryFire extends BallisticProInstantFire;

simulated event ModeDoFire()
{
	if (!Instigator.IsLocallyControlled())
		return;
	if (AllowFire())
	FMPMachinePistol(Weapon).ToggleAmplifier();
}

defaultproperties
{
     bUseWeaponMag=False
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.200000
     AmmoClass=Class'BallisticProV55.Ammo_XRS10Bullets'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
