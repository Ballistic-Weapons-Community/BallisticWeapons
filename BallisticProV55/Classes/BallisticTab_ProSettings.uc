//=====================================
// Additional Rules tab.
//
// Contains additional game rules for BallisticPro.
//=====================================

class BallisticTab_ProSettings extends UT2K4TabPanel;

var automated moFloatEdit fl_WalkingPct, fl_CrouchingPct, fl_NadePct;
var automated moCheckbox ch_MineLights, ch_RunningAnims;
var automated moNumericEdit int_MaxInventoryCapacity;

var BallisticConfigMenuPro p_Anchor;
var bool bInitialised;

function InitComponent(GUIController myController, GUIComponent myOwner)
{
	Super.InitComponent(myController, myOwner);
	if(BallisticConfigMenuPro(Controller.ActivePage) != None)
	p_Anchor = BallisticConfigMenuPro(Controller.ActivePage);
}

function ShowPanel (bool bShow)
{
	super.ShowPanel(bShow);
	if(bInitialised)
	return;
	LoadSettings();
	bInitialised=True;
}

function LoadSettings()
{
	fl_WalkingPct.SetValue(class'BallisticReplicationInfo'.default.WalkingPercentage);
	fl_CrouchingPct.SetValue(class'BallisticReplicationInfo'.default.CrouchingPercentage);
	fl_NadePct.SetValue(class'Mut_BallisticSwap'.default.NadeReplacePercent);
	ch_MineLights.Checked(class'BallisticReplicationInfo'.default.bUniversalMineLights);
	ch_RunningAnims.Checked(class'BallisticReplicationInfo'.default.bUseRunningAnims);
	int_MaxInventoryCapacity.SetValue(class'BallisticWeapon'.default.MaxInventoryCapacity);
}

function SaveSettings()
{
	if(!bInitialised)
		return;
	class'BallisticReplicationInfo'.default.WalkingPercentage = fl_WalkingPct.GetValue();
	class'BallisticReplicationInfo'.default.CrouchingPercentage = fl_CrouchingPct.GetValue();
	class'BallisticReplicationInfo'.default.bUniversalMineLights = ch_MineLights.IsChecked();
	class'BallisticReplicationInfo'.default.bUseRunningAnims = ch_RunningAnims.IsChecked();
	class'Mut_BallisticSwap'.default.NadeReplacePercent = fl_NadePct.GetValue();
	class'BallisticWeapon'.default.MaxInventoryCapacity = int_MaxInventoryCapacity.GetValue();	
	class'BallisticReplicationInfo'.static.StaticSaveConfig();
	class'BallisticWeapon'.static.StaticSaveConfig();
	class'BallisticInstantFire'.static.StaticSaveConfig();
	class'BallisticProjectile'.static.StaticSaveConfig();
	class'Mut_BallisticSwap'.static.StaticSaveConfig();
}

function DefaultSettings()
{
	fl_WalkingPct.SetValue(0.75);
	fl_CrouchingPct.SetValue(0.4);
	ch_MineLights.Checked(True);
	ch_RunningAnims.Checked(True);
	fl_NadePct.SetValue(15);
	int_MaxInventoryCapacity.SetValue(0);	
}

defaultproperties
{
     Begin Object Class=moFloatEdit Name=fl_WalkingPctFloat
         MinValue=0.400000
         MaxValue=1.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.800000
         Caption="Aim Down Sight Move Speed %"
         OnCreateComponent=fl_WalkingPctFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales player movement speed when aiming weapons. 0.5 to 1.0 = 50% to 100% of run speed. This is also the walking speed"
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_WalkingPct=moFloatEdit'BallisticProV55.BallisticTab_ProSettings.fl_WalkingPctFloat'

     Begin Object Class=moFloatEdit Name=fl_CrouchingPctFloat
         MinValue=0.200000
         MaxValue=0.600000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.800000
         Caption="Crouch Move Speed %"
         OnCreateComponent=fl_CrouchingPctFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the crouch speed. 0.2 to 0.6 = 20% to 60% of run speed."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_CrouchingPct=moFloatEdit'BallisticProV55.BallisticTab_ProSettings.fl_CrouchingPctFloat'

     Begin Object Class=moCheckBox Name=ch_MineLightsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="BX5 Mines Lit For All"
         OnCreateComponent=ch_MineLightsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Toggles BX5 mine lights for all players."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_MineLights=moCheckBox'BallisticProV55.BallisticTab_ProSettings.ch_MineLightsCheck'

     Begin Object Class=moCheckBox Name=ch_RunningAnimsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Use Run Anims For ADS Movement"
         OnCreateComponent=ch_RunningAnimsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Sets player walk anims to run anims."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_RunningAnims=moCheckBox'BallisticProV55.BallisticTab_ProSettings.ch_RunningAnimsCheck'

     Begin Object Class=moFloatEdit Name=fl_NadePctFloat
         MinValue=1.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.800000
         Caption="Ammo to Grenades Swap Percentage"
         OnCreateComponent=fl_NadePctFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Percentage chance of replacing an ammo pickup with a grenade."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_NadePct=moFloatEdit'BallisticProV55.BallisticTab_ProSettings.fl_NadePctFloat'

     Begin Object Class=moNumericEdit Name=int_MaxWepsInt
         MinValue=0
         MaxValue=999
         ComponentJustification=TXTA_Left
         CaptionWidth=0.800000
         Caption="Player Inventory Capacity"
         OnCreateComponent=int_MaxWepsInt.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Sets the player's maximum inventory capacity. 0 is infinite."
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     int_MaxInventoryCapacity=moNumericEdit'BallisticProV55.BallisticTab_ProSettings.int_MaxWepsInt'
}
