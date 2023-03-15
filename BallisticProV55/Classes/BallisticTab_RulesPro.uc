//=============================================================================
// BallisticTab_RulesPro.
//
// Server side options like rules that change the behaviour of the game and
// affect all players. These are used when hosting an MP or SP game.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticTab_RulesPro extends UT2K4TabPanel;

var automated moEditBox   	eb_ItemGroup;
var automated moCheckbox	ch_UseItemizer, ch_LeaveSuper, ch_BrightPickups, ch_SpawnUnique, ch_PickupsChange, ch_RandomDefaults,
							ch_BrightPlayers, ch_JumpOffsetting, ch_LongWeaponOffsetting, ch_KillRogueWPs, ch_ForceBWPawn, ch_NoReloading, ch_AllowDodging, ch_AllowDoubleJump;
var automated moSlider		sl_Accuracy, sl_Recoil, sl_Damage, sl_VDamage;
var automated moFloatEdit	fl_Damage, fl_VDamage;
var automated moComboBox	co_GameStyle;

var BallisticConfigMenuPro		p_Anchor;
var bool					bInitialized;

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

function LoadSettings()
{
	local class<BC_GameStyle> style;
	local class<BC_GameStyle_Config> config_style;

	ch_RandomDefaults.Checked(class'Mut_Ballistic'.default.bRandomDefaultWeapons);
	ch_UseItemizer.Checked(class'Mut_Ballistic'.default.bUseItemizer);
	eb_ItemGroup.SetText(class'Mut_Ballistic'.default.ItemGroup);
	ch_LeaveSuper.Checked(class'Mut_Ballistic'.default.bLeaveSuper);
	ch_BrightPickups.Checked(class'Mut_Ballistic'.default.bBrightPickups);
	ch_SpawnUnique.Checked(class'Mut_Ballistic'.default.bSpawnUniqueItems);
	ch_PickupsChange.Checked(class'Mut_Ballistic'.default.bPickupsChange);


	fl_Damage.SetValue(class'Rules_Ballistic'.default.DamageScale);
	fl_VDamage.SetValue(class'Rules_Ballistic'.default.VehicleDamageScale);
	ch_KillRogueWPs.Checked(class'Mut_Ballistic'.default.bKillRogueWeaponPickups);
	ch_ForceBWPawn.Checked(class'Mut_Ballistic'.default.bForceBallisticPawn);

    co_GameStyle.AddItem("Pro" ,,string(0));
	co_GameStyle.AddItem("Classic" ,,string(1));
	co_GameStyle.AddItem("Realism" ,,string(2));
    co_GameStyle.AddItem("Tactical" ,,string(3));
	co_GameStyle.ReadOnly(True);
	co_GameStyle.SetIndex(class'BallisticGameStyles'.default.GameStyle);

	style = class'BallisticGameStyles'.static.GetClientLocalStyle();

	if (style != None)
	{
		sl_Accuracy.SetValue(style.default.AccuracyScale);
		sl_Recoil.SetValue(style.default.RecoilScale);
	}

	config_style = class<BC_GameStyle_Config>(style);

	if (config_style != None)
	{
		ch_JumpOffsetting.Checked(cconfig_style.default.bWeaponJumpOffsetting);
		ch_LongWeaponOffsetting.Checked(config_style.default.bLongWeaponOffsetting);
		ch_NoReloading.Checked(config_style.default.bNoReloading);
		ch_BrightPlayers.Checked(config_style.default.bBrightPlayers);
		ch_AllowDodging.Checked(config_style.default.bAllowDodging);
		ch_AllowDoubleJump.Checked(config_style.default.bAllowDoubleJump);
	}
}

function SaveSettings()
{
	local class<BC_GameStyle> style;
	local class<BC_GameStyle_Config> config_style;

	if (!bInitialized)
		return;

	class'Mut_Ballistic'.default.ItemGroup		 			= eb_ItemGroup.GetText();
	class'Mut_Ballistic'.default.bUseItemizer	 			= ch_UseItemizer.IsChecked();
	class'Mut_Ballistic'.default.bLeaveSuper 				= ch_LeaveSuper.IsChecked();
	class'Mut_Ballistic'.default.bBrightPickups		 		= ch_BrightPickups.IsChecked();
	class'Mut_Ballistic'.default.bSpawnUniqueItems 			= ch_SpawnUnique.IsChecked();
	class'Mut_Ballistic'.default.bPickupsChange 			= ch_PickupsChange.IsChecked();
	class'Mut_Ballistic'.default.bRandomDefaultWeapons 		= ch_RandomDefaults.IsChecked();
	class'Mut_Ballistic'.default.bKillRogueWeaponPickups	= ch_KillRogueWPs.IsChecked();
	class'Mut_Ballistic'.default.bForceBallisticPawn		= ch_ForceBWPawn.IsChecked();
	class'Mut_Ballistic'.static.StaticSaveConfig();

	class'Rules_Ballistic'.default.DamageScale 				= fl_Damage.GetValue();
	class'Rules_Ballistic'.default.VehicleDamageScale		= fl_VDamage.GetValue();
	class'Rules_Ballistic'.static.StaticSaveConfig();

	style = class'BallisticGameStyles'.static.GetClientLocalStyle();

	if (style != None)
	{
		style.default.AccuracyScale	= sl_Accuracy.GetValue();
		style.default.RecoilScale	= sl_Recoil.GetValue();
		style.static.StaticSaveConfig();
	}

	config_style = class<BC_GameStyle_Config>(style);

	if (config_style != None)
	{
    	config_style.default.GameStyle       = EGameStyle(co_GameStyle.GetIndex());
		config_style.default.bNoReloading	= ch_NoReloading.IsChecked();
		config_style.default.bWeaponJumpOffsetting	= ch_JumpOffsetting.IsChecked();
		config_style.default.bLongWeaponOffsetting		= ch_LongWeaponOffsetting.IsChecked();
		config_style.default.bBrightPlayers	= ch_BrightPlayers.IsChecked();
		config_style.default.bAllowDodging		= ch_AllowDodging.IsChecked();
		config_style.default.bAllowDoubleJump = ch_AllowDoubleJump.IsChecked();
		config_style.static.StaticSaveConfig();
	}
}

