//=============================================================================
// ConfigTab_WeaponRules.
//
// Server side options which are used by all styles, even the fixed ones.
//
// by DarkCarnivour and Azarael
//=============================================================================
class ConfigTab_GameRules extends ConfigTabBase;

var automated moComboBox	co_InventoryMode;			//Choose Inventory Mode
var automated moCheckbox	ch_BrightPlayers;			//Bright Players
var automated moCheckbox	ch_ForceBWPawn;				//Force Ballistic Pawn
var automated moCheckbox	ch_PreCacheWeapons;			//Precache Weapons
var automated moCheckbox	ch_KillStreaks;				//Killstreaks
var automated GUIButton		bn_ClientSettings;
//==================================================================
// Settings & Defaults
//==================================================================

function LoadSettings()
{
	local class<BC_GameStyle> game_style;

	co_InventoryMode.AddItem("Inventory" ,,string(0));
	co_InventoryMode.AddItem("Loadout" ,,string(1));
	co_InventoryMode.AddItem("Evolution Loadout",,string(2));
	co_InventoryMode.AddItem("Pickups" ,,string(3));
	co_InventoryMode.AddItem("Arena" ,,string(4));
	co_InventoryMode.AddItem("Melee" ,,string(5));
	co_InventoryMode.ReadOnly(True);

	ch_PreCacheWeapons.Checked(class'Mut_Ballistic'.default.bPreloadMeshes);
	ch_ForceBWPawn.Checked(class'Mut_Ballistic'.default.bForceBallisticPawn);

	game_style = BaseMenu.GetGameStyle();

	if (game_style == None)
	{
		Log("ConfigTab_GameRules: Couldn't load: No compatible style found");
	}
	else 
	{
		co_InventoryMode.SetIndex(game_style.default.InventoryModeIndex);
		ch_KillStreaks.Checked(game_style.default.bKillstreaks);
		ch_BrightPlayers.Checked(game_style.default.bBrightPlayers);
	}
}

function SaveSettings()
{
	local class<BC_GameStyle> game_style;

	if (!bInitialized)
		return;

	// stuff that's not game style relevant:
	class'Mut_Ballistic'.default.bPreloadMeshes				= ch_PreCacheWeapons.IsChecked();
    class'Mut_Ballistic'.default.bForceBallisticPawn		= ch_ForceBWPawn.IsChecked();
	class'Mut_Ballistic'.static.StaticSaveConfig();

	game_style = BaseMenu.GetGameStyle();

	if (game_style == None)
	{
		Log("ConfigTab_GameRules: Couldn't save: No compatible style found");
	}
	else 
	{
		game_style.default.InventoryModeIndex		= co_InventoryMode.GetIndex();
		game_style.default.bBrightPlayers			= ch_BrightPlayers.IsChecked();
		game_style.default.bKillstreaks				= ch_KillStreaks.IsChecked();
		game_style.static.StaticSaveConfig();
	}
}

function DefaultSettings()
{
	co_InventoryMode.SetIndex(0);
	ch_BrightPlayers.Checked(false);
	ch_ForceBWPawn.Checked(false);
	ch_PreCacheWeapons.Checked(true);
	ch_KillStreaks.Checked(false);
}

function bool InternalOnClick(GUIComponent Sender)
{
	if (Sender==bn_ClientSettings) // DONE
	{
		Controller.OpenMenu("BallisticProV55.ConfigMenu_Preferences");
		return true;
	}

	return false;
}

defaultproperties
{	 
	 Begin Object Class=moComboBox Name=co_InventoryModeCombo
         ComponentJustification=TXTA_Left
         CaptionWidth=0.550000
         Caption="Inventory Mode"
         OnCreateComponent=co_InventoryModeCombo.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="High"
         Hint="Determines the Weapon Spawns of Ballistic Weapons"
         WinTop=0.100000
         WinLeft=0.250000
		 WinHeight=0.040000
     End Object
     co_InventoryMode=moComboBox'co_InventoryModeCombo'

	 Begin Object Class=moCheckBox Name=ch_PreCacheCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Precache Weapons"
         OnCreateComponent=ch_PreCacheCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Precache weapons at the start of the match."
         WinTop=0.1500000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_PreCacheWeapons=moCheckBox'BallisticProV55.ConfigTab_GameRules.ch_PreCacheCheck'
	 
	 Begin Object Class=moCheckBox Name=ch_BrightPlayersCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Bright Players"
         OnCreateComponent=ch_BrightPlayersCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Makes players glow in the dark like normal UT2004. Only affects BW gametypes - standard gametypes have bright players already."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_BrightPlayers=moCheckBox'BallisticProV55.ConfigTab_GameRules.ch_BrightPlayersCheck'

	 Begin Object Class=moCheckBox Name=ch_ForceBWPawnCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Force Ballistic Pawn"
         OnCreateComponent=ch_ForceBWPawnCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="BW mutators will try to force the Ballistic pawn even when game specific pawn is used.||WARNING: Can cause severe problems in some gametypes."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_ForceBWPawn=moCheckBox'BallisticProV55.ConfigTab_GameRules.ch_ForceBWPawnCheck'

	 Begin Object Class=moCheckBox Name=ch_KillStreaksCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Killstreaks"
         OnCreateComponent=ch_KillStreaksCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enables killstreaks. Configured via the Loadout tab."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_KillStreaks=moCheckBox'BallisticProV55.ConfigTab_GameRules.ch_KillStreaksCheck'

	Begin Object Class=GUIButton Name=ClientSettingsButton
         Caption="Preferences"
         Hint="Edit preferences."
         WinTop=0.450000
		 WinHeight=0.1
         WinLeft=0.250000
         WinWidth=0.50000
         TabOrder=0
         OnClick=ConfigTab_GameRules.InternalOnClick
         OnKeyEvent=ClientSettingsButton.InternalOnKeyEvent
     End Object
     bn_ClientSettings=GUIButton'ClientSettingsButton'
}