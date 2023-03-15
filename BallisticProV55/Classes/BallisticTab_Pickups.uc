//=============================================================================
// CFTab_Packs.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class BallisticTab_Pickups extends UT2K4TabPanel;

var automated moFloatEdit	fl_NadePct;					//Swap Ammo For Grenade Percentage
var automated moCheckbox	ch_BrightPickups;			//Bright Pickups Toggle
var automated moCheckbox	ch_PickupsChange;			//Toggle Pickups Change After Obtained
var automated moCheckbox	ch_SpawnUnique;				//Sawn Least Common Weapon Toggle
var automated moCheckbox	ch_LeaveSuper;				//Leave Non-BW Superweapons in Rotation
var automated moCheckbox	ch_KillRogueWPs;			//Kill All Non-BW Weapons that are forced into the map

var automated moCheckBox    chk_bRemoveAmmoPacks;		//Toggle Ammo Packs
var automated moCheckBox    chk_bRemoveUDamage;			//Toggle UDamage
var automated moCheckBox    chk_bRemoveShieldPack;		//Toggle Shield Pack
var automated moCheckBox    chk_bRemoveSuperShieldPack;	//Toggle Super Shield Pack
var automated moCheckBox    chk_bRemoveBandages;		//Toggle Bandages
var automated moCheckBox    chk_bRemoveHealthPack;		//Toggle Health Pack
var automated moCheckBox    chk_bRemoveSuperHealthPack;	//Toggle Super Health Pack
var automated moCheckBox    chk_bRemoveAdrenaline;		//Toggle Adrenaline
var automated moCheckBox    chk_AlternativePickups;		//Press USE to Pickup Weapons

var BallisticConfigMenuPro	p_Anchor;
var bool                    bInitialized;

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

    fl_NadePct.SetValue(class'Mut_BallisticSwap'.default.NadeReplacePercent);
	ch_BrightPickups.Checked(class'Mut_Ballistic'.default.bBrightPickups);
	ch_PickupsChange.Checked(class'Mut_Ballistic'.default.bPickupsChange);
	ch_SpawnUnique.Checked(class'Mut_Ballistic'.default.bSpawnUniqueItems);
	ch_KillRogueWPs.Checked(class'Mut_Ballistic'.default.bKillRogueWeaponPickups);
	ch_LeaveSuper.Checked(class'Mut_Ballistic'.default.bLeaveSuper);
	
	chk_bRemoveAmmoPacks.Checked(class'BallisticProV55.Mut_Pickups'.default.bRemoveAmmoPacks);
    chk_bRemoveUDamage.Checked(class'BallisticProV55.Mut_Pickups'.default.bRemoveUDamage);
    chk_bRemoveShieldPack.Checked(class'BallisticProV55.Mut_Pickups'.default.bRemoveShieldPack);
    chk_bRemoveSuperShieldPack.Checked(class'BallisticProV55.Mut_Pickups'.default.bRemoveSuperShieldPack);
    chk_bRemoveBandages.Checked(class'BallisticProV55.Mut_Pickups'.default.bRemoveBandages);
    chk_bRemoveHealthPack.Checked(class'BallisticProV55.Mut_Pickups'.default.bRemoveHealthPack);
    chk_bRemoveSuperHealthPack.Checked(class'BallisticProV55.Mut_Pickups'.default.bRemoveSuperHealthPack);
    chk_bRemoveAdrenaline.Checked(class'BallisticProV55.Mut_Pickups'.default.bRemoveAdrenaline);

	style = class'BallisticGameStyles'.static.GetClientLocalConfigStyle();

	if (style != None)
	{
    	chk_AlternativePickups.Checked(style.default.bAlternativePickups);
	}
}

