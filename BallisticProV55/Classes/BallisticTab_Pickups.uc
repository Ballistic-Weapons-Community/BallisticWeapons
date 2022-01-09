//=============================================================================
// CFTab_Packs.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class BallisticTab_Pickups extends UT2K4TabPanel;

var automated moCheckBox        chk_bRemoveAmmoPacks;
var automated moCheckBox        chk_bRemoveUDamage;
var automated moCheckBox        chk_bRemoveShieldPack;
var automated moCheckBox        chk_bRemoveSuperShieldPack;
var automated moCheckBox        chk_bRemoveBandages;
var automated moCheckBox        chk_bRemoveHealthPack;
var automated moCheckBox        chk_bRemoveSuperHealthPack;
var automated moCheckBox        chk_bRemoveAdrenaline;
var automated moCheckBox        chk_AlterantivePickups;
var BallisticConfigMenuPro		p_Anchor;
var bool                    	bInitialized;

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
    chk_bRemoveAmmoPacks.Checked(class'BallisticProV55.Mut_Pickups'.default.bRemoveAmmoPacks);
    chk_bRemoveUDamage.Checked(class'BallisticProV55.Mut_Pickups'.default.bRemoveUDamage);
    chk_bRemoveShieldPack.Checked(class'BallisticProV55.Mut_Pickups'.default.bRemoveShieldPack);
    chk_bRemoveSuperShieldPack.Checked(class'BallisticProV55.Mut_Pickups'.default.bRemoveSuperShieldPack);
    chk_bRemoveBandages.Checked(class'BallisticProV55.Mut_Pickups'.default.bRemoveBandages);
    chk_bRemoveHealthPack.Checked(class'BallisticProV55.Mut_Pickups'.default.bRemoveHealthPack);
    chk_bRemoveSuperHealthPack.Checked(class'BallisticProV55.Mut_Pickups'.default.bRemoveSuperHealthPack);
    chk_bRemoveAdrenaline.Checked(class'BallisticProV55.Mut_Pickups'.default.bRemoveAdrenaline);
    chk_AlterantivePickups.Checked(class'BallisticReplicationInfo'.default.bAlternativePickups);
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
    chk_AlterantivePickups.Checked(true);
}

function SaveSettings()
{
    if (!bInitialized)
        return;

    class'BallisticProV55.Mut_Pickups'.default.bRemoveAmmoPacks = chk_bRemoveAmmoPacks.IsChecked();
    class'BallisticProV55.Mut_Pickups'.default.bRemoveUDamage = chk_bRemoveUDamage.IsChecked();
    class'BallisticProV55.Mut_Pickups'.default.bRemoveShieldPack = chk_bRemoveShieldPack.IsChecked();
    class'BallisticProV55.Mut_Pickups'.default.bRemoveSuperShieldPack = chk_bRemoveSuperShieldPack.IsChecked();
    class'BallisticProV55.Mut_Pickups'.default.bRemoveBandages = chk_bRemoveBandages.IsChecked();
    class'BallisticProV55.Mut_Pickups'.default.bRemoveHealthPack = chk_bRemoveHealthPack.IsChecked();
    class'BallisticProV55.Mut_Pickups'.default.bRemoveSuperHealthPack = chk_bRemoveSuperHealthPack.IsChecked();
    class'BallisticProV55.Mut_Pickups'.default.bRemoveAdrenaline = chk_bRemoveAdrenaline.IsChecked();
    class'BallisticReplicationInfo'.default.bAlternativePickups = chk_AlterantivePickups.IsChecked();

    class'BallisticReplicationInfo'.static.StaticSaveConfig();
    class'BallisticProV55.Mut_Pickups'.static.StaticSaveConfig();
}

defaultproperties
{
     Begin Object Class=moCheckBox Name=chk_bRemoveAmmoPacksC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Remove ammo packs"
         OnCreateComponent=chk_bRemoveAmmoPacksC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all ammo packs from the game."
         WinTop=0.050000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveAmmoPacks=moCheckBox'BallisticProV55.BallisticTab_Pickups.chk_bRemoveAmmoPacksC'

     Begin Object Class=moCheckBox Name=chk_bRemoveUDamageC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Remove damage amplifiers"
         OnCreateComponent=chk_bRemoveUDamageC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all damage amplifiers from the game."
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveUDamage=moCheckBox'BallisticProV55.BallisticTab_Pickups.chk_bRemoveUDamageC'

     Begin Object Class=moCheckBox Name=bRemoveShieldPackC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Remove armors"
         OnCreateComponent=bRemoveShieldPackC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all armors from the game except super armor."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveShieldPack=moCheckBox'BallisticProV55.BallisticTab_Pickups.bRemoveShieldPackC'

     Begin Object Class=moCheckBox Name=bRemoveSuperShieldPackC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Remove super armors"
         OnCreateComponent=bRemoveSuperShieldPackC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all super armors from the game."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveSuperShieldPack=moCheckBox'BallisticProV55.BallisticTab_Pickups.bRemoveSuperShieldPackC'

     Begin Object Class=moCheckBox Name=chk_bRemoveBandagesC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Remove bandages"
         OnCreateComponent=chk_bRemoveBandagesC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all bandages from the game."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveBandages=moCheckBox'BallisticProV55.BallisticTab_Pickups.chk_bRemoveBandagesC'

     Begin Object Class=moCheckBox Name=chk_bRemoveHealthPackC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Remove health packs"
         OnCreateComponent=chk_bRemoveHealthPackC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all health packs from the game."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveHealthPack=moCheckBox'BallisticProV55.BallisticTab_Pickups.chk_bRemoveHealthPackC'

     Begin Object Class=moCheckBox Name=chk_bRemoveSuperHealthPackC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Remove super health packs"
         OnCreateComponent=chk_bRemoveSuperHealthPackC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all super health packs from the game."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveSuperHealthPack=moCheckBox'BallisticProV55.BallisticTab_Pickups.chk_bRemoveSuperHealthPackC'

     Begin Object Class=moCheckBox Name=chk_bRemoveAdrenalineC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Remove adrenaline"
         OnCreateComponent=chk_bRemoveAdrenalineC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Removes all adrenaline from the game."
         WinTop=0.400000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_bRemoveAdrenaline=moCheckBox'BallisticProV55.BallisticTab_Pickups.chk_bRemoveAdrenalineC'

     Begin Object Class=moCheckBox Name=chk_AlterantivePickupsC
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         Caption="Alternative Pickups"
         OnCreateComponent=chk_AlterantivePickupsC.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Press the use key to pickup weapons."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     chk_AlterantivePickups=moCheckBox'BallisticProV55.BallisticTab_Pickups.chk_AlterantivePickupsC'

}
