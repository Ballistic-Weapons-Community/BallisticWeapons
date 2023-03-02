// ====================================================================
// JunkWarKeyBinding.
//
// Adds some new keys.
// ====================================================================
class JunkWarKeyBinding extends GUIUserKeyBinding;

defaultproperties
{
     KeyData(0)=(KeyLabel="JunkWar   (Same as Ballistic)",bIsSection=True)
     KeyData(1)=(Alias="Reload|OnRelease ReloadRelease",KeyLabel="Junk Cycle  (Reload)")
     KeyData(2)=(Alias="WeaponSpecial|OnRelease WeaponSpecialRelease",KeyLabel="Block  (Weapon Special)")
     KeyData(3)=(Alias="GetWeapon BWBP_JWC_Pro.JunkWeapon",KeyLabel="Switch to Junk")
}
