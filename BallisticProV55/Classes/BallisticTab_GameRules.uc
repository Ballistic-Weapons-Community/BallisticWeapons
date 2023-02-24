//=============================================================================
// BallisticTab_WeaponRules.
//
// Server side options like rules that change the behaviour of the game and
// affect all players. These are used when hosting an MP or SP game.
//
// Edit By OJMoody
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticTab_GameRules extends UT2K4TabPanel;

var automated moComboBox	co_InventoryMode;			//Choose Inventoy Mode
var automated moComboBox	co_GameStyle;				//Choose Params
//Add Killsteaks Here
var automated moCheckbox	ch_ViewFlash;				//Damage Indication Flash Toggle
var automated moNumericEdit int_MaxInventoryCapacity;	//Inventory Capacity
var automated moCheckbox	ch_BrightPlayers;			//Bright Players
var automated moCheckbox	ch_ForceBWPawn;				//Force Ballistic Pawn
var automated moCheckbox	ch_NoDodging;				//Disables Dodging
var automated moCheckbox	ch_NoDoubleJump;				//Limits Double Jump
var automated moCheckbox	ch_Regen;					//Enables Health Regen
var automated moCheckbox	ch_ShieldRegen;				//Enables Shield Regen
var automated moCheckbox	ch_PreCacheWeapons;			//Precache Weapons
var automated moCheckbox	ch_KillStreaks;				//Killsteaks

var BallisticConfigMenuPro	p_Anchor;
var bool					bInitialized;

//==================================================================
// General Menu Code
//==================================================================

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);
	if (BallisticConfigMenuPro(Controller.ActivePage) != None)
		p_Anchor = BallisticConfigMenuPro(Controller.ActivePage);
}

function ShowPanel(bool bShow)
{
	super.ShowPanel(bShow);
	if (bInitialized)
		return;
	LoadSettings();
	bInitialized = true;
}

//==================================================================
// Settings & Defaults
//==================================================================

function LoadSettings()
{
	co_InventoryMode.AddItem("Pickups" ,,string(0));
	co_InventoryMode.AddItem("Outfitting Loadout" ,,string(1));
	co_InventoryMode.AddItem("Conflict Loadout" ,,string(2));
	co_InventoryMode.AddItem("Evolution Loadout" ,,string(3));
	co_InventoryMode.AddItem("Arena" ,,string(4));
	co_InventoryMode.AddItem("Melee" ,,string(4));
	co_InventoryMode.ReadOnly(True);
	co_InventoryMode.SetIndex(class'Mut_BallisticGlobal'.default.InventoryModeIndex);
	
	co_GameStyle.AddItem("Competitive" ,,string(0));
	co_GameStyle.AddItem("Classic" ,,string(1));
	co_GameStyle.AddItem("Realism" ,,string(2));
	co_GameStyle.ReadOnly(True);
	co_GameStyle.SetIndex(class'BallisticReplicationInfo'.default.GameStyle);
	
	ch_ViewFlash.Checked(class'BallisticPawn'.default.bNoViewFlash);
	int_MaxInventoryCapacity.SetValue(class'BallisticWeapon'.default.MaxInventoryCapacity);
	ch_BrightPlayers.Checked(class'BallisticReplicationInfo'.default.bBrightPlayers);
	ch_ForceBWPawn.Checked(class'Mut_Ballistic'.default.bForceBallisticPawn);
	ch_NoDodging.Checked(class'BallisticReplicationInfo'.default.bNoDodging);
	ch_NoDoubleJump.Checked(class'BallisticReplicationInfo'.default.bNoDoubleJump);
	ch_Regen.Checked(class'mut_Ballistic'.default.bRegeneration);
	ch_ShieldRegen.Checked(class'mut_Ballistic'.default.bShieldRegeneration);
	ch_PreCacheWeapons.Checked(class'Mut_Ballistic'.default.bPreloadMeshes);
	ch_KillStreaks.Checked(class'Mut_Ballistic'.default.bKillstreaks);
}

function SaveSettings()
{
	if (!bInitialized)
		return;
	class'Mut_BallisticGlobal'.default.InventoryModeIndex		= co_InventoryMode.GetIndex();
	class'BallisticReplicationInfo'.default.GameStyle       	= EGameStyle(co_GameStyle.GetIndex());
	class'BallisticPawn'.default.bNoViewFlash					= ch_ViewFlash.IsChecked();
	class'BallisticWeapon'.default.MaxInventoryCapacity 		= int_MaxInventoryCapacity.GetValue();	
	class'BallisticReplicationInfo'.default.bBrightPlayers		= ch_BrightPlayers.IsChecked();
    class'Mut_Ballistic'.default.bForceBallisticPawn			= ch_ForceBWPawn.IsChecked();
	class'BallisticReplicationInfo'.default.bNoDodging			= ch_NoDodging.IsChecked();
	class'BallisticReplicationInfo'.default.bNoDoubleJump 	    = ch_NoDoubleJump.IsChecked();
	class'Mut_Ballistic'.default.bRegeneration					= ch_Regen.IsChecked();
	class'Mut_Ballistic'.default.bShieldRegeneration			= ch_ShieldRegen.IsChecked();
	class'Mut_Ballistic'.default.bPreloadMeshes					= ch_PreCacheWeapons.IsChecked();
	class'Mut_Ballistic'.default.bKillstreaks					= ch_KillStreaks.IsChecked();
	
	class'BallisticReplicationInfo'.static.StaticSaveConfig();
	class'BallisticWeapon'.static.StaticSaveConfig();
	class'Mut_Ballistic'.static.StaticSaveConfig();
	class'BallisticPawn'.static.StaticSaveConfig();
	class'Rules_Ballistic'.static.StaticSaveConfig();
	class'Mut_Ballistic'.static.StaticSaveConfig();
	class'Mut_BallisticGlobal'.static.StaticSaveConfig();
}

