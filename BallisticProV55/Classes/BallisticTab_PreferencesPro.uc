//=============================================================================
// BallisticTab_PreferencesPro.
//
// The preferences tab has options that are kept client-side and affect only
// the local player.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticTab_PreferencesPro extends UT2K4TabPanel;

var automated moCheckbox	ch_UseBrass, ch_ImpStay, ch_MSmoke, ch_WeaponUI, ch_MotionBlur, ch_SimpleDeathMessages, ch_OldCrosshairs;

var automated moComboBox	co_WeaponDet, co_CamRate, co_EffectDet, co_ModeMemory;
var automated moFloatEdit	fl_BrassTime, fl_ZoomTimeMod;

var			  int			OldWeaponDet;

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
	local int i;

	ch_UseBrass.Checked(class'BallisticMod'.default.bEjectBrass);
	ch_ImpStay.Checked(class'AD_ImpactDecal'.default.bPermanentImpacts);
	ch_MSmoke.Checked(class'BallisticMod'.default.bMuzzleSmoke);
	fl_BrassTime.SetValue(class'BallisticBrass'.default.LifeTimeScale);
	ch_WeaponUI.Checked(class'BallisticPlayer'.default.bUseWeaponUI);
	ch_MotionBlur.Checked(class'BallisticMod'.default.bUseMotionBlur);
	ch_SimpleDeathMessages.Checked(class'BallisticDamageType'.default.bSimpleDeathMessages);
	ch_OldCrosshairs.Checked(class'BallisticWeapon'.default.bOldCrosshairs);

	for(i=0;i<class'Mut_Ballistic'.default.CamRateOptions.length;i++)
	    co_CamRate.AddItem(class'Mut_Ballistic'.default.CamRateOptions[i] ,,string(i));
	co_CamRate.ReadOnly(True);
	co_CamRate.SetIndex(int(class'Mut_Ballistic'.default.CamUpdateRate));

	for (i=1;i<6;i+=2)
	    co_EffectDet.AddItem(class'UT2K4Tab_DetailSettings'.default.DetailLevels[i] ,,string(i));
	co_EffectDet.ReadOnly(True);
	co_EffectDet.SetIndex(class'BallisticMod'.default.EffectsDetailMode);
	
	co_ModeMemory.AddItem("None" ,,string(0));
	co_ModeMemory.AddItem("Last Mode" ,,string(1));
	co_ModeMemory.AddItem("Saved Mode" ,,string(2));
	co_ModeMemory.ReadOnly(True);
	co_ModeMemory.SetIndex(class'BallisticWeapon'.default.ModeHandling);
	
	fl_ZoomTimeMod.SetValue(class'BallisticPlayer'.default.ZoomTimeMod);

	for (i=0;i<9;i++)
		co_WeaponDet.AddItem(class'UT2K4Tab_DetailSettings'.default.DetailLevels[i]);
	co_WeaponDet.ReadOnly(True);
	OldWeaponDet = co_WeaponDet.FindIndex(p_Anchor.GetDisplayString(PlayerOwner().ConsoleCommand("get ini:Engine.Engine.ViewportManager TextureDetailWeaponSkin")));
	co_WeaponDet.SilentSetIndex(OldWeaponDet);
}

