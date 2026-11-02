//=============================================================================
// BC_CrosshairSettings
//
// What all crosshairs share, kept on each player's machine and always read
// through the class defaults, so the menu (ConfigTab_Crosshairs) changes it at
// once. It is not on BallisticWeapon: a weapon that saves its config writes the
// global settings from the values it held when it spawned, which would undo a
// later change.
//=============================================================================
class BC_CrosshairSettings extends Object
	config(BallisticProV55);

var config byte		CrosshairAim;		// Where a crosshair goes: an ECrosshairAim of BallisticWeapon
var config Color	CrosshairColor;		// The Simple crosshair's colour. Its alpha is the opacity of all of these
var config bool		bOneColour;			// Graphical crosshairs use CrosshairColor as well, not their weapon's colours
var config bool		bWarningColours;	// Crosshairs change colour for an empty magazine and a gun that needs cocking
var config Color	MagEmptyColor;
var config Color	CockingColor;
var config bool		bDistanceSize;		// Crosshairs are drawn smaller on what is far away

defaultproperties
{
	CrosshairAim=1
	CrosshairColor=(B=255,G=225,R=255,A=150)
	bWarningColours=True
	MagEmptyColor=(B=50,G=50,R=255,A=150)
	CockingColor=(B=50,G=175,R=255,A=150)
}
