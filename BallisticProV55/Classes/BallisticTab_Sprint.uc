//=============================================================================
// CFTab_Misc.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class BallisticTab_Sprint extends UT2k4TabPanel;

var automated moCheckBox        cb_bUseSprint;				//Enable Sprint
var automated moFloatEdit       fe_InitStamina;				//Initial Stamina
var automated moFloatEdit       fe_InitMaxStamina;			//Max Stamina
var automated moFloatEdit       fe_InitStaminaDrainRate;	//Stamina Drain Rate
var automated moFloatEdit       fe_InitStaminaChargeRate;	//Stamina Charge Rate
var automated moFloatEdit       fe_InitSpeedFactor;			//Speed During Sprint
var automated moFloatEdit       fe_JumpDrainFactor;			//Jump Drain Factor

var BallisticConfigMenuPro		p_Anchor;
var bool                    	bInitialized;

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
    cb_bUseSprint.Checked(class'BallisticProV55.Mut_Ballistic'.default.bUseSprint);
    fe_InitStamina.SetValue(class'BallisticProV55.Mut_Ballistic'.default.InitStamina);
    fe_InitMaxStamina.SetValue(class'BallisticProV55.Mut_Ballistic'.default.InitMaxStamina);
    fe_InitStaminaDrainRate.SetValue(class'BallisticProV55.Mut_Ballistic'.default.InitStaminaDrainRate);
    fe_InitStaminaChargeRate.SetValue(class'BallisticProV55.Mut_Ballistic'.default.InitStaminaChargeRate);
    fe_InitSpeedFactor.SetValue(class'BallisticProV55.Mut_Ballistic'.default.InitSpeedFactor);
    fe_JumpDrainFactor.SetValue(class'BallisticProV55.Mut_Ballistic'.default.JumpDrainFactor);
}

function DefaultSettings()
{
    cb_bUseSprint.Checked(true);
    fe_InitStamina.SetValue(100.000000);
    fe_InitMaxStamina.SetValue(100.000000);
    fe_InitStaminaDrainRate.SetValue(10.000000);
    fe_InitStaminaChargeRate.SetValue(7.000000);
    fe_InitSpeedFactor.SetValue(1.350000);
    fe_JumpDrainFactor.SetValue(2);
}

function SaveSettings()
{
    if (!bInitialized)
        return;

    class'BallisticProV55.Mut_Ballistic'.default.bUseSprint = cb_bUseSprint.IsChecked();
    class'BallisticProV55.Mut_Ballistic'.default.InitStamina = fe_InitStamina.GetValue();
    class'BallisticProV55.Mut_Ballistic'.default.InitMaxStamina = fe_InitMaxStamina.GetValue();
    class'BallisticProV55.Mut_Ballistic'.default.InitStaminaDrainRate = fe_InitStaminaDrainRate.GetValue();
    class'BallisticProV55.Mut_Ballistic'.default.InitStaminaChargeRate = fe_InitStaminaChargeRate.GetValue();
    class'BallisticProV55.Mut_Ballistic'.default.InitSpeedFactor = fe_InitSpeedFactor.GetValue();
    class'BallisticProV55.Mut_Ballistic'.default.JumpDrainFactor = fe_JumpDrainFactor.GetValue();

    class'BallisticProV55.Mut_Ballistic'.static.StaticSaveConfig();
}

defaultproperties
{
     Begin Object Class=moCheckBox Name=cb_bUseSprintC
         ComponentWidth=0.175000
         Caption="Enable sprint:"
         OnCreateComponent=cb_bUseSprintC.InternalOnCreateComponent
         Hint="Enables sprint."
         WinTop=0.050000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     cb_bUseSprint=moCheckBox'BallisticProV55.BallisticTab_Sprint.cb_bUseSprintC'

     Begin Object Class=moFloatEdit Name=fe_InitStaminaC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Initial Stamina:"
         OnCreateComponent=fe_InitStaminaC.InternalOnCreateComponent
         Hint="The initial stamina."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_InitStamina=moFloatEdit'BallisticProV55.BallisticTab_Sprint.fe_InitStaminaC'

     Begin Object Class=moFloatEdit Name=fe_InitMaxStaminaC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Max stamina:"
         OnCreateComponent=fe_InitMaxStaminaC.InternalOnCreateComponent
         Hint="The maximal stamina."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_InitMaxStamina=moFloatEdit'BallisticProV55.BallisticTab_Sprint.fe_InitMaxStaminaC'

     Begin Object Class=moFloatEdit Name=fe_InitStaminaDrainRateC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Stamina drain rate:"
         OnCreateComponent=fe_InitStaminaDrainRateC.InternalOnCreateComponent
         Hint="The stamina drain rate."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_InitStaminaDrainRate=moFloatEdit'BallisticProV55.BallisticTab_Sprint.fe_InitStaminaDrainRateC'

     Begin Object Class=moFloatEdit Name=fe_InitStaminaChargeRateC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Stamina charge rate:"
         OnCreateComponent=fe_InitStaminaChargeRateC.InternalOnCreateComponent
         Hint="The stamina charge rate."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_InitStaminaChargeRate=moFloatEdit'BallisticProV55.BallisticTab_Sprint.fe_InitStaminaChargeRateC'

     Begin Object Class=moFloatEdit Name=fe_InitSpeedFactorC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Speed factor:"
         OnCreateComponent=fe_InitSpeedFactorC.InternalOnCreateComponent
         Hint="The speed factor during sprint."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_InitSpeedFactor=moFloatEdit'BallisticProV55.BallisticTab_Sprint.fe_InitSpeedFactorC'

     Begin Object Class=moFloatEdit Name=fe_JumpDrainFactorC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Jump drain factor:"
         OnCreateComponent=fe_JumpDrainFactorC.InternalOnCreateComponent
         Hint="The jump drain factor during sprint."
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_JumpDrainFactor=moFloatEdit'BallisticProV55.BallisticTab_Sprint.fe_JumpDrainFactorC'

}