function DefaultSettings()
{
    chk_bRemoveAmmoPacks.Checked(true);
    chk_bRemoveUDamage.Checked(true);
    chk_bRemoveShieldPack.Checked(true);
    chk_bRemoveSuperShieldPack.Checked(true);
    chk_bRemoveBandages.Checked(true);
    chk_bRemoveHealthPack.Checked(true);
    chk_bRemoveSuperHealthPack.Checked(true);
    chk_bRemoveAdrenaline.Checked(true);

    chk_AlternativePickups.Checked(true);
	
	fl_NadePct.SetValue(15);
	ch_BrightPickups.Checked(false);
	ch_PickupsChange.Checked(true);
	ch_SpawnUnique.Checked(true);
	ch_KillRogueWPs.Checked(false);
	ch_LeaveSuper.Checked(false);
}

function SaveSettings()
{
	local class<BC_GameStyle_Config> style;

    if (!bInitialized)
        return;

    class'Mut_BallisticSwap'.default.NadeReplacePercent 	= fl_NadePct.GetValue();
	class'Mut_Ballistic'.default.bBrightPickups		 		= ch_BrightPickups.IsChecked();
	class'Mut_Ballistic'.default.bPickupsChange 			= ch_PickupsChange.IsChecked();
	class'Mut_Ballistic'.default.bSpawnUniqueItems 			= ch_SpawnUnique.IsChecked();
	class'Mut_Ballistic'.default.bKillRogueWeaponPickups	= ch_KillRogueWPs.IsChecked();
	class'Mut_Ballistic'.default.bLeaveSuper 				= ch_LeaveSuper.IsChecked();
	class'Mut_BallisticSwap'.static.StaticSaveConfig();
	class'Mut_Ballistic'.static.StaticSaveConfig();

	class'BallisticProV55.Mut_Pickups'.default.bRemoveAmmoPacks = chk_bRemoveAmmoPacks.IsChecked();
    class'BallisticProV55.Mut_Pickups'.default.bRemoveUDamage = chk_bRemoveUDamage.IsChecked();
    class'BallisticProV55.Mut_Pickups'.default.bRemoveShieldPack = chk_bRemoveShieldPack.IsChecked();
    class'BallisticProV55.Mut_Pickups'.default.bRemoveSuperShieldPack = chk_bRemoveSuperShieldPack.IsChecked();
    class'BallisticProV55.Mut_Pickups'.default.bRemoveBandages = chk_bRemoveBandages.IsChecked();
    class'BallisticProV55.Mut_Pickups'.default.bRemoveHealthPack = chk_bRemoveHealthPack.IsChecked();
    class'BallisticProV55.Mut_Pickups'.default.bRemoveSuperHealthPack = chk_bRemoveSuperHealthPack.IsChecked();
    class'BallisticProV55.Mut_Pickups'.default.bRemoveAdrenaline = chk_bRemoveAdrenaline.IsChecked();
    class'BallisticProV55.Mut_Pickups'.static.StaticSaveConfig();

	style = class'BallisticGameStyles'.static.GetClientLocalConfigStyle();

	if (style != None)
	{    
		style.default.bAlternativePickups = chk_AlternativePickups.IsChecked();
    	style.static.StaticSaveConfig();
	}
}

