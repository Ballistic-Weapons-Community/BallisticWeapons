//=============================================================================
// CFTab_Misc.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class BallisticTab_Sprint extends UT2k4TabPanel;

var automated moCheckBox        cb_bUseSprint;				// Enable Sprint
var automated moNumericEdit     ne_InitStaminaDrainRate;	// Stamina Drain Rate
var automated moNumericEdit     ne_InitStaminaChargeRate;	// Stamina Charge Rate
var automated moFloatEdit       fe_InitSpeedFactor;			// Speed During Sprint
var automated moFloatEdit       fe_JumpDrainFactor;			// Jump Drain Factor

var automated moCheckBox        cb_bUseSloth;				// Enable Sloth
var automated moNumericEdit     ne_PlayerGroundSpeed;		// Ground Speed Scale
var automated moNumericEdit     ne_PlayerAccelRate;			// Acceleration Scale
var automated moFloatEdit       fe_PlayerStrafeScale;		// Strafe Scale
var automated moFloatEdit       fe_PlayerBackpedalScale;	// Backwards Strafe Scale


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
    ne_InitStaminaDrainRate.SetValue(class'BallisticProV55.Mut_Ballistic'.default.InitStaminaDrainRate);
    ne_InitStaminaChargeRate.SetValue(class'BallisticProV55.Mut_Ballistic'.default.InitStaminaChargeRate);
    fe_InitSpeedFactor.SetValue(class'BallisticProV55.Mut_Ballistic'.default.InitSpeedFactor);
    fe_JumpDrainFactor.SetValue(class'BallisticProV55.Mut_Ballistic'.default.JumpDrainFactor);

	cb_bUseSloth.Checked(class'BallisticReplicationInfo'.default.bUseSloth);
    fe_PlayerStrafeScale.SetValue(class'BallisticReplicationInfo'.default.PlayerStrafeScale);
    fe_PlayerBackpedalScale.SetValue(class'BallisticReplicationInfo'.default.PlayerBackpedalScale);
    ne_PlayerGroundSpeed.SetValue(class'BallisticReplicationInfo'.default.PlayerGroundSpeed);
    ne_PlayerAccelRate.SetValue(class'BallisticReplicationInfo'.default.PlayerAccelRate);
}

function DefaultSettings()
{
    cb_bUseSprint.Checked(true);
    ne_InitStaminaDrainRate.SetValue(25);
    ne_InitStaminaChargeRate.SetValue(20);
    fe_InitSpeedFactor.SetValue(1.50000);
    fe_JumpDrainFactor.SetValue(2);
	
	cb_bUseSloth.Checked(false);
    fe_PlayerStrafeScale.SetValue(1);
    fe_PlayerBackpedalScale.SetValue(1);
    ne_PlayerGroundSpeed.SetValue(230);
    ne_PlayerAccelRate.SetValue(1536);
}

function SaveSettings()
{
    if (!bInitialized)
        return;

    class'BallisticProV55.Mut_Ballistic'.default.bUseSprint = cb_bUseSprint.IsChecked();
    class'BallisticProV55.Mut_Ballistic'.default.InitStaminaDrainRate = ne_InitStaminaDrainRate.GetValue();
    class'BallisticProV55.Mut_Ballistic'.default.InitStaminaChargeRate = ne_InitStaminaChargeRate.GetValue();
    class'BallisticProV55.Mut_Ballistic'.default.InitSpeedFactor = fe_InitSpeedFactor.GetValue();
    class'BallisticProV55.Mut_Ballistic'.default.JumpDrainFactor = fe_JumpDrainFactor.GetValue();
	
	class'BallisticReplicationInfo'.default.bUseSloth = cb_bUseSloth.IsChecked();
    class'BallisticReplicationInfo'.default.PlayerStrafeScale = fe_PlayerStrafeScale.GetValue();
    class'BallisticReplicationInfo'.default.PlayerBackpedalScale = fe_PlayerBackpedalScale.GetValue();
    class'BallisticReplicationInfo'.default.PlayerGroundSpeed = ne_PlayerGroundSpeed.GetValue();
    class'BallisticReplicationInfo'.default.PlayerAirSpeed = ne_PlayerGroundSpeed.GetValue(); // this is NOT an error. ground and air speed should be equivalent
    class'BallisticReplicationInfo'.default.PlayerAccelRate = ne_PlayerAccelRate.GetValue();

    class'BallisticProV55.Mut_Ballistic'.static.StaticSaveConfig();
    class'BallisticReplicationInfo'.static.StaticSaveConfig();
}

