//=============================================================================
// ConfigTab_MovementRules
//=============================================================================
class ConfigTab_MovementRules extends ConfigTabBase;

var automated moNumericEdit     ne_PlayerGroundSpeed;		// Ground Speed Scale
var automated moNumericEdit     ne_PlayerAccelRate;			// Acceleration Scale
var automated moCheckBox        cb_bPlayerDeceleration;		// Deceleration mechanics
var automated moFloatEdit       fe_PlayerStrafeScale;		// Strafe Scale
var automated moFloatEdit       fe_PlayerBackpedalScale;	// Backwards Strafe Scale
var automated moCheckbox		ch_AllowDodging;			// Enables Dodging
var automated moCheckbox		ch_AllowDoubleJump;			// Enables Double Jump

var automated moCheckBox        cb_bUseSprint;				// Enable Sprint
var automated moNumericEdit     ne_StaminaDrainRate;		// Stamina Drain Rate
var automated moNumericEdit     ne_StaminaChargeRate;		// Stamina Charge Rate
var automated moFloatEdit       fe_InitSpeedFactor;			// Speed During Sprint
var automated moFloatEdit       fe_JumpDrain;			// Jump Drain Factor

//==================================================================
// Settings & Defaults
//==================================================================

function LoadSettings()
{
	local class<BC_GameStyle_Config> game_style;

	game_style = BaseMenu.GetConfigStyle();

	if (game_style != None)
	{    	
		ne_PlayerGroundSpeed.SetValue(game_style.default.PlayerGroundSpeed);
		ne_PlayerAccelRate.SetValue(game_style.default.PlayerAccelRate);
		cb_bPlayerDeceleration.Checked(game_style.default.bPlayerDeceleration);
    	fe_PlayerStrafeScale.SetValue(game_style.default.PlayerStrafeScale);
    	fe_PlayerBackpedalScale.SetValue(game_style.default.PlayerBackpedalScale);
		ch_AllowDodging.Checked(game_style.default.bAllowDodging);
		ch_AllowDoubleJump.Checked(game_style.default.bAllowDoubleJump);

		cb_bUseSprint.Checked(game_style.default.bEnableSprint);
    	ne_StaminaDrainRate.SetValue(game_style.default.StaminaDrainRate);
    	ne_StaminaChargeRate.SetValue(game_style.default.StaminaChargeRate);
    	fe_InitSpeedFactor.SetValue(game_style.default.SprintSpeedFactor);
    	fe_JumpDrain.SetValue(game_style.default.JumpDrain);
	}
}

function DefaultSettings()
{
	// settings are for classic
	ne_PlayerGroundSpeed.SetValue(360);
    ne_PlayerAccelRate.SetValue(2048);
	cb_bPlayerDeceleration.Checked(false);
    fe_PlayerStrafeScale.SetValue(1);
    fe_PlayerBackpedalScale.SetValue(1);
	ch_AllowDodging.Checked(true);
	ch_AllowDoubleJump.Checked(true);

	cb_bUseSprint.Checked(true);
    ne_StaminaDrainRate.SetValue(25);
    ne_StaminaChargeRate.SetValue(25);
    fe_InitSpeedFactor.SetValue(1.35);
    fe_JumpDrain.SetValue(2);
}

function SaveSettings()
{
	local class<BC_GameStyle_Config> game_style;

    if (!bInitialized)
        return;

	game_style = BaseMenu.GetConfigStyle();

	if (game_style != None)
	{
		game_style.default.PlayerGroundSpeed 	= ne_PlayerGroundSpeed.GetValue();
    	game_style.default.PlayerAirSpeed 		= ne_PlayerGroundSpeed.GetValue(); // this is NOT an error. ground and air speed should be equivalent
    	game_style.default.PlayerAccelRate 		= ne_PlayerAccelRate.GetValue();
		game_style.default.bPlayerDeceleration 	= cb_bPlayerDeceleration.IsChecked();
    	game_style.default.PlayerStrafeScale 	= fe_PlayerStrafeScale.GetValue();
    	game_style.default.PlayerBackpedalScale 	= fe_PlayerBackpedalScale.GetValue();
		game_style.default.bAllowDodging			= ch_AllowDodging.IsChecked();
		game_style.default.bAllowDoubleJump 		= ch_AllowDoubleJump.IsChecked();

		game_style.default.bEnableSprint 		= cb_bUseSprint.IsChecked();
    	game_style.default.StaminaDrainRate 		= ne_StaminaDrainRate.GetValue();
    	game_style.default.StaminaChargeRate 	= ne_StaminaChargeRate.GetValue();
    	game_style.default.SprintSpeedFactor 	= fe_InitSpeedFactor.GetValue();
    	game_style.default.JumpDrain 		= fe_JumpDrain.GetValue();

    	game_style.static.StaticSaveConfig();
	}
}

