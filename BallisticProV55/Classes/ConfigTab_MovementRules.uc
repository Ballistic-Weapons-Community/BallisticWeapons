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
var automated moCheckBox        cb_AllowCrouchSliding;				// Enable Sprint
var automated moCheckBox        cb_bUseSprint;				// Enable Sprint
var automated moCheckBox        cb_FireEndsSprint;			// Fire pressed in a sprint ends it
var automated moCheckBox        cb_SightsEndSprint;			// The sight key ends a sprint
var automated moNumericEdit     ne_StaminaDrainRate;		// Stamina Drain Rate
var automated moNumericEdit     ne_StaminaChargeRate;		// Stamina Charge Rate
var automated moFloatEdit       fe_InitSpeedFactor;			// Speed During Sprint
var automated moFloatEdit       fe_JumpDrain;			    // Jump Drain Factor
var automated moFloatEdit       fe_StaminaRechargeDelay;	// Stamina Recharge Delay
var automated moCheckBox        cb_WallRun;					// Wall Running
var automated moCheckBox        cb_SlideJump;				// Slide Jumps
var automated moCheckBox        cb_LandIntoSlide;			// Land Into Slides
var automated moCheckBox        cb_SlideSteering;			// Slide Steering
var automated moCheckBox        cb_SlideToSprint;			// Sprint Out Of Slides
var automated GUILabel          l_Movement;
var automated GUILabel          l_SprintSlide;

//==================================================================
// Settings & Defaults
//==================================================================

function LoadSettings()
{
	local class<BC_GameStyle_Config> game_style;
	local class<BC_GameStyle_Fixed> fixed_style;

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
        cb_AllowCrouchSliding.Checked(game_style.default.bAllowCrouchSliding);
		cb_bUseSprint.Checked(game_style.default.bEnableSprint);
    	ne_StaminaDrainRate.SetValue(game_style.default.StaminaDrainRate);
    	ne_StaminaChargeRate.SetValue(game_style.default.StaminaChargeRate);
    	fe_InitSpeedFactor.SetValue(game_style.default.SprintSpeedFactor);
    	fe_JumpDrain.SetValue(game_style.default.JumpDrain);
    	fe_StaminaRechargeDelay.SetValue(game_style.default.StaminaRechargeDelay);
		cb_FireEndsSprint.Checked(game_style.default.bFireEndsSprint);
		cb_SightsEndSprint.Checked(game_style.default.bSightsEndSprint);
		cb_WallRun.Checked(game_style.default.bWallRun);
		cb_SlideJump.Checked(game_style.default.bSlideJump);
		cb_LandIntoSlide.Checked(game_style.default.bLandIntoSlide);
		cb_SlideSteering.Checked(game_style.default.bSlideSteering);
		cb_SlideToSprint.Checked(game_style.default.bSlideToSprint);
		UpdateRows();
	}
	else
	{
		fixed_style = class<BC_GameStyle_Fixed>(BaseMenu.GetGameStyle());

		ne_PlayerGroundSpeed.SetValue(fixed_style.default.PlayerGroundSpeed);
		ne_PlayerAccelRate.SetValue(fixed_style.default.PlayerAccelRate);
		cb_bPlayerDeceleration.Checked(fixed_style.default.bPlayerDeceleration);
		fe_PlayerStrafeScale.SetValue(fixed_style.default.PlayerStrafeScale);
		fe_PlayerBackpedalScale.SetValue(fixed_style.default.PlayerBackpedalScale);
		ch_AllowDodging.Checked(fixed_style.default.bAllowDodging);
		ch_AllowDoubleJump.Checked(fixed_style.default.bAllowDoubleJump);
		cb_AllowCrouchSliding.Checked(fixed_style.default.bAllowCrouchSliding);
		cb_bUseSprint.Checked(fixed_style.default.bEnableSprint);
		ne_StaminaDrainRate.SetValue(fixed_style.default.StaminaDrainRate);
		ne_StaminaChargeRate.SetValue(fixed_style.default.StaminaChargeRate);
		fe_InitSpeedFactor.SetValue(fixed_style.default.SprintSpeedFactor);
		fe_JumpDrain.SetValue(fixed_style.default.JumpDrain);
		fe_StaminaRechargeDelay.SetValue(fixed_style.default.StaminaRechargeDelay);
		cb_FireEndsSprint.Checked(fixed_style.default.bFireEndsSprint);
		cb_SightsEndSprint.Checked(fixed_style.default.bSightsEndSprint);
		cb_WallRun.Checked(fixed_style.default.bWallRun);
		cb_SlideJump.Checked(fixed_style.default.bSlideJump);
		cb_LandIntoSlide.Checked(fixed_style.default.bLandIntoSlide);
		cb_SlideSteering.Checked(fixed_style.default.bSlideSteering);
		cb_SlideToSprint.Checked(fixed_style.default.bSlideToSprint);
		DisableStyleRows();
	}
}