defaultproperties
{
     Begin Object Class=moFloatEdit Name=fl_NadePctFloat
         MinValue=1.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.800000
         Caption="Ammo to Grenades Swap %"
         OnCreateComponent=fl_NadePctFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Percentage chance of replacing an ammo pickup with a grenade."
         WinTop=0.050000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_NadePct=moFloatEdit'BallisticProV55.BallisticTab_Pickups.fl_NadePctFloat'
	 
	 Begin Object Class=moCheckBox Name=ch_BrightPickupsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Bright Pickups"
         OnCreateComponent=ch_BrightPickupsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable to make pickups bright and easier to see. Does not affect multiplayer."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_BrightPickups=moCheckBox'BallisticProV55.BallisticTab_Pickups.ch_BrightPickupsCheck'

	 Begin Object Class=moCheckBox Name=ch_PickupsChangeCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Pickups Change"
         OnCreateComponent=ch_PickupsChangeCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Pickups randomly change after they have been picked up."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_PickupsChange=moCheckBox'BallisticProV55.BallisticTab_Pickups.ch_PickupsChangeCheck'
	 
	 Begin Object Class=moCheckBox Name=ch_SpawnUniqueCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Prefer Unique Pickups"
         OnCreateComponent=ch_SpawnUniqueCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Game will prefer to spawn pickups that are the least common at the time."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_SpawnUnique=moCheckBox'BallisticProV55.BallisticTab_Pickups.ch_SpawnUniqueCheck'
	 
	 Begin Object Class=moCheckBox Name=ch_KillRogueWPsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="No Rogue Weapon Pickups"
         OnCreateComponent=ch_KillRogueWPsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="BW mutators will remove/replace unlisted weapon pickups. (e.g. In-map Instagib rifles)"
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_KillRogueWPs=moCheckBox'BallisticProV55.BallisticTab_Pickups.ch_KillRogueWPsCheck'

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
     ch_LeaveSuper=moCheckBox'BallisticProV55.BallisticTab_Pickups.ch_LeaveSuperCheck'
	 
	 Begin Object Class=moCheckBox Name=chk_bRemoveAmmoPacksC
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Remove ammo packs"
         OnCreateComponent=chk_bRemoveAmmoPacksC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all ammo packs from the game."
         WinTop=0.40000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveAmmoPacks=moCheckBox'BallisticProV55.BallisticTab_Pickups.chk_bRemoveAmmoPacksC'

     Begin Object Class=moCheckBox Name=chk_bRemoveUDamageC
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Remove damage amplifiers"
         OnCreateComponent=chk_bRemoveUDamageC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all damage amplifiers from the game."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveUDamage=moCheckBox'BallisticProV55.BallisticTab_Pickups.chk_bRemoveUDamageC'

     Begin Object Class=moCheckBox Name=bRemoveShieldPackC
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Remove armors"
         OnCreateComponent=bRemoveShieldPackC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all armors from the game except super armor."
         WinTop=0.500000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveShieldPack=moCheckBox'BallisticProV55.BallisticTab_Pickups.bRemoveShieldPackC'

     Begin Object Class=moCheckBox Name=bRemoveSuperShieldPackC
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Remove super armors"
         OnCreateComponent=bRemoveSuperShieldPackC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all super armors from the game."
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveSuperShieldPack=moCheckBox'BallisticProV55.BallisticTab_Pickups.bRemoveSuperShieldPackC'

     Begin Object Class=moCheckBox Name=chk_bRemoveBandagesC
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Remove bandages"
         OnCreateComponent=chk_bRemoveBandagesC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all bandages from the game."
         WinTop=0.600000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveBandages=moCheckBox'BallisticProV55.BallisticTab_Pickups.chk_bRemoveBandagesC'

     Begin Object Class=moCheckBox Name=chk_bRemoveHealthPackC
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Remove health packs"
         OnCreateComponent=chk_bRemoveHealthPackC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all health packs from the game."
         WinTop=0.650000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveHealthPack=moCheckBox'BallisticProV55.BallisticTab_Pickups.chk_bRemoveHealthPackC'

     Begin Object Class=moCheckBox Name=chk_bRemoveSuperHealthPackC
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Remove super health packs"
         OnCreateComponent=chk_bRemoveSuperHealthPackC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all super health packs from the game."
         WinTop=0.700000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveSuperHealthPack=moCheckBox'BallisticProV55.BallisticTab_Pickups.chk_bRemoveSuperHealthPackC'

     Begin Object Class=moCheckBox Name=chk_bRemoveAdrenalineC
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Remove adrenaline"
         OnCreateComponent=chk_bRemoveAdrenalineC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all adrenaline from the game."
         WinTop=0.750000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveAdrenaline=moCheckBox'BallisticProV55.BallisticTab_Pickups.chk_bRemoveAdrenalineC'

     Begin Object Class=moCheckBox Name=chk_AlternativePickupsC
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Manual Pickups"
         OnCreateComponent=chk_AlternativePickupsC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Press the use key to pickup weapons."
         WinTop=0.800000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_AlternativePickups=moCheckBox'BallisticProV55.BallisticTab_Pickups.chk_AlternativePickupsC'

}
