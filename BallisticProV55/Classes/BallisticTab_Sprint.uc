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

var automated moCheckBox        cb_bUseSloth;				//Enable Sloth
var automated moFloatEdit       fe_StrafeScale;				//Strafe Scale
var automated moFloatEdit       fe_BackScale;				//Backwards Strafe Scale
var automated moFloatEdit       fe_GroundSpeedScale;		//Ground Speed Scale
var automated moFloatEdit       fe_AirSpeedScale;			//Air Speed Scale
var automated moFloatEdit       fe_AccelRateScale;			//Acceleration Scale

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

	cb_bUseSloth.Checked(class'BallisticProV55.Mut_Ballistic'.default.bUseSloth);
    fe_StrafeScale.SetValue(class'BallisticProV55.Mut_Ballistic'.default.StrafeScale);
    fe_BackScale.SetValue(class'BallisticProV55.Mut_Ballistic'.default.BackScale);
    fe_GroundSpeedScale.SetValue(class'BallisticProV55.Mut_Ballistic'.default.GroundSpeedScale);
    fe_AirSpeedScale.SetValue(class'BallisticProV55.Mut_Ballistic'.default.AirSpeedScale);
    fe_AccelRateScale.SetValue(class'BallisticProV55.Mut_Ballistic'.default.AccelRateScale);
    
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
	
	cb_bUseSloth.Checked(false);
    fe_StrafeScale.SetValue(0.700000);
    fe_BackScale.SetValue(0.600000);
    fe_GroundSpeedScale.SetValue(270.000000);
    fe_AirSpeedScale.SetValue(270.000000);
    fe_AccelRateScale.SetValue(256.000000);
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
	
	class'BallisticProV55.Mut_Ballistic'.default.bUseSloth = cb_bUseSloth.IsChecked();
    class'BallisticProV55.Mut_Ballistic'.default.StrafeScale = fe_StrafeScale.GetValue();
    class'BallisticProV55.Mut_Ballistic'.default.BackScale = fe_BackScale.GetValue();
    class'BallisticProV55.Mut_Ballistic'.default.GroundSpeedScale = fe_GroundSpeedScale.GetValue();
    class'BallisticProV55.Mut_Ballistic'.default.AirSpeedScale = fe_AirSpeedScale.GetValue();
    class'BallisticProV55.Mut_Ballistic'.default.AccelRateScale = fe_AccelRateScale.GetValue();

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
	 
	 Begin Object Class=moCheckBox Name=cb_bUseSlothC
         ComponentWidth=0.175000
         Caption="Enable Sloth:"
         OnCreateComponent=cb_bUseSlothC.InternalOnCreateComponent
         Hint="Enables Sloth."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     cb_bUseSloth=moCheckBox'BallisticProV55.BallisticTab_Sprint.cb_bUseSlothC'

     Begin Object Class=moFloatEdit Name=fe_StrafeScaleC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Strafe Ground Speed Scale:"
         OnCreateComponent=fe_StrafeScaleC.InternalOnCreateComponent
         Hint="The initial stamina."
         WinTop=0.500000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_StrafeScale=moFloatEdit'BallisticProV55.BallisticTab_Sprint.fe_StrafeScaleC'

     Begin Object Class=moFloatEdit Name=fe_BackScaleC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Backwards Ground Speed Scale:"
         OnCreateComponent=fe_BackScaleC.InternalOnCreateComponent
         Hint="The maximal stamina."
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_BackScale=moFloatEdit'BallisticProV55.BallisticTab_Sprint.fe_BackScaleC'

     Begin Object Class=moFloatEdit Name=fe_GroundSpeedScaleC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Ground Speed Scale:"
         OnCreateComponent=fe_GroundSpeedScaleC.InternalOnCreateComponent
         Hint="The stamina drain rate."
         WinTop=0.600000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_GroundSpeedScale=moFloatEdit'BallisticProV55.BallisticTab_Sprint.fe_GroundSpeedScaleC'

     Begin Object Class=moFloatEdit Name=fe_AirSpeedScaleC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Air Speed Scale:"
         OnCreateComponent=fe_AirSpeedScaleC.InternalOnCreateComponent
         Hint="The stamina charge rate."
         WinTop=0.650000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_AirSpeedScale=moFloatEdit'BallisticProV55.BallisticTab_Sprint.fe_AirSpeedScaleC'

     Begin Object Class=moFloatEdit Name=fe_AccelRateScaleC
         MinValue=0.000000
         MaxValue=999.000000
         ComponentWidth=0.175000
         Caption="Acceleration Rate:"
         OnCreateComponent=fe_AccelRateScaleC.InternalOnCreateComponent
         Hint="The speed factor during sprint."
         WinTop=0.700000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_AccelRateScale=moFloatEdit'BallisticProV55.BallisticTab_Sprint.fe_AccelRateScaleC'
}