// Jumps and slides use stamina too, so only what a sprint alone uses goes with it. The slide rules go with sliding
function UpdateRows()
{
	local bool bSprint, bSlide;

	if (bRowsFixed)
		return;

	bSprint = cb_bUseSprint.IsChecked();
	bSlide = cb_AllowCrouchSliding.IsChecked();
	SetRowEnabled(cb_FireEndsSprint, bSprint);
	SetRowEnabled(cb_SightsEndSprint, bSprint);
	SetRowEnabled(ne_StaminaDrainRate, bSprint);
	SetRowEnabled(fe_InitSpeedFactor, bSprint);
	// a wall run starts from a sprint
	SetRowEnabled(cb_WallRun, bSprint);
	SetRowEnabled(cb_SlideJump, bSlide);
	SetRowEnabled(cb_LandIntoSlide, bSlide);
	SetRowEnabled(cb_SlideSteering, bSlide);
	SetRowEnabled(cb_SlideToSprint, bSlide && bSprint);
}

function DefaultSettings()
{
	if (bRowsFixed)
		return;

	if (BaseMenu.GetGameStyle() == class'GameStyle_Realism')
	{
		ne_PlayerGroundSpeed.SetValue(200);
		ne_PlayerAccelRate.SetValue(1536);
		cb_bPlayerDeceleration.Checked(true);
		ch_AllowDoubleJump.Checked(false);
		ne_StaminaDrainRate.SetValue(10);
		ne_StaminaChargeRate.SetValue(10);
		fe_InitSpeedFactor.SetValue(1.4);
	}
	else
	{
		// Classic
		ne_PlayerGroundSpeed.SetValue(360);
		ne_PlayerAccelRate.SetValue(2048);
		cb_bPlayerDeceleration.Checked(false);
		ch_AllowDoubleJump.Checked(true);
		ne_StaminaDrainRate.SetValue(20);
		ne_StaminaChargeRate.SetValue(20);
		fe_InitSpeedFactor.SetValue(1.35);
	}
    fe_PlayerStrafeScale.SetValue(1);
    fe_PlayerBackpedalScale.SetValue(1);
	ch_AllowDodging.Checked(true);
    cb_AllowCrouchSliding.Checked(true);
	cb_bUseSprint.Checked(true);
    fe_JumpDrain.SetValue(2);
    fe_StaminaRechargeDelay.SetValue(1.5);
	cb_FireEndsSprint.Checked(false);
	cb_SightsEndSprint.Checked(false);
	cb_WallRun.Checked(false);
	cb_SlideJump.Checked(false);
	cb_LandIntoSlide.Checked(false);
	cb_SlideSteering.Checked(false);
	cb_SlideToSprint.Checked(false);
	UpdateRows();
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
        game_style.default.bAllowCrouchSliding 	= cb_AllowCrouchSliding.IsChecked();
		game_style.default.bEnableSprint 		= cb_bUseSprint.IsChecked();
    	game_style.default.StaminaDrainRate 		= ne_StaminaDrainRate.GetValue();
    	game_style.default.StaminaChargeRate 	= ne_StaminaChargeRate.GetValue();
        game_style.default.StaminaRechargeDelay 	= fe_StaminaRechargeDelay.GetValue();
    	game_style.default.SprintSpeedFactor 	= fe_InitSpeedFactor.GetValue();
    	game_style.default.JumpDrain 		= fe_JumpDrain.GetValue();
		game_style.default.bFireEndsSprint 		= cb_FireEndsSprint.IsChecked();
		game_style.default.bSightsEndSprint 	= cb_SightsEndSprint.IsChecked();
		game_style.default.bWallRun = cb_WallRun.IsChecked();
		game_style.default.bSlideJump = cb_SlideJump.IsChecked();
		game_style.default.bLandIntoSlide = cb_LandIntoSlide.IsChecked();
		game_style.default.bSlideSteering = cb_SlideSteering.IsChecked();
		game_style.default.bSlideToSprint = cb_SlideToSprint.IsChecked();

    	game_style.static.StaticSaveConfig();
	}
}

