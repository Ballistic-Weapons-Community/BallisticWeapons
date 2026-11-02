//=============================================================================
// ConfigTabBase
//
// Base class of configuration menu tabs for BW.
// Provides the save/load interface.
//
// by Azarael
//=============================================================================
class ConfigTabBase extends UT2K4TabPanel;

var ConfigMenuBase     		BaseMenu;
var bool                    bInitialized;
var bool                    bRowsFixed;		// The game style has this tab's rules fixed

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);
	
	if (ConfigMenuBase(Controller.ActivePage) != None)
        BaseMenu = ConfigMenuBase(Controller.ActivePage);
}

function ShowPanel(bool bShow)
{
    super.ShowPanel(bShow);

    if (bInitialized)
        return;

	InitializeConfigTab();
    LoadSettings();

    bInitialized = true;
}

function InitializeConfigTab()
{

}

//==================================================================
// Settings & Defaults
//==================================================================

function LoadSettings();

function DefaultSettings();

function SaveSettings();

//==================================================================
// Rows that don't apply
//==================================================================

// Greys out a row that means nothing as things are set. It keeps its value, and is saved with it
function SetRowEnabled(GUIComponent Comp, bool bEnable)
{
	if (bEnable)
		Comp.EnableMe();
	else
		Comp.DisableMe();
}

// Rows that depend on another row. A tab calls this as it loads and after its defaults
function UpdateRows();

// The OnChange of a row that others depend on
function RowChanged(GUIComponent Sender)
{
	if (bInitialized)
		UpdateRows();
}

// A tab of a game style's rules, under a style that has them fixed: it can change nothing, so it saves nothing
function DisableStyleRows()
{
	local int i;

	for (i = 0; i < Controls.Length; i++)
		Controls[i].DisableMe();

	bRowsFixed = true;
}

// A tab refuses a click if it has nothing to focus, and with every row greyed out it hasn't
function bool FocusFirst(GUIComponent Sender)
{
	if (Super.FocusFirst(Sender))
		return true;

	return bRowsFixed;
}

defaultproperties
{
}