function SaveSettings()
{
	if (!bInitialized)
		return;
	class'Mut_Ballistic'.default.CamUpdateRate 			= string(co_CamRate.GetIndex());
	class'BallisticWeapon'.default.ModeHandling			= ModeSaveType(co_ModeMemory.GetIndex());
	class'BallisticWeapon'.default.bOldCrosshairs			=	ch_OldCrosshairs.IsChecked();
	class'BallisticMod'.default.EffectsDetailMode 		= ELLHDetailMode(co_EffectDet.GetIndex());
	class'BallisticMod'.default.bEjectBrass 			= ch_useBrass.IsChecked();
	class'AD_ImpactDecal'.default.bPermanentImpacts		= ch_ImpStay.IsChecked();
	class'BallisticMod'.default.bMuzzleSmoke 			= ch_MSmoke.IsChecked();
	class'BallisticBrass'.default.LifeTimeScale			= fl_BrassTime.GetValue();
	class'BallisticPlayer'.default.bUseWeaponUI 			= ch_WeaponUI.IsChecked();
	class'BallisticMod'.default.bUseMotionBlur 				= false; //ch_MotionBlur.IsChecked();
	class'BallisticDamageType'.default.bSimpleDeathMessages	= ch_SimpleDeathMessages.IsChecked();
	class'BallisticPlayer'.default.ZoomTimeMod			= fl_ZoomTimeMod.GetValue();
	
	class'BallisticDamageType'.static.StaticSaveConfig();
	class'Mut_Ballistic'.static.StaticSaveConfig();
	class'BallisticMod'.static.StaticSaveConfig();
	class'AD_ImpactDecal'.static.StaticSaveConfig();
	class'BallisticBrass'.static.StaticSaveConfig();
	class'BallisticPlayer'.static.StaticSaveConfig();
	class'BallisticWeapon'.static.StaticSaveConfig();

	if (co_WeaponDet.GetIndex() != OldWeaponDet)
	{
		PlayerOwner().ConsoleCommand("set ini:Engine.Engine.ViewportManager TextureDetailWeaponSkin"@p_Anchor.DetailSettings[co_WeaponDet.GetIndex()]);
		PlayerOwner().ConsoleCommand("flush");
	}
}

function DefaultSettings()
{
	co_CamRate.SetIndex(1);
	co_EffectDet.SetIndex(2);
	co_WeaponDet.SilentSetIndex(OldWeaponDet);
	ch_UseBrass.Checked(true);
	fl_BrassTime.SetValue(1.0);
	ch_ImpStay.Checked(false);
	fl_ZoomTimeMod.SetValue(1.5);
	ch_OldCrosshairs.Checked(false);
	ch_MSmoke.Checked(true);
	ch_WeaponUI.Checked(true);
	ch_MotionBlur.Checked(false);
	ch_SimpleDeathMessages.Checked(true);
	co_ModeMemory.SetIndex(0);
}

