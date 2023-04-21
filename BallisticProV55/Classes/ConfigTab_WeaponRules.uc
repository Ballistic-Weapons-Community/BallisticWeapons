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
var automated moCheckbox	ch_NoRandomCamo;				//Disable Camo Randomizer
var automated moNumericEdit int_MaxInventoryCapacity;	//Inventory Capacity

var automated moEditBox   	eb_ItemGroup;				//The name of the Itemizer layout you want to use.
var automated moCheckbox	ch_UseItemizer; 			//Enable Itemizer to spawn aditional pickups in maps.

//==================================================================
// Settings & Defaults
//==================================================================

function LoadSettings()
{
	local class<BC_GameStyle_Config> game_style;

	game_style = BaseMenu.GetConfigStyle();

	if (game_style != None)
	{
		sl_Sway.SetValue(game_style.default.SwayScale);
		sl_Recoil.SetValue(game_style.default.RecoilScale);
		fl_Damage.SetValue(game_style.default.DamageScale);
		fl_VDamage.SetValue(game_style.default.VehicleDamageScale);
		ch_WeaponJumpOffsetting.Checked(game_style.default.bWeaponJumpOffsetting);
		ch_LongWeaponOffsetting.Checked(game_style.default.bLongWeaponOffsetting);
		int_MaxInventoryCapacity.SetValue(game_style.default.MaxInventoryCapacity);
		ch_NoReloading.Checked(game_style.default.bNoReloading);
		ch_NoRandomCamo.Checked(game_style.default.bNoRandomCamo);
	}

	ch_UseItemizer.Checked(class'Mut_Ballistic'.default.bUseItemizer);
	eb_ItemGroup.SetText(class'Mut_Ballistic'.default.ItemGroup);
}

function SaveSettings()
{
	local class<BC_GameStyle_Config> game_style;

	if (!bInitialized)
		return;

	game_style = BaseMenu.GetConfigStyle();

	if (game_style != None)
	{
		game_style.default.SwayScale						= sl_Sway.GetValue();
		game_style.default.RecoilScale					= sl_Recoil.GetValue();
		game_style.default.DamageScale					= fl_Damage.GetValue();
		game_style.default.VehicleDamageScale			= fl_VDamage.GetValue();
		game_style.default.bWeaponJumpOffsetting			= ch_WeaponJumpOffsetting.IsChecked();
		game_style.default.bLongWeaponOffsetting			= ch_LongWeaponOffsetting.IsChecked();
		game_style.default.bNoReloading					= ch_NoReloading.IsChecked();
		game_style.default.bNoRandomCamo					= ch_NoRandomCamo.IsChecked();
		game_style.default.MaxInventoryCapacity 			= int_MaxInventoryCapacity.GetValue();	
		game_style.static.StaticSaveConfig();
	}

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
         Hint="Scales the degree of sway of weapons."
         WinTop=0.10000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     sl_Sway=moSlider'sl_SwaySlider'

     Begin Object Class=moSlider Name=sl_RecoilSlider
         MaxValue=2.000000
         Caption="Recoil Scale"
         OnCreateComponent=sl_RecoilSlider.InternalOnCreateComponent
         Hint="Scales the recoil pattern of weapons."
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
         Caption="Weapon Jump Offsetting"
         OnCreateComponent=ch_SprintAimCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Causes weapons to offset when jumping or sprinting."
         WinTop=0.30000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_WeaponJumpOffsetting=moCheckBox'ch_SprintAimCheck'

     Begin Object Class=moCheckBox Name=ch_LongWeaponOffsettingCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Long Weapon Offsetting"
         OnCreateComponent=ch_LongWeaponOffsettingCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Causes weapons to offset when too close to a wall or other surface."
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
         Hint="Disables reloading."
         WinTop=0.40000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_NoReloading=moCheckBox'ch_NoReloadingCheck'
	
	 Begin Object Class=moCheckBox Name=ch_NoRandomCamoCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Disable Random Camos and Layouts"
         OnCreateComponent=ch_NoRandomCamoCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Generated guns will come with the basic variant."
         WinTop=0.45000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_NoRandomCamo=moCheckBox'ch_NoRandomCamoCheck'

	 	Begin Object Class=moNumericEdit Name=int_MaxWepsInt
         MinValue=0
         MaxValue=999
         ComponentJustification=TXTA_Left
         CaptionWidth=0.800000
         Caption="Player Inventory Capacity"
         OnCreateComponent=int_MaxWepsInt.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Sets the player's maximum inventory capacity. 0 is infinite."
         WinTop=0.500000
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
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_UseItemizer=moCheckBox'UseItemizerCheck'

     Begin Object Class=moEditBox Name=eb_ItemGroupEdit
         CaptionWidth=0.250000
         Caption="Itemizer Group"
         OnCreateComponent=eb_ItemGroupEdit.InternalOnCreateComponent
         Hint="The name of the Itemizer layout you want to use. Defaults to 'Ballistic'."
         WinTop=0.600000
         WinLeft=0.250000
         WinHeight=0.060000
     End Object
     eb_ItemGroup=moEditBox'eb_ItemGroupEdit'



}