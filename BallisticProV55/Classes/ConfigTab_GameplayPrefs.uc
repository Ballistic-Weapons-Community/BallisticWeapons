//=============================================================================
// ConfigTab_GameplayPrefs
//
// The preferences tab has options that are kept client-side and affect only
// the local player.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ConfigTab_GameplayPrefs extends ConfigTabBase;

var automated moComboBox		co_ADSHandling, co_ModeMemory;
var automated moFloatEdit		fl_ZoomTimeMod;
var automated moCheckbox		ch_WeaponUI, ch_SimpleDeathMessages;

function LoadSettings()
{
    co_ADSHandling.AddItem("Default" ,,string(0));
	co_ADSHandling.AddItem("Hold" ,,string(1));
	co_ADSHandling.AddItem("Toggle" ,,string(2));
	co_ADSHandling.ReadOnly(True);
	co_ADSHandling.SetIndex(class'BallisticWeapon'.default.ScopeHandling);

	co_ModeMemory.AddItem("None" ,,string(0));
	co_ModeMemory.AddItem("Last Mode" ,,string(1));
	co_ModeMemory.AddItem("Saved Mode" ,,string(2));
	co_ModeMemory.ReadOnly(True);
	co_ModeMemory.SetIndex(class'BallisticWeapon'.default.ModeHandling);

	fl_ZoomTimeMod.SetValue(class'BallisticPlayer'.default.ZoomTimeMod);

	ch_WeaponUI.Checked(class'BallisticPlayer'.default.bUseWeaponUI);
	ch_SimpleDeathMessages.Checked(class'BallisticDamageType'.default.bSimpleDeathMessages);
}

function SaveSettings()
{
	if (!bInitialized)
		return;

    class'BallisticWeapon'.default.ScopeHandling		= EScopeHandling(co_ADSHandling.GetIndex());
	class'BallisticWeapon'.default.ModeHandling			= ModeSaveType(co_ModeMemory.GetIndex());
	class'BallisticPlayer'.default.ZoomTimeMod			= fl_ZoomTimeMod.GetValue();
	class'BallisticPlayer'.default.bUseWeaponUI 			= ch_WeaponUI.IsChecked();
	class'BallisticDamageType'.default.bSimpleDeathMessages	= ch_SimpleDeathMessages.IsChecked();

	class'BallisticWeapon'.static.StaticSaveConfig();
	class'BallisticDamageType'.static.StaticSaveConfig();
	class'BallisticPlayer'.static.StaticSaveConfig();
}

function DefaultSettings()
{
	co_ADSHandling.SetIndex(0);
	co_ModeMemory.SetIndex(0);
	fl_ZoomTimeMod.SetValue(1.5);
	ch_WeaponUI.Checked(false); // gets you killed
	ch_SimpleDeathMessages.Checked(false); // compromise
}

defaultproperties
{
     Begin Object Class=moComboBox Name=co_ADSHandlingCombo
        ComponentJustification=TXTA_Left
        CaptionWidth=0.550000
        Caption="Aim Down Sight Handling"
        OnCreateComponent=co_ADSHandlingCombo.InternalOnCreateComponent
        IniOption="@Internal"
        Hint="How the ADS key should function.||Default: Hold to raise the weapon into scope. Weapon stays in scope until key is pressed again.||Hold: Hold key to ADS. Release to lower.||Toggle: Press key to ADS. Press again to lower."
        WinTop=0.10000
        WinLeft=0.250000
     End Object
     co_ADSHandling=moComboBox'co_ADSHandlingCombo'

	 Begin Object Class=moComboBox Name=co_ModeCombo
         ComponentJustification=TXTA_Left
         CaptionWidth=0.550000
         Caption="Weapon Mode Memory"
         OnCreateComponent=co_ModeCombo.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="High"
         Hint="Controls how Ballistic handles the initial weapon mode when a weapon is spawned. ||None - the set default mode is always used.||Last - the last used mode is used. ||Saved - uses the mode saved by the SetDefaultMode command.||Reset it with ClearDefaultMode and get its name with GetDefaultMode."
         WinTop=0.15000
         WinLeft=0.250000
     End Object
     co_ModeMemory=moComboBox'co_ModeCombo'

	 Begin Object Class=moFloatEdit Name=fl_ZoomTimeModFloat
         MinValue=1.000000
         MaxValue=4.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Zoom Time Mod"
         OnCreateComponent=fl_ZoomTimeModFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Multiplier for the rate of change of zoom levels. 1 to 4."
         WinTop=0.20000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_ZoomTimeMod=moFloatEdit'fl_ZoomTimeModFloat'

	 Begin Object Class=moCheckBox Name=ch_WeaponUICheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Weapon Selection UI"
         OnCreateComponent=ch_WeaponUICheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable the selection UI when changing weapons."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_WeaponUI=moCheckBox'ch_WeaponUICheck'

	 Begin Object Class=moCheckBox Name=ch_SimpleDeathMessagesCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Simplify Death Messages"
         OnCreateComponent=ch_SimpleDeathMessagesCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Renders death messages as Killer [Weapon] Killed"
         WinTop=0.30000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_SimpleDeathMessages=moCheckBox'ch_SimpleDeathMessagesCheck'	 
}
