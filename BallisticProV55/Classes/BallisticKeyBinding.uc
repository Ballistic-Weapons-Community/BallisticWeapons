// ====================================================================
// BallisticKeyBinding.
//
// Adds some new keys.
// ====================================================================
class BallisticKeyBinding extends GUIUserKeyBinding;

defaultproperties
{
     KeyData(0)=(KeyLabel="Ballistic Weapons: Combat",bIsSection=True)
     KeyData(1)=(Alias="Reload|OnRelease ReloadRelease",KeyLabel="Reload")
     KeyData(2)=(Alias="ScopeView|OnRelease ScopeViewRelease",KeyLabel="Use Sights")
     KeyData(3)=(Alias="WeaponSpecial|OnRelease WeaponSpecialRelease",KeyLabel="Weapon Special (differs per gun)")
     KeyData(4)=(Alias="SwitchWeaponMode|OnRelease WeaponModeRelease",KeyLabel="Switch Fire Mode")
     KeyData(5)=(Alias="MeleeHold | OnRelease MeleeRelease",KeyLabel="Melee Attack")
     KeyData(6)=(Alias="Mutate killstreak",KeyLabel="Claim Killstreak Reward (if not automatic)")
     KeyData(7)=(Alias="DualSelect",KeyLabel="Dual Wield / Swap")
     KeyData(8)=(KeyLabel="Ballistic Weapons: Movement",bIsSection=True)
     KeyData(9)=(Alias="Mutate BStartSprint|OnRelease Mutate BStopSprint",KeyLabel="Sprint")
     KeyData(10)=(Alias="SwapShoulder",KeyLabel="Swap Shoulder (third person)")
     KeyData(11)=(KeyLabel="Ballistic Weapons: Menus",bIsSection=True)
     KeyData(12)=(Alias="Mutate Loadout",KeyLabel="Loadout Menu")
     KeyData(13)=(Alias="BWStats",KeyLabel="Weapon Stats / Manual")
     KeyData(14)=(Alias="Ballistic",KeyLabel="Ballistic Preferences")
}
