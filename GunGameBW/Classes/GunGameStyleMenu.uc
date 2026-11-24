//=============================================================================
// GunGameStyleMenu
//
// The Game Style Options button of GunGame's game options. GunGame does not
// allow the Ballistic style mutators, so their Configure button is not there:
// this one opens the Ballistic configuration menu of the style chosen in the
// Game Style row, the same menu the style's mutator opens.
//
// The game options' Edit button (UT2K4PlayInfoPanel.CustomClicked) only
// opens a GUICustomPropertyPage, so this page is one. It is never shown: once
// the button has set it up, it replaces itself with the style's menu.
//=============================================================================
class GunGameStyleMenu extends GUICustomPropertyPage;

// CustomClicked sets the owner last, after the rest of its setup
function SetOwner(GUIComponent NewOwner)
{
	Super.SetOwner(NewOwner);

	// cancelled: the button's row keeps its value
	if (!Controller.ReplaceMenu(StyleMenu(ChosenStyle(NewOwner)), , , true))
		Controller.CloseMenu(true);
}

// The style in the Game Style row as it is now, saved or not
static function byte ChosenStyle(GUIComponent C)
{
	local UT2K4PlayInfoPanel Panel;
	local int i;

	while (C != None && Panel == None)
	{
		Panel = UT2K4PlayInfoPanel(C);
		C = C.MenuOwner;
	}

	if (Panel == None || Panel.GamePI == None)
		return 0;

	i = Panel.GamePI.FindIndex("GameStyle");
	if (i == -1)
		return 0;

	return byte(Panel.GamePI.Settings[i].Value);
}

// The menu of the style's mutator; GunGameConfig.GameStyleOptions numbers the styles
static function string StyleMenu(byte Style)
{
	switch (Style)
	{
		case 1:		return class'BallisticProV55.Mut_BallisticClassic'.default.ConfigMenuClassName;
		case 2:		return class'BallisticProV55.Mut_BallisticRealism'.default.ConfigMenuClassName;
		case 3:		return class'BallisticProV55.Mut_BallisticTactical'.default.ConfigMenuClassName;
		default:	return class'BallisticProV55.Mut_BallisticPro'.default.ConfigMenuClassName;
	}
}

// The value the game options keep for the row: none, the button only opens the menu
function string GetDataString()
{
	return "";
}

defaultproperties
{
	WindowName="Game Style Options"
}
