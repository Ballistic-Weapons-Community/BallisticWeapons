//=============================================================================
// BC_ThirdPersonSettings
//
// The third person camera's settings (see BallisticPlayer.CalcThirdPersonView),
// kept on each player's machine in User.ini and always read through the class
// defaults, so the keys and the menu (ConfigTab_ThirdPerson) change them at
// once. They are not on the player class: the game saves that one from the
// values a player held when it spawned, which would undo a later change.
//=============================================================================
class BC_ThirdPersonSettings extends Object
	config(User);

var config bool		bThirdPerson;			// Third person on foot. The Third Person key switches it
var config float	Distance;				// How far behind the eyes the camera sits
var config float	Height;					// How far above the eyes
var config float	Side;					// How far to the right of them, to the left below 0. Swap Shoulder flips it
var config float	Smoothing;				// 0: the camera keeps exactly to the player. 1: it follows loosely
var config bool		bSightsFirstPerson;		// First person while the sights are up
var config bool		bAimCrosshair;			// The crosshair is drawn where a shot would land, not in the middle

defaultproperties
{
	Distance=110
	Height=12
	Side=32
	Smoothing=0.3
	bSightsFirstPerson=True
	bAimCrosshair=True
}
