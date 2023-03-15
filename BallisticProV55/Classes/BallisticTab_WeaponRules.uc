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
class BallisticTab_WeaponRules extends UT2K4TabPanel;

var automated moEditBox   	eb_ItemGroup;		//The name of the Itemizer layout you want to use.
var automated moCheckbox	ch_UseItemizer; 	//Enable Itemizer to spawn aditional pickups in maps.
var automated moCheckbox	ch_RandomDefaults;	//Players will spawn with a random weapon instead of stock pistol.
var automated moCheckbox	ch_WeaponJumpOffsetting;	//Disable Weapon Displacement when Running & Jumping
var automated moCheckbox	ch_LongWeaponOffsetting;		//Disable Weapon Displacement when Near a Wall
var automated moCheckbox	ch_NoReloading;		//Disable Reloading
var automated moCheckbox	ch_RunningAnims;	//Running Animations while ADS
var automated moCheckbox	ch_MineLights;		//All Players can see Lights on Mines
var automated moSlider		sl_Accuracy;		//Accuracy Scale
var automated moSlider		sl_Recoil;			//Recoil Scale
var automated moFloatEdit	fl_Damage;			//Damage Scale against Players & Pawns
var automated moFloatEdit	fl_VDamage;			//Damage Scale against Vehicles
var automated moFloatEdit	fl_WalkingPct;		//ADS Move Speed Percentage
var automated moFloatEdit	fl_CrouchingPct;	//Crouch Move Speed Percentage
var automated moFloatEdit	fl_ReloadSpeed;		//Reload Rate Scale

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
	local class<BC_GameStyle_Config> style;

	ch_RandomDefaults.Checked(class'Mut_Ballistic'.default.bRandomDefaultWeapons);
	ch_UseItemizer.Checked(class'Mut_Ballistic'.default.bUseItemizer);
	eb_ItemGroup.SetText(class'Mut_Ballistic'.default.ItemGroup);

	fl_Damage.SetValue(class'Rules_Ballistic'.default.DamageScale);
	fl_VDamage.SetValue(class'Rules_Ballistic'.default.VehicleDamageScale);

	style = class'BallisticGameStyles'.static.GetClientLocalConfigStyle();

	if (style != None)
	{
		sl_Accuracy.SetValue(style.default.AccuracyScale);
		sl_Recoil.SetValue(style.default.RecoilScale);
		ch_WeaponJumpOffsetting.Checked(style.default.bWeaponJumpOffsetting);
		ch_LongWeaponOffsetting.Checked(style.default.bLongWeaponOffsetting);
		ch_NoReloading.Checked(style.default.bNoReloading);
		fl_WalkingPct.SetValue(style.default.PlayerWalkSpeedFactor);
		fl_CrouchingPct.SetValue(style.default.PlayerCrouchSpeedFactor);
	}
}

function SaveSettings()
{
	local class<BC_GameStyle_Config> style;

	if (!bInitialized)
		return;

	class'Mut_Ballistic'.default.ItemGroup		 					= eb_ItemGroup.GetText();
	class'Mut_Ballistic'.default.bUseItemizer	 					= ch_UseItemizer.IsChecked();
	class'Mut_Ballistic'.default.bRandomDefaultWeapons 				= ch_RandomDefaults.IsChecked();
	class'Mut_Ballistic'.static.StaticSaveConfig();

	class'Rules_Ballistic'.default.DamageScale 						= fl_Damage.GetValue();
	class'Rules_Ballistic'.default.VehicleDamageScale				= fl_VDamage.GetValue();
	class'Rules_Ballistic'.static.StaticSaveConfig();

	style = class'BallisticGameStyles'.static.GetClientLocalConfigStyle();

	if (style != None)
	{
		style.default.AccuracyScale			= sl_Accuracy.GetValue();
		style.default.RecoilScale				= sl_Recoil.GetValue();
		style.default.bWeaponJumpOffsetting			= ch_WeaponJumpOffsetting.IsChecked();
		style.default.bLongWeaponOffsetting				= ch_LongWeaponOffsetting.IsChecked();
		style.default.bNoReloading			= ch_NoReloading.IsChecked();
		style.default.PlayerWalkSpeedFactor 		= fl_WalkingPct.GetValue();
		style.default.PlayerCrouchSpeedFactor 	= fl_CrouchingPct.GetValue();
		style.static.StaticSaveConfig();
	}
}

function DefaultSettings()
{
	ch_RandomDefaults.Checked(true);
	ch_UseItemizer.Checked(true);
	eb_ItemGroup.SetText("Ballistic");
	sl_Accuracy.SetValue(1.0);
	sl_Recoil.SetValue(1.0);
	fl_Damage.SetValue(1.0);
	fl_VDamage.SetValue(1.0);
	fl_ReloadSpeed.SetValue(1);
	ch_WeaponJumpOffsetting.Checked(false);
	ch_LongWeaponOffsetting.Checked(false);
	ch_NoReloading.Checked(false);
	fl_WalkingPct.SetValue(0.75);
	fl_CrouchingPct.SetValue(0.4);
	ch_MineLights.Checked(True);
	ch_RunningAnims.Checked(True);
}