function DefaultSettings()
{
	co_InventoryMode.SetIndex(0);
	co_GameStyle.SetIndex(0);
	ch_ViewFlash.Checked(true);
	int_MaxInventoryCapacity.SetValue(0);
	ch_BrightPlayers.Checked(false);
	ch_ForceBWPawn.Checked(false);
	ch_NoDodging.Checked(false);
	ch_NoDoubleJump.Checked(false);
	ch_Regen.Checked(false);
	ch_ShieldRegen.Checked(false);
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
         WinTop=0.050000
         WinLeft=0.250000
		 WinHeight=0.040000
     End Object
     co_InventoryMode=moComboBox'co_InventoryModeCombo'
	 
	 Begin Object Class=moComboBox Name=co_GameStyleCombo
         ComponentJustification=TXTA_Left
         CaptionWidth=0.550000
         Caption="Game Style"
         OnCreateComponent=co_GameStyleCombo.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="High"
         Hint="Determines the general gameplay of Ballistic Weapons."
         WinTop=0.100000
         WinLeft=0.250000
		 WinHeight=0.040000
     End Object
     co_GameStyle=moComboBox'co_GameStyleCombo'
	 
	 Begin Object Class=moCheckBox Name=ch_PreCacheCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Pre-Cache Weapons"
         OnCreateComponent=ch_PreCacheCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Pre-Cache Weapons at the start of the match"
         WinTop=0.1500000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_PreCacheWeapons=moCheckBox'BallisticProV55.BallisticTab_GameRules.ch_PreCacheCheck'
	 
	 Begin Object Class=moCheckBox Name=ch_ViewFlashCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="No Damage Screen Flashes"
         OnCreateComponent=ch_ViewFlashCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disable screen flashes when you get damaged."
         WinTop=0.20000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_ViewFlash=moCheckBox'BallisticProV55.BallisticTab_GameRules.ch_ViewFlashCheck'
	 
	 Begin Object Class=moNumericEdit Name=int_MaxWepsInt
         MinValue=0
         MaxValue=999
         ComponentJustification=TXTA_Left
         CaptionWidth=0.800000
         Caption="Player Inventory Capacity"
         OnCreateComponent=int_MaxWepsInt.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Sets the player's maximum inventory capacity. 0 is infinite."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     int_MaxInventoryCapacity=moNumericEdit'BallisticProV55.BallisticTab_GameRules.int_MaxWepsInt'

	 Begin Object Class=moCheckBox Name=ch_BrightPlayersCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Bright Players"
         OnCreateComponent=ch_BrightPlayersCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Makes players glow in the dark like normal UT2004. Only affects BW gametypes - standard gametypes have bright players already."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_BrightPlayers=moCheckBox'BallisticProV55.BallisticTab_GameRules.ch_BrightPlayersCheck'

	 Begin Object Class=moCheckBox Name=ch_ForceBWPawnCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Force Ballistic Pawn"
         OnCreateComponent=ch_ForceBWPawnCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="BW mutators will try to force BallisticPawn even when game specific pawn is used (WARNING: Could cause severe problems in some gametypes)"
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_ForceBWPawn=moCheckBox'BallisticProV55.BallisticTab_GameRules.ch_ForceBWPawnCheck'

	 Begin Object Class=moCheckBox Name=ch_NoDodgingCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Disable Dodging"
         OnCreateComponent=ch_NoDodgingCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disables dodging for all players."
         WinTop=0.400000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_NoDodging=moCheckBox'BallisticProV55.BallisticTab_GameRules.ch_NoDodgingCheck'

    Begin Object Class=moCheckBox Name=ch_NoDoubleJumpCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Disable Double Jump"
         OnCreateComponent=ch_NoDoubleJumpCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disables double jump for all players."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_NoDoubleJump=moCheckBox'BallisticProV55.BallisticTab_GameRules.ch_NoDoubleJumpCheck'
	 
	 Begin Object Class=moCheckBox Name=ch_RegenCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Health Regeneration"
         OnCreateComponent=ch_RegenCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enables Ballistic Health Regeneration"
         WinTop=0.500000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_Regen=moCheckBox'BallisticProV55.BallisticTab_GameRules.ch_RegenCheck'
	 
	 Begin Object Class=moCheckBox Name=ch_ShieldRegenCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Shield Regeneration"
         OnCreateComponent=ch_ShieldRegenCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enables Ballistic Shield Regeneration"
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_ShieldRegen=moCheckBox'BallisticProV55.BallisticTab_GameRules.ch_ShieldRegenCheck'
	 
	 Begin Object Class=moCheckBox Name=ch_KillStreaksCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="KillStreaks"
         OnCreateComponent=ch_KillStreaksCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enables Ballistic KillStreaks (Can Be Configured from the Loadout Tab)"
         WinTop=0.600000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_KillStreaks=moCheckBox'BallisticProV55.BallisticTab_GameRules.ch_KillStreaksCheck'
}