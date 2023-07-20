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

var automated moComboBox		co_Crosshairs, co_ADSHandling, co_ModeMemory;
var automated moFloatEdit		fl_ZoomTimeMod;
var automated moCheckbox		ch_WeaponUI, ch_SimpleDeathMessages, ch_LessDisruptiveFlash;

function LoadSettings()
{
	co_Crosshairs.AddItem("Simple" ,,string(0));
	co_Crosshairs.AddItem("Graphical" ,,string(1));
	co_Crosshairs.AddItem("UT2004" ,,string(2));
	co_Crosshairs.ReadOnly(True);
	co_Crosshairs.SetIndex(class'BallisticWeapon'.default.CrosshairMode);

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
	ch_LessDisruptiveFlash.Checked(class'BallisticDamageType'.default.bLessDisruptiveFlash);
}

function SaveSettings()
{
	if (!bInitialized)
		return;

 	class'BallisticWeapon'.default.CrosshairMode		= ECrosshairMode(co_Crosshairs.GetIndex());
    class'BallisticWeapon'.default.ScopeHandling		= EScopeHandling(co_ADSHandling.GetIndex());
	class'BallisticWeapon'.default.ModeHandling			= ModeSaveType(co_ModeMemory.GetIndex());
	class'BallisticPlayer'.default.ZoomTimeMod			= fl_ZoomTimeMod.GetValue();
	class'BallisticPlayer'.default.bUseWeaponUI 			= ch_WeaponUI.IsChecked();
	class'BallisticDamageType'.default.bSimpleDeathMessages	= ch_SimpleDeathMessages.IsChecked();
	class'BallisticDamageType'.default.bLessDisruptiveFlash	= ch_LessDisruptiveFlash.IsChecked();

	class'BallisticWeapon'.static.StaticSaveConfig();
	class'BallisticDamageType'.static.StaticSaveConfig();
	class'BallisticPlayer'.static.StaticSaveConfig();
}

function DefaultSettings()
{
	co_Crosshairs.SetIndex(0);
	co_ADSHandling.SetIndex(0);
	co_ModeMemory.SetIndex(0);
	fl_ZoomTimeMod.SetValue(1.5);
	ch_WeaponUI.Checked(false); // gets you killed
	ch_SimpleDeathMessages.Checked(false); // compromise
}

defaultproperties
{
	Begin Object Class=moComboBox Name=co_CrosshairCombo
        ComponentJustification=TXTA_Left
        CaptionWidth=0.550000
        Caption="Crosshair Type"
        OnCreateComponent=co_CrosshairCombo.InternalOnCreateComponent
        IniOption="@Internal"
        Hint="Which crosshairs to use.||Simple: Draws simple crosshairs which show hipfire inaccuracy and change color to indicate when a weapon needs reloading or cocking.||Graphical: Draws custom, configurable graphical crosshairs for each weapon.||UT2004: Uses your Unreal Tournament 2004 crosshairs for each weapon."
        WinTop=0.1
        WinLeft=0.250000
     End Object
     co_Crosshairs=moComboBox'co_CrosshairCombo'

     Begin Object Class=moComboBox Name=co_ADSHandlingCombo
        ComponentJustification=TXTA_Left
        CaptionWidth=0.550000
        Caption="Aim Down Sight Handling"
        OnCreateComponent=co_ADSHandlingCombo.InternalOnCreateComponent
        IniOption="@Internal"
        Hint="How the ADS key should function.||Default: Hold to raise the weapon into scope. Weapon stays in scope until key is pressed again.||Hold: Hold key to ADS. Release to lower.||Toggle: Press key to ADS. Press again to lower."
        WinTop=0.15
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
         WinTop=0.2
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
         WinTop=0.25
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
         WinTop=0.3
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
         WinTop=0.35
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_SimpleDeathMessages=moCheckBox'ch_SimpleDeathMessagesCheck'	 

	 Begin Object Class=moCheckBox Name=ch_LessDisruptiveFlashCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Reduce Flash Intensity"
         OnCreateComponent=ch_LessDisruptiveFlashCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Changes white blinding flashes to black"
         WinTop=0.40
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_LessDisruptiveFlash=moCheckBox'ch_LessDisruptiveFlashCheck'	 
}