defaultproperties
{	 
     Begin Object Class=moNumericEdit Name=ne_PlayerGroundSpeedC
         MinValue=160
         MaxValue=1000
         Step=20
         ComponentWidth=0.175000
         Caption="Movement Speed"
         OnCreateComponent=ne_PlayerGroundSpeedC.InternalOnCreateComponent
         Hint="Player ground and air speed. 160 - 1000. 440 is UT2004 default."
         WinTop=0.100000
         WinLeft=0.020000
         WinWidth=0.460000
         WinHeight=0.040000
     End Object
     ne_PlayerGroundSpeed=moNumericEdit'ne_PlayerGroundSpeedC'

     Begin Object Class=moNumericEdit Name=ne_PlayerAccelRateC
         MinValue=1024
         MaxValue=4096
        Step=256
         ComponentWidth=0.175000
         Caption="Acceleration Rate"
         OnCreateComponent=ne_PlayerAccelRateC.InternalOnCreateComponent
         Hint="Scales player acceleration. 1024 - 4096. UT2004 is 2048."
         WinTop=0.150000
         WinLeft=0.020000
         WinWidth=0.460000
         WinHeight=0.040000
     End Object
     ne_PlayerAccelRate=moNumericEdit'ne_PlayerAccelRateC'

	Begin Object Class=moCheckBox Name=cb_bPlayerDecelerationC
         ComponentWidth=0.175000
         Caption="Player Deceleration"
         OnCreateComponent=cb_bPlayerDecelerationC.InternalOnCreateComponent
         Hint="Players will decelerate gradually when movement stops."
         WinTop=0.200000
         WinLeft=0.020000
         WinWidth=0.460000
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
         WinLeft=0.020000
         WinWidth=0.460000
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
         WinTop=0.300000
         WinLeft=0.020000
         WinWidth=0.460000
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
         WinLeft=0.020000
         WinWidth=0.460000
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
         WinTop=0.400000
         WinLeft=0.020000
         WinWidth=0.460000
         WinHeight=0.040000
     End Object
     ch_AllowDoubleJump=moCheckBox'ch_AllowDoubleJumpCheck'

    Begin Object Class=moCheckBox Name=cb_AllowCrouchSlidingC
        ComponentWidth=0.175000
        Caption="Enable Crouch Sliding"
        OnCreateComponent=cb_AllowCrouchSlidingC.InternalOnCreateComponent
        Hint="Enables crouch sliding."
        OnChange=ConfigTab_MovementRules.RowChanged
        WinTop=0.500000
        WinLeft=0.520000
        WinWidth=0.460000
        WinHeight=0.040000
    End Object
    cb_AllowCrouchSliding=moCheckBox'cb_AllowCrouchSlidingC'

	 Begin Object Class=moCheckBox Name=cb_bUseSprintC
         ComponentWidth=0.175000
         Caption="Enable Sprint"
         OnCreateComponent=cb_bUseSprintC.InternalOnCreateComponent
         Hint="Enables sprint."
         WinTop=0.100000
         WinLeft=0.520000
         WinWidth=0.460000
         WinHeight=0.040000
         OnChange=ConfigTab_MovementRules.RowChanged
     End Object
     cb_bUseSprint=moCheckBox'cb_bUseSprintC'

	 Begin Object Class=moCheckBox Name=cb_FireEndsSprintC
         ComponentWidth=0.175000
         Caption="Fire Ends Sprint"
         OnCreateComponent=cb_FireEndsSprintC.InternalOnCreateComponent
         Hint="Pressing fire in a sprint ends the sprint, and the gun comes back quickly to shoot. Off: the gun fires from where the sprint holds it."
         WinTop=0.150000
         WinLeft=0.520000
         WinWidth=0.460000
         WinHeight=0.040000
     End Object
     cb_FireEndsSprint=moCheckBox'cb_FireEndsSprintC'

	 Begin Object Class=moCheckBox Name=cb_SightsEndSprintC
         ComponentWidth=0.175000
         Caption="Sights End Sprint"
         OnCreateComponent=cb_SightsEndSprintC.InternalOnCreateComponent
         Hint="The sight key ends a sprint and the sights come up at once. Off: the sights do not come up until the sprint is over."
         WinTop=0.200000
         WinLeft=0.520000
         WinWidth=0.460000
         WinHeight=0.040000
     End Object
     cb_SightsEndSprint=moCheckBox'cb_SightsEndSprintC'

     Begin Object Class=moNumericEdit Name=ne_StaminaDrainRateC
         MinValue=0
         MaxValue=35
         Step=5
         ComponentWidth=0.175000
         Caption="Stamina Drain % Per Second"
         OnCreateComponent=ne_StaminaDrainRateC.InternalOnCreateComponent
         Hint="Percentage of stamina to drain every second when sprinting."
         WinTop=0.250000
         WinLeft=0.520000
         WinWidth=0.460000
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
         WinTop=0.300000
         WinLeft=0.520000
         WinWidth=0.460000
         WinHeight=0.040000
     End Object
     ne_StaminaChargeRate=moNumericEdit'ne_StaminaChargeRateC'

     Begin Object Class=moFloatEdit Name=fe_InitSpeedFactorC
         MinValue=1.100000
         MaxValue=2.500000
         Step=0.05
         ComponentWidth=0.175000
         Caption="Sprint Speed Multiplier"
         OnCreateComponent=fe_InitSpeedFactorC.InternalOnCreateComponent
         Hint="The speed multiplier during sprint."
         WinTop=0.350000
         WinLeft=0.520000
         WinWidth=0.460000
         WinHeight=0.040000
     End Object
     fe_InitSpeedFactor=moFloatEdit'fe_InitSpeedFactorC'

     Begin Object Class=moFloatEdit Name=fe_JumpDrainC
         MinValue=0.000000
         MaxValue=10.000000
         ComponentWidth=0.175000
         Caption="Jump/Slide Drain"
         OnCreateComponent=fe_JumpDrainC.InternalOnCreateComponent
         Hint="The amount of stamina we lose when we jump or slide."
         WinTop=0.400000
         WinLeft=0.520000
         WinWidth=0.460000
         WinHeight=0.040000
     End Object
     fe_JumpDrain=moFloatEdit'fe_JumpDrainC'

     Begin Object Class=moFloatEdit Name=fe_StaminaRechargeDelayC
         MinValue=0.000000
         MaxValue=5.000000
         Step=0.1
         ComponentWidth=0.175000
         Caption="Stamina Recharge Delay"
         OnCreateComponent=fe_StaminaRechargeDelayC.InternalOnCreateComponent
         Hint="The delay before stamina starts to recharge."
         WinTop=0.450000
         WinLeft=0.520000
         WinWidth=0.460000
         WinHeight=0.040000
     End Object
     fe_StaminaRechargeDelay=moFloatEdit'fe_StaminaRechargeDelayC'

	Begin Object Class=moCheckBox Name=cb_WallRunC
		ComponentWidth=0.175000
		Caption="Wall Running"
		OnCreateComponent=cb_WallRunC.InternalOnCreateComponent
		Hint="Jump at a wall from a sprint to run along it for a moment, using stamina. Jump again to kick off it."
		WinTop=0.450000
		WinLeft=0.020000
		WinWidth=0.460000
		WinHeight=0.040000
	End Object
	cb_WallRun=moCheckBox'cb_WallRunC'

	Begin Object Class=moCheckBox Name=cb_SlideJumpC
		ComponentWidth=0.175000
		Caption="Slide Jumps"
		OnCreateComponent=cb_SlideJumpC.InternalOnCreateComponent
		Hint="Jumping out of a slide keeps its speed and goes full height. A slide from any landing goes on with the speed you land with, no new push."
		WinTop=0.550000
		WinLeft=0.520000
		WinWidth=0.460000
		WinHeight=0.040000
	End Object
	cb_SlideJump=moCheckBox'cb_SlideJumpC'

	Begin Object Class=moCheckBox Name=cb_LandIntoSlideC
		ComponentWidth=0.175000
		Caption="Land Into Slides"
		OnCreateComponent=cb_LandIntoSlideC.InternalOnCreateComponent
		Hint="Landing with crouch held carries the fall into the slide: down a slope, or a little after a long drop."
		WinTop=0.600000
		WinLeft=0.520000
		WinWidth=0.460000
		WinHeight=0.040000
	End Object
	cb_LandIntoSlide=moCheckBox'cb_LandIntoSlideC'

	Begin Object Class=moCheckBox Name=cb_SlideSteeringC
		ComponentWidth=0.175000
		Caption="Slide Steering"
		OnCreateComponent=cb_SlideSteeringC.InternalOnCreateComponent
		Hint="The movement keys bend a slide's path a little, for some of its speed. The back key held brakes it."
		WinTop=0.650000
		WinLeft=0.520000
		WinWidth=0.460000
		WinHeight=0.040000
	End Object
	cb_SlideSteering=moCheckBox'cb_SlideSteeringC'

	Begin Object Class=moCheckBox Name=cb_SlideToSprintC
		ComponentWidth=0.175000
		Caption="Sprint Out Of Slides"
		OnCreateComponent=cb_SlideToSprintC.InternalOnCreateComponent
		Hint="Letting go of crouch in a slide with the sprint key held goes straight into a sprint."
		WinTop=0.700000
		WinLeft=0.520000
		WinWidth=0.460000
		WinHeight=0.040000
	End Object
	cb_SlideToSprint=moCheckBox'cb_SlideToSprintC'

	Begin Object Class=GUILabel Name=l_MovementLabel
		Caption="Movement"
		TextColor=(B=255,G=255,R=255)
		WinTop=0.050000
		WinLeft=0.020000
		WinWidth=0.460000
		WinHeight=0.040000
	End Object
	l_Movement=GUILabel'l_MovementLabel'

	Begin Object Class=GUILabel Name=l_SprintSlideLabel
		Caption="Sprint & Slide"
		TextColor=(B=255,G=255,R=255)
		WinTop=0.050000
		WinLeft=0.520000
		WinWidth=0.460000
		WinHeight=0.040000
	End Object
	l_SprintSlide=GUILabel'l_SprintSlideLabel'
}