defaultproperties
{	 
     Begin Object Class=moNumericEdit Name=ne_PlayerGroundSpeedC
         MinValue=160
         MaxValue=440
         Step=20
         ComponentWidth=0.175000
         Caption="Movement Speed"
         OnCreateComponent=ne_PlayerGroundSpeedC.InternalOnCreateComponent
         Hint="Player ground and air speed. 160 - 440. 440 is UT2004 default."
         WinTop=0.10000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_PlayerGroundSpeed=moNumericEdit'ne_PlayerGroundSpeedC'

     Begin Object Class=moNumericEdit Name=ne_PlayerAccelRateC
         MinValue=1024
         MaxValue=2048
        Step=256
         ComponentWidth=0.175000
         Caption="Acceleration Rate"
         OnCreateComponent=ne_PlayerAccelRateC.InternalOnCreateComponent
         Hint="Scales player acceleration. 1024 - 2048. UT2004 is 2048."
         WinTop=0.15000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_PlayerAccelRate=moNumericEdit'ne_PlayerAccelRateC'

	Begin Object Class=moCheckBox Name=cb_bPlayerDecelerationC
         ComponentWidth=0.175000
         Caption="Player Deceleration"
         OnCreateComponent=cb_bPlayerDecelerationC.InternalOnCreateComponent
         Hint="Players will decelerate gradually when movement stops."
         WinTop=0.2000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     cb_bPlayerDeceleration=moCheckBox'cb_bPlayerDecelerationC'

     Begin Object Class=moFloatEdit Name=fe_PlayerStrafeScaleC
         MinValue=0.80000
         MaxValue=1.000000
         Step=0.1
         ComponentWidth=0.175000
         Caption="Strafe Speed Multiplier"
         OnCreateComponent=fe_PlayerStrafeScaleC.InternalOnCreateComponent
         Hint="Scale for strafe speed. 0.7 - 1."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_PlayerStrafeScale=moFloatEdit'fe_PlayerStrafeScaleC'

     Begin Object Class=moFloatEdit Name=fe_PlayerBackpedalScaleC
         MinValue=0.500000
         MaxValue=1.000000
         Step=0.1
         ComponentWidth=0.175000
         Caption="Backpedal Speed Multiplier"
         OnCreateComponent=fe_PlayerBackpedalScaleC.InternalOnCreateComponent
         Hint="Scale for backpedal speed. 0.5 - 1."
         WinTop=0.30000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_PlayerBackpedalScale=moFloatEdit'fe_PlayerBackpedalScaleC'

	 	 Begin Object Class=moCheckBox Name=ch_AllowDodgingCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Dodging"
         OnCreateComponent=ch_AllowDodgingCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enables dodging for all players."
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_AllowDodging=moCheckBox'ch_AllowDodgingCheck'

    Begin Object Class=moCheckBox Name=ch_AllowDoubleJumpCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Double Jump"
         OnCreateComponent=ch_AllowDoubleJumpCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enables double jump."
         WinTop=0.40000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_AllowDoubleJump=moCheckBox'ch_AllowDoubleJumpCheck'

	 Begin Object Class=moCheckBox Name=cb_bUseSprintC
         ComponentWidth=0.175000
         Caption="Enable Sprint"
         OnCreateComponent=cb_bUseSprintC.InternalOnCreateComponent
         Hint="Enables sprint."
         WinTop=0.50000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     cb_bUseSprint=moCheckBox'cb_bUseSprintC'

     Begin Object Class=moNumericEdit Name=ne_StaminaDrainRateC
         MinValue=0
         MaxValue=35
         Step=5
         ComponentWidth=0.175000
         Caption="Stamina Drain % Per Second"
         OnCreateComponent=ne_StaminaDrainRateC.InternalOnCreateComponent
         Hint="Percentage of stamina to drain every second when sprinting."
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_StaminaDrainRate=moNumericEdit'ne_StaminaDrainRateC'

     Begin Object Class=moNumericEdit Name=ne_StaminaChargeRateC
         MinValue=0
         MaxValue=35
         Step=5
         ComponentWidth=0.175000
         Caption="Stamina Regen % Per Second"
         OnCreateComponent=ne_StaminaChargeRateC.InternalOnCreateComponent
         Hint="Percentage of stamina to regenerate every second when not sprinting."
         WinTop=0.60000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ne_StaminaChargeRate=moNumericEdit'ne_StaminaChargeRateC'

     Begin Object Class=moFloatEdit Name=fe_InitSpeedFactorC
         MinValue=1.250000
         MaxValue=1.500000
         Step=0.05
         ComponentWidth=0.175000
         Caption="Sprint Speed Multiplier"
         OnCreateComponent=fe_InitSpeedFactorC.InternalOnCreateComponent
         Hint="The speed multiplier during sprint."
         WinTop=0.650000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_InitSpeedFactor=moFloatEdit'fe_InitSpeedFactorC'

     Begin Object Class=moFloatEdit Name=fe_JumpDrainC
         MinValue=0.000000
         MaxValue=2.000000
         ComponentWidth=0.175000
         Caption="Jump Drain Factor"
         OnCreateComponent=fe_JumpDrainC.InternalOnCreateComponent
         Hint="The jump drain factor during sprint."
         WinTop=0.70000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fe_JumpDrain=moFloatEdit'fe_JumpDrainC'

}
