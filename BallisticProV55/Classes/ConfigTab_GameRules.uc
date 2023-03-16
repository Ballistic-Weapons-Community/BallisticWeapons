//=============================================================================
// ConfigTab_WeaponRules.
//
// Server side options like rules that change the behaviour of the game and
// affect all players. These are used when hosting an MP or SP game.
//
// Edit By OJMoody
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ConfigTab_GameRules extends ConfigTabBase;

var automated moComboBox	co_InventoryMode;			//Choose Inventory Mode
var automated moCheckbox	ch_BrightPlayers;			//Bright Players
var automated moCheckbox	ch_ForceBWPawn;				//Force Ballistic Pawn
var automated moCheckbox	ch_PreCacheWeapons;			//Precache Weapons
var automated moCheckbox	ch_KillStreaks;				//Killstreaks

//==================================================================
// Settings & Defaults
//==================================================================

function LoadSettings()
{
	local class<BC_GameStyle_Config> style;

	co_InventoryMode.AddItem("Pickups" ,,string(0));
	co_InventoryMode.AddItem("Outfitting Loadout" ,,string(1));
	co_InventoryMode.AddItem("Conflict Loadout" ,,string(2));
	co_InventoryMode.AddItem("Evolution Loadout" ,,string(3));
	co_InventoryMode.AddItem("Arena" ,,string(4));
	co_InventoryMode.AddItem("Melee" ,,string(4));
	co_InventoryMode.ReadOnly(True);

	ch_PreCacheWeapons.Checked(class'Mut_Ballistic'.default.bPreloadMeshes);
	ch_ForceBWPawn.Checked(class'Mut_Ballistic'.default.bForceBallisticPawn);

	style = BaseMenu.GetConfigStyle();

	if (style != None)
	{
		co_InventoryMode.SetIndex(style.default.InventoryModeIndex);
		ch_KillStreaks.Checked(style.default.bKillstreaks);
		ch_BrightPlayers.Checked(style.default.bBrightPlayers);
	}
}

function SaveSettings()
{
	local class<BC_GameStyle_Config> style;

	if (!bInitialized)
		return;

	// stuff that's not game style relevant:
	class'Mut_Ballistic'.default.bPreloadMeshes				= ch_PreCacheWeapons.IsChecked();
    class'Mut_Ballistic'.default.bForceBallisticPawn		= ch_ForceBWPawn.IsChecked();
	class'Mut_Ballistic'.static.StaticSaveConfig();

	style = BaseMenu.GetConfigStyle();

	if (style != None)
	{
		style.default.InventoryModeIndex		= co_InventoryMode.GetIndex();
		style.default.bBrightPlayers			= ch_BrightPlayers.IsChecked();
		style.default.bKillstreaks				= ch_KillStreaks.IsChecked();
		style.static.StaticSaveConfig();
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
}