function DefaultSettings()
{
    co_GameStyle.SetIndex(0);
	ch_RandomDefaults.Checked(true);
	ch_UseItemizer.Checked(true);
	eb_ItemGroup.SetText("Ballistic");
	ch_LeaveSuper.Checked(false);
	ch_BrightPickups.Checked(false);
	ch_SpawnUnique.Checked(true);
	ch_PickupsChange.Checked(true);
	sl_Accuracy.SetValue(1.0);
	sl_Recoil.SetValue(1.0);
	ch_BrightPlayers.Checked(false);
	fl_Damage.SetValue(1.0);
	fl_VDamage.SetValue(1.0);
	ch_JumpOffsetting.Checked(true);
	ch_LongWeaponOffsetting.Checked(true);
	ch_KillRogueWPs.Checked(false);
	ch_ForceBWPawn.Checked(false);
	ch_NoReloading.Checked(false);
	ch_AllowDodging.Checked(true);
	ch_AllowDoubleJump.Checked(true);
}

/*     Begin Object Class=moSlider Name=sl_DamageSlider
	     CaptionWidth=0.600000
         MaxValue=8.000000
         MinValue=0.050000
         Caption="Damage Scale"
         Hint="Scale the amount of damage done to non vehicles."
         WinTop=0.6
         WinLeft=0.250000
         WinWidth=0.500000
         WinHeight=0.04
     End Object
     sl_Damage=moSlider'BallisticTab_RulesPro.sl_DamageSlider'

     Begin Object Class=moSlider Name=sl_VDamageSlider
	     CaptionWidth=0.600000
         MaxValue=8.000000
         MinValue=0.050000
         Caption="Vehicle Damage Scale"
         Hint="Scale the amount of damage done to vehicles."
         WinTop=0.65
         WinLeft=0.250000
         WinWidth=0.500000
         WinHeight=0.04
     End Object
     sl_VDamage=moSlider'BallisticTab_RulesPro.sl_VDamageSlider'
*/

