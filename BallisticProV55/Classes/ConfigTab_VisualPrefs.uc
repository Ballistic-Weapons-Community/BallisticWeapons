//=============================================================================
// ConfigTab_VisualPrefs
//
// The preferences tab has options that are kept client-side and affect only
// the local player.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ConfigTab_VisualPrefs extends ConfigTabBase;

var automated moCheckbox	ch_UseBrass, ch_ImpStay, ch_MSmoke, ch_MotionBlur;
var automated moComboBox	co_WeaponDet, co_CamRate, co_EffectDet;
var automated moFloatEdit	fl_BrassTime;

var			  int			OldWeaponDet;

function LoadSettings()
{
	local int i;

	ch_UseBrass.Checked(class'BallisticMod'.default.bEjectBrass);
	ch_ImpStay.Checked(class'AD_ImpactDecal'.default.bPermanentImpacts);
	ch_MSmoke.Checked(class'BallisticMod'.default.bMuzzleSmoke);
	fl_BrassTime.SetValue(class'BallisticBrass'.default.LifeTimeScale);
	ch_MotionBlur.Checked(class'BallisticMod'.default.bUseMotionBlur);

	for(i=0;i<class'Mut_Ballistic'.default.CamRateOptions.length;i++)
	    co_CamRate.AddItem(class'Mut_Ballistic'.default.CamRateOptions[i] ,,string(i));
	co_CamRate.ReadOnly(True);
	co_CamRate.SetIndex(int(class'Mut_Ballistic'.default.CamUpdateRate));

	for (i=1;i<6;i+=2)
	    co_EffectDet.AddItem(class'UT2K4Tab_DetailSettings'.default.DetailLevels[i] ,,string(i));
	co_EffectDet.ReadOnly(True);
	co_EffectDet.SetIndex(class'BallisticMod'.default.EffectsDetailMode);
	
	for (i=0;i<9;i++)
		co_WeaponDet.AddItem(class'UT2K4Tab_DetailSettings'.default.DetailLevels[i]);
	co_WeaponDet.ReadOnly(True);
	OldWeaponDet = co_WeaponDet.FindIndex(ConfigMenu_Preferences(BaseMenu).GetDisplayString(PlayerOwner().ConsoleCommand("get ini:Engine.Engine.ViewportManager TextureDetailWeaponSkin")));
	co_WeaponDet.SilentSetIndex(OldWeaponDet);
}

function SaveSettings()
{
	if (!bInitialized)
		return;
	class'Mut_Ballistic'.default.CamUpdateRate 			= string(co_CamRate.GetIndex());
	class'BallisticMod'.default.EffectsDetailMode 		= ELLHDetailMode(co_EffectDet.GetIndex());
	class'BallisticMod'.default.bEjectBrass 			= ch_useBrass.IsChecked();
	class'AD_ImpactDecal'.default.bPermanentImpacts		= ch_ImpStay.IsChecked();
	class'BallisticMod'.default.bMuzzleSmoke 			= ch_MSmoke.IsChecked();
	class'BallisticBrass'.default.LifeTimeScale			= fl_BrassTime.GetValue();
	class'BallisticMod'.default.bUseMotionBlur 			= ch_MotionBlur.IsChecked();
	
	class'Mut_Ballistic'.static.StaticSaveConfig();
	class'BallisticMod'.static.StaticSaveConfig();
	class'AD_ImpactDecal'.static.StaticSaveConfig();
	class'BallisticBrass'.static.StaticSaveConfig();

	if (co_WeaponDet.GetIndex() != OldWeaponDet)
	{
		PlayerOwner().ConsoleCommand("set ini:Engine.Engine.ViewportManager TextureDetailWeaponSkin" @ ConfigMenu_Preferences(BaseMenu).DetailSettings[co_WeaponDet.GetIndex()]);
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
	ch_MSmoke.Checked(true);
	ch_MotionBlur.Checked(false);
}

defaultproperties
{
     Begin Object Class=moComboBox Name=co_WeaponDetCombo
         ComponentJustification=TXTA_Left
         CaptionWidth=0.550000
         Caption="Weapon Detail"
         OnCreateComponent=co_WeaponDetCombo.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="High"
         Hint="Choose the detail level for weapon textures. This should be set after changing the 'Character Detail' setting in the options menu as it will override this setting."
         WinTop=0.10000
         WinLeft=0.250000
     End Object
     co_WeaponDet=moComboBox'co_WeaponDetCombo'
	 
	 Begin Object Class=moComboBox Name=co_EffectDetCombo
         ComponentJustification=TXTA_Left
         CaptionWidth=0.550000
         Caption="Effects Quality"
         OnCreateComponent=co_EffectDetCombo.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="High"
         Hint="Choose the quality level for Ballistic effects. Remember, if the 'World Detail' setting is lower, it will affect the quality of BW effects."
         WinTop=0.150000
         WinLeft=0.250000
     End Object
     co_EffectDet=moComboBox'co_EffectDetCombo'
	 
	 Begin Object Class=moComboBox Name=co_CamRateCombo
         ComponentJustification=TXTA_Left
         CaptionWidth=0.550000
         Caption="Camera Update Rate"
         OnCreateComponent=co_CamRateCombo.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="How fast camera view screens like the M50's LCD should update."
         WinTop=0.20000
         WinLeft=0.250000
     End Object
     co_CamRate=moComboBox'co_CamRateCombo'

	 Begin Object Class=moCheckBox Name=ch_UseBrassCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Eject Brass"
         OnCreateComponent=ch_UseBrassCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Allow weapons to spew out shell casings and similar effects."
         WinTop=0.25000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_UseBrass=moCheckBox'ch_UseBrassCheck'

	 Begin Object Class=moFloatEdit Name=fl_BrassTimeFloat
         MinValue=0.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Brass Life Scale [!]"
         OnCreateComponent=fl_BrassTimeFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the life time of ejected brass. 0 = Forever."
         WinTop=0.30000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_BrassTime=moFloatEdit'fl_BrassTimeFloat'

	 Begin Object Class=moCheckBox Name=ch_MSmokeCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Muzzle Smoke"
         OnCreateComponent=ch_MSmokeCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable muzzle smoke emitting when firing guns."
         WinTop=0.35000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_MSmoke=moCheckBox'ch_MSmokeCheck'

	 Begin Object Class=moCheckBox Name=ch_ImpStayCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Permanent Impact Marks [!]"
         OnCreateComponent=ch_ImpStayCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Impact marks like bullet holes and explosion scorches stay forever. WARNING: This can kill performance on most machines!"
         WinTop=0.40000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_ImpStay=moCheckBox'ch_ImpStayCheck'

	 Begin Object Class=moCheckBox Name=ch_MotionBlurCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Motion Blur [!]"
         OnCreateComponent=ch_MotionBlurCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable the use of motion blur effects. WARNING: This may have undesirable effects on some machines!"
         WinTop=0.45000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_MotionBlur=moCheckBox'ch_MotionBlurCheck'
	 
}
