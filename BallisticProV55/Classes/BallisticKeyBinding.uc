// ====================================================================
// BallisticKeyBinding.
//
// Adds some new keys.
// ====================================================================
class BallisticKeyBinding extends GUIUserKeyBinding;

defaultproperties
{
     KeyData(0)=(KeyLabel="Ballistic Weapons Keybinds",bIsSection=True)
     KeyData(1)=(Alias="Reload|OnRelease ReloadRelease",KeyLabel="Reload")
     KeyData(2)=(Alias="WeaponSpecial|OnRelease WeaponSpecialRelease",KeyLabel="Weapon Special")
     KeyData(3)=(Alias="ScopeView|OnRelease ScopeViewRelease",KeyLabel="Use Sights")
     KeyData(4)=(Alias="DualSelect",KeyLabel="Dual Wield / Swap")
     KeyData(5)=(Alias="SwitchWeaponMode|OnRelease WeaponModeRelease",KeyLabel="Switch Fire Mode")
     KeyData(6)=(Alias="Mutate Loadout",KeyLabel="Loadout Menu")
	 KeyData(7)=(Alias="MeleeHold | OnRelease MeleeRelease",KeyLabel="Melee Attack")
	 KeyData(8)=(Alias="Mutate killstreak",KeyLabel="Claim Killstreak")
     KeyData(9)=(Alias="Mutate BStartSprint|OnRelease Mutate BStopSprint",KeyLabel="Sprint")
     KeyData(10)=(Alias="CockGun",KeyLabel="Cock Weapon (optional)")
	 KeyData(11)=(Alias="BWStats",KeyLabel="Ballistic Weapons Stats/Manual")
	 KeyData(12)=(Alias="Preferences",KeyLabel="Ballistic Preferences Menu")
}