defaultproperties
{
     Begin Object Class=moCheckBox Name=cb_bUseSprintC
         ComponentWidth=0.175000
         Caption="Enable Sprint"
         OnCreateComponent=cb_bUseSprintC.InternalOnCreateComponent
         Hint="Enables sprint."
         WinTop=0.050000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     cb_bUseSprint=moCheckBox'BallisticProV55.BallisticTab_Sprint.cb_bUseSprintC'

     Begin Object Class=moNumericEdit Name=ne_InitStaminaDrainRateC
         MinValue=0
         MaxValue=35
         Step=5
         ComponentWidth=0.175000
         Caption="Stamina Drain % Per Second"
         OnCreateComponent=ne_InitStaminaDrainRateC.InternalOnCreateComponent
         Hint="Percentage of stamina to drain every second when sprinting."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_InitStaminaDrainRate=moNumericEdit'BallisticProV55.BallisticTab_Sprint.ne_InitStaminaDrainRateC'

     Begin Object Class=moNumericEdit Name=ne_InitStaminaChargeRateC
         MinValue=0
         MaxValue=35
         Step=5
         ComponentWidth=0.175000
         Caption="Stamina Regen % Per Second"
         OnCreateComponent=ne_InitStaminaChargeRateC.InternalOnCreateComponent
         Hint="Percentage of stamina to regenerate every second when not sprinting."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_InitStaminaChargeRate=moNumericEdit'BallisticProV55.BallisticTab_Sprint.ne_InitStaminaChargeRateC'

     Begin Object Class=moFloatEdit Name=fe_InitSpeedFactorC
         MinValue=1.250000
         MaxValue=1.500000
         Step=0.05
         ComponentWidth=0.175000
         Caption="Sprint Speed Multiplier"
         OnCreateComponent=fe_InitSpeedFactorC.InternalOnCreateComponent
         Hint="The speed factor during sprint."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_InitSpeedFactor=moFloatEdit'BallisticProV55.BallisticTab_Sprint.fe_InitSpeedFactorC'

     Begin Object Class=moFloatEdit Name=fe_JumpDrainFactorC
         MinValue=0.000000
         MaxValue=2.000000
         ComponentWidth=0.175000
         Caption="Jump Drain Factor"
         OnCreateComponent=fe_JumpDrainFactorC.InternalOnCreateComponent
         Hint="The jump drain factor during sprint."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_JumpDrainFactor=moFloatEdit'BallisticProV55.BallisticTab_Sprint.fe_JumpDrainFactorC'
	 
	 Begin Object Class=moCheckBox Name=cb_bUseSlothC
         ComponentWidth=0.175000
         Caption="Adjust Movement"
         OnCreateComponent=cb_bUseSlothC.InternalOnCreateComponent
         Hint="Overrides default movement with the settings below."
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     cb_bUseSloth=moCheckBox'BallisticProV55.BallisticTab_Sprint.cb_bUseSlothC'

     Begin Object Class=moNumericEdit Name=ne_PlayerGroundSpeedC
         MinValue=160
         MaxValue=440
         Step=20
         ComponentWidth=0.175000
         Caption="Movement Speed"
         OnCreateComponent=ne_PlayerGroundSpeedC.InternalOnCreateComponent
         Hint="Player ground and air speed. 160 - 440. 440 is UT2004 default."
         WinTop=0.400000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_PlayerGroundSpeed=moNumericEdit'BallisticProV55.BallisticTab_Sprint.ne_PlayerGroundSpeedC'

     Begin Object Class=moNumericEdit Name=ne_PlayerAccelRateC
         MinValue=1024
         MaxValue=2048
        Step=256
         ComponentWidth=0.175000
         Caption="Acceleration Rate"
         OnCreateComponent=ne_PlayerAccelRateC.InternalOnCreateComponent
         Hint="Scales player acceleration. 1024 - 2048. UT2004 is 2048."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_PlayerAccelRate=moNumericEdit'BallisticProV55.BallisticTab_Sprint.ne_PlayerAccelRateC'

     Begin Object Class=moFloatEdit Name=fe_PlayerStrafeScaleC
         MinValue=0.80000
         MaxValue=1.000000
         Step=0.1
         ComponentWidth=0.175000
         Caption="Strafe Speed Multiplier"
         OnCreateComponent=fe_PlayerStrafeScaleC.InternalOnCreateComponent
         Hint="Scale for strafe speed. 0.7 - 1."
         WinTop=0.500000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_PlayerStrafeScale=moFloatEdit'BallisticProV55.BallisticTab_Sprint.fe_PlayerStrafeScaleC'

     Begin Object Class=moFloatEdit Name=fe_PlayerBackpedalScaleC
         MinValue=0.500000
         MaxValue=1.000000
         Step=0.1
         ComponentWidth=0.175000
         Caption="Backpedal Speed Multiplier"
         OnCreateComponent=fe_PlayerBackpedalScaleC.InternalOnCreateComponent
         Hint="Scale for backpedal speed. 0.5 - 1."
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_PlayerBackpedalScale=moFloatEdit'BallisticProV55.BallisticTab_Sprint.fe_PlayerBackpedalScaleC'

}
