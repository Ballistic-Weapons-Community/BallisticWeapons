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

defaultproperties
{
}