defaultproperties
{
	 Begin Object Class=moSlider Name=sl_AccuracySlider
         MaxValue=2.000000
         Caption="Inaccuracy Scale"
         OnCreateComponent=sl_AccuracySlider.InternalOnCreateComponent
         Hint="Scale the inaccuracy of ballistic weapons."
         WinTop=0.050000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     sl_Accuracy=moSlider'BallisticProV55.BallisticTab_WeaponRules.sl_AccuracySlider'

     Begin Object Class=moSlider Name=sl_RecoilSlider
         MaxValue=2.000000
         Caption="Recoil Scale"
         OnCreateComponent=sl_RecoilSlider.InternalOnCreateComponent
         Hint="Scale the amount of recoil applied to ballistic weapons."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     sl_Recoil=moSlider'BallisticProV55.BallisticTab_WeaponRules.sl_RecoilSlider'

	 Begin Object Class=moFloatEdit Name=fl_DamageFloat
         MinValue=0.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Damage Scale"
         OnCreateComponent=fl_DamageFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the amount of damage done to non vehicles."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_Damage=moFloatEdit'BallisticProV55.BallisticTab_WeaponRules.fl_DamageFloat'

     Begin Object Class=moFloatEdit Name=fl_VDamageFloat
         MinValue=0.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Vehicle Damage Scale"
         OnCreateComponent=fl_VDamageFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the amount of damage done to vehicles."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_VDamage=moFloatEdit'BallisticProV55.BallisticTab_WeaponRules.fl_VDamageFloat'
	 
	 Begin Object Class=moFloatEdit Name=fl_WalkingPctFloat
         MinValue=0.400000
         MaxValue=1.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.800000
         Caption="ADS Move Speed Percentage"
         OnCreateComponent=fl_WalkingPctFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales player movement speed when aiming weapons. 0.5 to 1.0 = 50% to 100% of run speed. This is also the walking speed"
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_WalkingPct=moFloatEdit'BallisticProV55.BallisticTab_WeaponRules.fl_WalkingPctFloat'

     Begin Object Class=moFloatEdit Name=fl_CrouchingPctFloat
         MinValue=0.200000
         MaxValue=0.600000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.800000
         Caption="Crouch Move Speed Percentage"
         OnCreateComponent=fl_CrouchingPctFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the crouch speed. 0.2 to 0.6 = 20% to 60% of run speed."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_CrouchingPct=moFloatEdit'BallisticProV55.BallisticTab_WeaponRules.fl_CrouchingPctFloat'

	 Begin Object Class=moCheckBox Name=ch_RunningAnimsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Use Run Anims For ADS Movement"
         OnCreateComponent=ch_RunningAnimsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Sets player walk anims to run anims."
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_RunningAnims=moCheckBox'BallisticProV55.BallisticTab_WeaponRules.ch_RunningAnimsCheck'

	 Begin Object Class=moCheckBox Name=ch_SprintAimCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Stable Jump/Sprint"
         OnCreateComponent=ch_SprintAimCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disables weapon aiming off when jumping or sprinting"
         WinTop=0.400000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_WeaponJumpOffsetting=moCheckBox'BallisticProV55.BallisticTab_WeaponRules.ch_SprintAimCheck'

     Begin Object Class=moCheckBox Name=ch_LongWeaponOffsettingCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="No Long Gun Shifting"
         OnCreateComponent=ch_LongWeaponOffsettingCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disables long weapons shifting off when too close to obstuctions"
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_LongWeaponOffsetting=moCheckBox'BallisticProV55.BallisticTab_WeaponRules.ch_LongWeaponOffsettingCheck'
	
	 Begin Object Class=moFloatEdit Name=fl_ReloadSpeedFloat
         MinValue=1.000000
         MaxValue=1.500000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.750000
         Caption="Reload Speed Scale"
         OnCreateComponent=fl_ReloadSpeedFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the Reloading Speed. 1 to 1.5 = 100% to 150%."
         WinTop=0.500000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_ReloadSpeed=moFloatEdit'BallisticProV55.BallisticTab_WeaponRules.fl_ReloadSpeedFloat'

	
	 Begin Object Class=moCheckBox Name=ch_NoReloadingCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Disable Reloading"
         OnCreateComponent=ch_NoReloadingCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disables weapons needing to be reloaded"
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_NoReloading=moCheckBox'BallisticProV55.BallisticTab_WeaponRules.ch_NoReloadingCheck'

     /*Begin Object Class=moCheckBox Name=ch_RandomDefaultsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Random Default Weapons"
         OnCreateComponent=ch_RandomDefaultsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Players will spawn with a random sidearm instead of stock pistol."
         WinTop=0.600000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_RandomDefaults=moCheckBox'BallisticProV55.BallisticTab_WeaponRules.ch_RandomDefaultsCheck'*/
	 
	 Begin Object Class=moCheckBox Name=ch_MineLightsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="BX5 Mines Lit For All"
         OnCreateComponent=ch_MineLightsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Toggles BX5 mine lights for all players."
         WinTop=0.600000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_MineLights=moCheckBox'BallisticProV55.BallisticTab_WeaponRules.ch_MineLightsCheck'

	 Begin Object Class=moCheckBox Name=UseItemizerCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Use itemizer"
         OnCreateComponent=UseItemizerCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Use the Itemizer to spawn aditional pickups in maps."
         WinTop=0.6500000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_UseItemizer=moCheckBox'BallisticProV55.BallisticTab_WeaponRules.UseItemizerCheck'

     Begin Object Class=moEditBox Name=eb_ItemGroupEdit
         CaptionWidth=0.250000
         Caption="Itemizer Group"
         OnCreateComponent=eb_ItemGroupEdit.InternalOnCreateComponent
         Hint="The name of the Itemizer layout you want to use. Defaults to 'Ballistic'."
         WinTop=0.700000
         WinLeft=0.250000
         WinHeight=0.060000
     End Object
     eb_ItemGroup=moEditBox'BallisticProV55.BallisticTab_WeaponRules.eb_ItemGroupEdit'
	 
}