defaultproperties
{
     Begin Object Class=moCheckBox Name=ch_UseBrassCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Eject Brass"
         OnCreateComponent=ch_UseBrassCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Allow weapons to spew out shell casings and similar effects."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_UseBrass=moCheckBox'BallisticProV55.BallisticTab_PreferencesPro.ch_UseBrassCheck'

     Begin Object Class=moCheckBox Name=ch_ImpStayCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Permanent Impact Marks"
         OnCreateComponent=ch_ImpStayCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Impact marks like bullet holes and explosion scorches stay forever. WARNING: This can kill performance on most machines!"
         WinTop=0.400000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_ImpStay=moCheckBox'BallisticProV55.BallisticTab_PreferencesPro.ch_ImpStayCheck'

     Begin Object Class=moCheckBox Name=ch_MSmokeCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Muzzle Smoke"
         OnCreateComponent=ch_MSmokeCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable muzzle smoke emitting when firing guns."
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_MSmoke=moCheckBox'BallisticProV55.BallisticTab_PreferencesPro.ch_MSmokeCheck'

     Begin Object Class=moCheckBox Name=ch_WeaponUICheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Weapon Selection UI"
         OnCreateComponent=ch_WeaponUICheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable the selection UI when changing weapons."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_WeaponUI=moCheckBox'BallisticProV55.BallisticTab_PreferencesPro.ch_WeaponUICheck'

     Begin Object Class=moCheckBox Name=ch_MotionBlurCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Motion Blur"
         OnCreateComponent=ch_MotionBlurCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable the use of motion blur effects. WARNING: This may have undesirable effects on some machines!"
         WinTop=0.500000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_MotionBlur=moCheckBox'BallisticProV55.BallisticTab_PreferencesPro.ch_MotionBlurCheck'

     Begin Object Class=moCheckBox Name=ch_SimpleDeathMessagesCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Simplify Death Messages"
         OnCreateComponent=ch_SimpleDeathMessagesCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Renders death messages as Killer [Weapon] Killed"
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_SimpleDeathMessages=moCheckBox'BallisticProV55.BallisticTab_PreferencesPro.ch_SimpleDeathMessagesCheck'

     Begin Object Class=moCheckBox Name=ch_OldCrosshairsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="UT2004 Crosshairs"
         OnCreateComponent=ch_OldCrosshairsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Drops back to UT2004 crosshairs."
         WinTop=0.600000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_OldCrosshairs=moCheckBox'BallisticProV55.BallisticTab_PreferencesPro.ch_OldCrosshairsCheck'

     Begin Object Class=moComboBox Name=co_WeaponDetCombo
         ComponentJustification=TXTA_Left
         CaptionWidth=0.550000
         Caption="Weapon Detail"
         OnCreateComponent=co_WeaponDetCombo.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="High"
         Hint="Choose the detail level for weapon textures. This should be set after changing the 'Character Detail' setting in the options menu as it will override this setting."
         WinTop=0.150000
         WinLeft=0.250000
     End Object
     co_WeaponDet=moComboBox'BallisticProV55.BallisticTab_PreferencesPro.co_WeaponDetCombo'

     Begin Object Class=moComboBox Name=co_CamRateCombo
         ComponentJustification=TXTA_Left
         CaptionWidth=0.550000
         Caption="Camera Update Rate"
         OnCreateComponent=co_CamRateCombo.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="How fast camera view screens like the M50's LCD should update."
         WinTop=0.100000
         WinLeft=0.250000
     End Object
     co_CamRate=moComboBox'BallisticProV55.BallisticTab_PreferencesPro.co_CamRateCombo'

     Begin Object Class=moComboBox Name=co_EffectDetCombo
         ComponentJustification=TXTA_Left
         CaptionWidth=0.550000
         Caption="Effects Quality"
         OnCreateComponent=co_EffectDetCombo.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="High"
         Hint="Choose the quality level for Ballistic effects. Remember, if the 'World Detail' setting is lower, it will affect the quality of BW effects."
         WinTop=0.200000
         WinLeft=0.250000
     End Object
     co_EffectDet=moComboBox'BallisticProV55.BallisticTab_PreferencesPro.co_EffectDetCombo'

     Begin Object Class=moComboBox Name=co_ModeCombo
         ComponentJustification=TXTA_Left
         CaptionWidth=0.550000
         Caption="Weapon Mode Memory"
         OnCreateComponent=co_ModeCombo.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="High"
         Hint="Controls how Ballistic handles the initial weapon mode when a weapon is spawned. ||None - the set default mode is always used. Last - the last used mode is used. ||Saved - uses the mode saved by the SetDefaultMode command.||Reset it with ClearDefaultMode and get its name with GetDefaultMode."
         WinTop=0.700000
         WinLeft=0.250000
     End Object
     co_ModeMemory=moComboBox'BallisticProV55.BallisticTab_PreferencesPro.co_ModeCombo'

     Begin Object Class=moFloatEdit Name=fl_BrassTimeFloat
         MinValue=0.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Brass Life Scale"
         OnCreateComponent=fl_BrassTimeFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the life time of ejected brass. 0 = Forever."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_BrassTime=moFloatEdit'BallisticProV55.BallisticTab_PreferencesPro.fl_BrassTimeFloat'

     Begin Object Class=moFloatEdit Name=fl_ZoomTimeModFloat
         MinValue=1.000000
         MaxValue=4.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Zoom Time Mod"
         OnCreateComponent=fl_ZoomTimeModFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Multiplier for the rate of change of zoom levels. 1 to 4."
         WinTop=0.650000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_ZoomTimeMod=moFloatEdit'BallisticProV55.BallisticTab_PreferencesPro.fl_ZoomTimeModFloat'

}
