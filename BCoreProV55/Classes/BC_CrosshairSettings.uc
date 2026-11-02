//=============================================================================
// BC_CrosshairSettings
//
// What all crosshairs share, kept on each player's machine and always read
// through the class defaults, so the menu (ConfigTab_GameplayPrefs) changes it
// at once. It is not on BallisticWeapon: a weapon that saves its config writes
// the global settings from the values it held when it spawned, which would undo
// a later change.
//=============================================================================
class BC_CrosshairSettings extends Object
	config(BallisticProV55);

var config byte		CrosshairAim;		// Where a crosshair goes: an ECrosshairAim of BallisticWeapon

defaultproperties
{
	CrosshairAim=1
}
