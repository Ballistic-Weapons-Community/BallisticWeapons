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
class ConfigTab_WeaponRules extends ConfigTabBase;

var automated moSlider		sl_Sway;					//Sway Scale
var automated moSlider		sl_Recoil;					//Recoil Scale
var automated moFloatEdit	fl_Damage;					//Damage Scale against Players & Pawns
var automated moFloatEdit	fl_VDamage;					//Damage Scale against Vehicles

var automated moCheckbox	ch_WeaponJumpOffsetting;	//Disable Weapon Displacement when Running & Jumping
var automated moCheckbox	ch_LongWeaponOffsetting;	//Disable Weapon Displacement when Near a Wall
var automated moCheckbox	ch_NoReloading;				//Disable Reloading
var automated moNumericEdit int_MaxInventoryCapacity;	//Inventory Capacity

var automated moEditBox   	eb_ItemGroup;				//The name of the Itemizer layout you want to use.
var automated moCheckbox	ch_UseItemizer; 			//Enable Itemizer to spawn aditional pickups in maps.

//==================================================================
// Settings & Defaults
//==================================================================

function LoadSettings()
{
	local class<BC_GameStyle_Config> style;

	style = BaseMenu.GetConfigStyle();

	if (style != None)
	{
		sl_Sway.SetValue(style.default.SwayScale);
		sl_Recoil.SetValue(style.default.RecoilScale);
		fl_Damage.SetValue(style.default.DamageScale);
		ch_WeaponJumpOffsetting.Checked(style.default.bWeaponJumpOffsetting);
		ch_LongWeaponOffsetting.Checked(style.default.bLongWeaponOffsetting);
		int_MaxInventoryCapacity.SetValue(style.default.MaxInventoryCapacity);
		ch_NoReloading.Checked(style.default.bNoReloading);
	}

	fl_VDamage.SetValue(class'Rules_Ballistic'.default.VehicleDamageScale);

	ch_UseItemizer.Checked(class'Mut_Ballistic'.default.bUseItemizer);
	eb_ItemGroup.SetText(class'Mut_Ballistic'.default.ItemGroup);
}

function SaveSettings()
{
	local class<BC_GameStyle_Config> style;

	if (!bInitialized)
		return;

	style = BaseMenu.GetConfigStyle();

	if (style != None)
	{
		style.default.SwayScale					= sl_Sway.GetValue();
		style.default.RecoilScale					= sl_Recoil.GetValue();
		style.default.DamageScale					= fl_Damage.GetValue();
		style.default.bWeaponJumpOffsetting			= ch_WeaponJumpOffsetting.IsChecked();
		style.default.bLongWeaponOffsetting			= ch_LongWeaponOffsetting.IsChecked();
		style.default.bNoReloading					= ch_NoReloading.IsChecked();
		style.default.MaxInventoryCapacity 			= int_MaxInventoryCapacity.GetValue();	
		style.static.StaticSaveConfig();
	}

	class'Rules_Ballistic'.default.DamageScale 						= fl_Damage.GetValue();
	class'Rules_Ballistic'.default.VehicleDamageScale				= fl_VDamage.GetValue();
	class'Rules_Ballistic'.static.StaticSaveConfig();

	class'Mut_Ballistic'.default.ItemGroup		 					= eb_ItemGroup.GetText();
	class'Mut_Ballistic'.default.bUseItemizer	 					= ch_UseItemizer.IsChecked();
	class'Mut_Ballistic'.static.StaticSaveConfig();
}

function DefaultSettings()
{
	sl_Sway.SetValue(1.0);
	sl_Recoil.SetValue(1.0);
	fl_Damage.SetValue(1.0);
	fl_VDamage.SetValue(1.0);
	ch_WeaponJumpOffsetting.Checked(false);
	ch_LongWeaponOffsetting.Checked(false);
	ch_NoReloading.Checked(false);
	int_MaxInventoryCapacity.SetValue(0);

	ch_UseItemizer.Checked(true);
	eb_ItemGroup.SetText("Ballistic");
}

defaultproperties
{
	 Begin Object Class=moSlider Name=sl_SwaySlider
         MaxValue=2.000000
         Caption="Sway Scale"
         OnCreateComponent=sl_SwaySlider.InternalOnCreateComponent
         Hint="Scale the degree of sway of ballistic weapons."
         WinTop=0.10000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     sl_Sway=moSlider'sl_SwaySlider'

     Begin Object Class=moSlider Name=sl_RecoilSlider
         MaxValue=2.000000
         Caption="Recoil Scale"
         OnCreateComponent=sl_RecoilSlider.InternalOnCreateComponent
         Hint="Scale the amount of recoil applied to ballistic weapons."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     sl_Recoil=moSlider'sl_RecoilSlider'

	 Begin Object Class=moFloatEdit Name=fl_DamageFloat
         MinValue=0.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Damage Scale"
         OnCreateComponent=fl_DamageFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the amount of damage done to non vehicles."
         WinTop=0.20000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_Damage=moFloatEdit'fl_DamageFloat'

     Begin Object Class=moFloatEdit Name=fl_VDamageFloat
         MinValue=0.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Vehicle Damage Scale"
         OnCreateComponent=fl_VDamageFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the amount of damage done to vehicles."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_VDamage=moFloatEdit'fl_VDamageFloat'
	 
	 Begin Object Class=moCheckBox Name=ch_SprintAimCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Stable Jump/Sprint"
         OnCreateComponent=ch_SprintAimCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disables weapon aiming off when jumping or sprinting"
         WinTop=0.30000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_WeaponJumpOffsetting=moCheckBox'ch_SprintAimCheck'

     Begin Object Class=moCheckBox Name=ch_LongWeaponOffsettingCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="No Long Gun Shifting"
         OnCreateComponent=ch_LongWeaponOffsettingCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disables long weapons shifting off when too close to obstuctions"
         WinTop=0.35000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_LongWeaponOffsetting=moCheckBox'ch_LongWeaponOffsettingCheck'
	
	 Begin Object Class=moCheckBox Name=ch_NoReloadingCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Disable Reloading"
         OnCreateComponent=ch_NoReloadingCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disables weapons needing to be reloaded"
         WinTop=0.40000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_NoReloading=moCheckBox'ch_NoReloadingCheck'

	 	Begin Object Class=moNumericEdit Name=int_MaxWepsInt
         MinValue=0
         MaxValue=999
         ComponentJustification=TXTA_Left
         CaptionWidth=0.800000
         Caption="Player Inventory Capacity"
         OnCreateComponent=int_MaxWepsInt.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Sets the player's maximum inventory capacity. 0 is infinite."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     int_MaxInventoryCapacity=moNumericEdit'int_MaxWepsInt'

	 Begin Object Class=moCheckBox Name=UseItemizerCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Use itemizer"
         OnCreateComponent=UseItemizerCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Use the Itemizer to spawn aditional pickups in maps."
         WinTop=0.500000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_UseItemizer=moCheckBox'UseItemizerCheck'

     Begin Object Class=moEditBox Name=eb_ItemGroupEdit
         CaptionWidth=0.250000
         Caption="Itemizer Group"
         OnCreateComponent=eb_ItemGroupEdit.InternalOnCreateComponent
         Hint="The name of the Itemizer layout you want to use. Defaults to 'Ballistic'."
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.060000
     End Object
     eb_ItemGroup=moEditBox'eb_ItemGroupEdit'



}