defaultproperties
{
    Begin Object Class=moComboBox Name=co_GameStyleCombo
         ComponentJustification=TXTA_Left
         CaptionWidth=0.550000
         Caption="Game Style"
         OnCreateComponent=co_GameStyleCombo.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="High"
         Hint="Determines the general gameplay of Ballistic Weapons."
         WinTop=0.050000
         WinLeft=0.250000
     End Object
     co_GameStyle=moComboBox'co_GameStyleCombo'

    /*
    Begin Object Class=moCheckBox Name=ch_RandomDefaultsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Random Default Weapons"
         OnCreateComponent=ch_RandomDefaultsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Players will spawn with a random sidearm instead of stock pistol."
         WinTop=0.050000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_RandomDefaults=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_RandomDefaultsCheck'
    */
    
    Begin Object Class=moCheckBox Name=ch_PickupsChangeCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Pickups Change"
         OnCreateComponent=ch_PickupsChangeCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Pickups randomly change after they have been picked up."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_PickupsChange=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_PickupsChangeCheck'

     Begin Object Class=moCheckBox Name=ch_SpawnUniqueCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Prefer Unique Pickups"
         OnCreateComponent=ch_SpawnUniqueCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Game will prefer to spawn pickups that are the least common at the time."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_SpawnUnique=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_SpawnUniqueCheck'

    Begin Object Class=moCheckBox Name=UseItemizerCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Use itemizer"
         OnCreateComponent=UseItemizerCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Use the Itemizer to spawn aditional pickups in maps."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_UseItemizer=moCheckBox'BallisticProV55.BallisticTab_RulesPro.UseItemizerCheck'

     Begin Object Class=moEditBox Name=eb_ItemGroupEdit
         CaptionWidth=0.250000
         Caption="Itemizer Group"
         OnCreateComponent=eb_ItemGroupEdit.InternalOnCreateComponent
         Hint="The name of the Itemizer layout you want to use. Defaults to 'Ballistic'."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.060000
     End Object
     eb_ItemGroup=moEditBox'BallisticProV55.BallisticTab_RulesPro.eb_ItemGroupEdit'

     Begin Object Class=moCheckBox Name=ch_LeaveSuperCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Keep Super Weapons"
         OnCreateComponent=ch_LeaveSuperCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable to leave super weapons in."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_LeaveSuper=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_LeaveSuperCheck'

     Begin Object Class=moCheckBox Name=ch_BrightPickupsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Bright Pickups"
         OnCreateComponent=ch_BrightPickupsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable to make pickups bright and easier to see. Does not affect multiplayer."
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_BrightPickups=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_BrightPickupsCheck'

     Begin Object Class=moCheckBox Name=ch_BrightPlayersCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Bright Players"
         OnCreateComponent=ch_BrightPlayersCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Makes players glow in the dark like normal UT2004. Only affects BW gametypes - standard gametypes have bright players already."
         WinTop=0.400000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_BrightPlayers=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_BrightPlayersCheck'

     Begin Object Class=moCheckBox Name=ch_SprintAimCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Stable Jump/Sprint"
         OnCreateComponent=ch_SprintAimCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enables weapon offsetting when jumping or sprinting."
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_JumpOffsetting=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_SprintAimCheck'

     Begin Object Class=moCheckBox Name=ch_LongWeaponOffsettingCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="No Long Gun Shifting"
         OnCreateComponent=ch_LongWeaponOffsettingCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enables weapon offsetting when too close to an object."
         WinTop=0.600000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_LongWeaponOffsetting=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_LongWeaponOffsettingCheck'

     Begin Object Class=moCheckBox Name=ch_KillRogueWPsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="No Rogue Weapon Pickups"
         OnCreateComponent=ch_KillRogueWPsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="BW mutators will remove/replace unlisted weapon pickups. (e.g. In-map Instagib rifles)"
         WinTop=0.650000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_KillRogueWPs=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_KillRogueWPsCheck'

     Begin Object Class=moSlider Name=sl_AccuracySlider
         MaxValue=2.000000
         Caption="Inaccuracy Scale"
         OnCreateComponent=sl_AccuracySlider.InternalOnCreateComponent
         Hint="Scale the inaccuracy of ballistic weapons."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     sl_Accuracy=moSlider'BallisticProV55.BallisticTab_RulesPro.sl_AccuracySlider'

     Begin Object Class=moSlider Name=sl_RecoilSlider
         MaxValue=2.000000
         Caption="Recoil Scale"
         OnCreateComponent=sl_RecoilSlider.InternalOnCreateComponent
         Hint="Scale the amount of recoil applied to ballistic weapons."
         WinTop=0.500000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     sl_Recoil=moSlider'BallisticProV55.BallisticTab_RulesPro.sl_RecoilSlider'

     Begin Object Class=moFloatEdit Name=fl_DamageFloat
         MinValue=0.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Damage Scale"
         OnCreateComponent=fl_DamageFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the amount of damage done to non vehicles."
         WinTop=0.700000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_Damage=moFloatEdit'BallisticProV55.BallisticTab_RulesPro.fl_DamageFloat'

     Begin Object Class=moFloatEdit Name=fl_VDamageFloat
         MinValue=0.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Vehicle Damage Scale"
         OnCreateComponent=fl_VDamageFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the amount of damage done to vehicles."
         WinTop=0.750000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_VDamage=moFloatEdit'BallisticProV55.BallisticTab_RulesPro.fl_VDamageFloat'

     Begin Object Class=moCheckBox Name=ch_ForceBWPawnCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Force Ballistic Pawn"
         OnCreateComponent=ch_ForceBWPawnCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Causes the mutator to override any custom Pawn class in use by the gametype.|Increases internal compatibility, but may break custom gametypes and mutators that need to replace the Pawn class."
         WinTop=0.800000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_ForceBWPawn=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_ForceBWPawnCheck'

     Begin Object Class=moCheckBox Name=ch_NoReloadingCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Disable Reloading"
         OnCreateComponent=ch_NoReloadingCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disables weapons needing to be reloaded."
         WinTop=0.850000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_NoReloading=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_NoReloadingCheck'

     Begin Object Class=moCheckBox Name=ch_AllowDodgingCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Allow Dodging"
         OnCreateComponent=ch_AllowDodgingCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enables dodging."
         WinTop=0.900000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_AllowDodging=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_AllowDodgingCheck'

    Begin Object Class=moCheckBox Name=ch_AllowDoubleJumpCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Allow Double Jump"
         OnCreateComponent=ch_AllowDoubleJumpCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enables double jump."
         WinTop=0.950000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_AllowDoubleJump=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_AllowDoubleJumpCheck'

}
