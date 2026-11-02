//=============================================================================
// ConfigMenu_WeaponCrosshairs
//
// The Crosshairs tab's sub menu: each weapon's own graphical crosshair.
//=============================================================================
class ConfigMenu_WeaponCrosshairs extends ConfigMenuBase;

var() localized string		WeaponsTabLabel,WeaponsTabHint;

function AddTabs()
{
	c_Tabs.AddTab(WeaponsTabLabel,"BallisticProV55.ConfigTab_WeaponCrosshairs",,WeaponsTabHint);
}

defaultproperties
{
	WeaponsTabLabel="Weapon Crosshairs"
	WeaponsTabHint="Choose each weapon's own graphical crosshair."
	HeaderCaption="Ballistic Preferences"
}
