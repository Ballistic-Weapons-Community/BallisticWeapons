//=============================================================================
// ConfigTab_ThirdPerson
//
// The third person camera's settings (BC_ThirdPersonSettings), kept on this
// machine: whether to play in third person on foot, where the camera sits,
// and how the sights and the crosshair work with it. Three presets set the
// camera's place in one go.
//=============================================================================
class ConfigTab_ThirdPerson extends ConfigTabBase;

var automated moCheckbox	ch_ThirdPerson, ch_SightsFirstPerson, ch_AimCrosshair;
var automated moSlider		sl_Distance, sl_Height, sl_Side, sl_Smoothing;
var automated GUILabel		l_Presets, l_Keys;
var automated GUIButton		b_Shoulder, b_High, b_Close;

function LoadSettings()
{
	ch_ThirdPerson.Checked(class'BC_ThirdPersonSettings'.default.bThirdPerson);
	sl_Distance.SetValue(class'BC_ThirdPersonSettings'.default.Distance);
	sl_Height.SetValue(class'BC_ThirdPersonSettings'.default.Height);
	sl_Side.SetValue(class'BC_ThirdPersonSettings'.default.Side);
	sl_Smoothing.SetValue(class'BC_ThirdPersonSettings'.default.Smoothing);
	ch_SightsFirstPerson.Checked(class'BC_ThirdPersonSettings'.default.bSightsFirstPerson);
	ch_AimCrosshair.Checked(class'BC_ThirdPersonSettings'.default.bAimCrosshair);
}

function SaveSettings()
{
	if (!bInitialized)
		return;

	class'BC_ThirdPersonSettings'.default.bThirdPerson			= ch_ThirdPerson.IsChecked();
	class'BC_ThirdPersonSettings'.default.Distance				= sl_Distance.GetValue();
	class'BC_ThirdPersonSettings'.default.Height				= sl_Height.GetValue();
	class'BC_ThirdPersonSettings'.default.Side					= sl_Side.GetValue();
	class'BC_ThirdPersonSettings'.default.Smoothing				= sl_Smoothing.GetValue();
	class'BC_ThirdPersonSettings'.default.bSightsFirstPerson	= ch_SightsFirstPerson.IsChecked();
	class'BC_ThirdPersonSettings'.default.bAimCrosshair			= ch_AimCrosshair.IsChecked();
	class'BC_ThirdPersonSettings'.static.StaticSaveConfig();
}

function DefaultSettings()
{
	ch_ThirdPerson.Checked(false);
	SetCamera(110, 12, 32);
	sl_Smoothing.SetValue(0.3);
	ch_SightsFirstPerson.Checked(true);
	ch_AimCrosshair.Checked(true);
}

function SetCamera(float Distance, float Height, float Side)
{
	sl_Distance.SetValue(Distance);
	sl_Height.SetValue(Height);
	sl_Side.SetValue(Side);
}

function bool InternalOnClick(GUIComponent Sender)
{
	switch (Sender)
	{
		case b_Shoulder:	SetCamera(110, 12, 32);	break;
		case b_High:		SetCamera(210, 55, 0);	break;
		case b_Close:		SetCamera(75, 4, 36);	break;
	}
	return true;
}

defaultproperties
{
	Begin Object Class=moCheckBox Name=ch_ThirdPersonCheck
		ComponentJustification=TXTA_Left
		CaptionWidth=0.900000
		Caption="Third person camera"
		OnCreateComponent=ch_ThirdPersonCheck.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="Play on foot in third person. The Third Person key switches it in the game (Controls > Ballistic Weapons Keybinds), and your choice is kept. Online, the server has to allow behind view."
		WinTop=0.100000
		WinLeft=0.250000
		WinHeight=0.040000
	End Object
	ch_ThirdPerson=moCheckBox'ch_ThirdPersonCheck'

	Begin Object Class=moSlider Name=sl_DistanceSlider
		MinValue=40.000000
		MaxValue=300.000000
		bIntSlider=True
		ComponentJustification=TXTA_Left
		CaptionWidth=0.450000
		Caption="Camera distance"
		OnCreateComponent=sl_DistanceSlider.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="How far behind your head the camera sits. A player is about 90 units tall."
		WinTop=0.170000
		WinLeft=0.250000
		WinWidth=0.500000
	End Object
	sl_Distance=moSlider'sl_DistanceSlider'

	Begin Object Class=moSlider Name=sl_HeightSlider
		MinValue=-20.000000
		MaxValue=100.000000
		bIntSlider=True
		ComponentJustification=TXTA_Left
		CaptionWidth=0.450000
		Caption="Camera height"
		OnCreateComponent=sl_HeightSlider.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="How far above your eyes the camera sits."
		WinTop=0.220000
		WinLeft=0.250000
		WinWidth=0.500000
	End Object
	sl_Height=moSlider'sl_HeightSlider'

	Begin Object Class=moSlider Name=sl_SideSlider
		MinValue=-80.000000
		MaxValue=80.000000
		bIntSlider=True
		ComponentJustification=TXTA_Left
		CaptionWidth=0.450000
		Caption="Shoulder (left - right)"
		OnCreateComponent=sl_SideSlider.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="How far to the side of your head the camera sits: to the right above 0, to the left below, straight behind at 0. The Swap Shoulder key moves it to the other side."
		WinTop=0.270000
		WinLeft=0.250000
		WinWidth=0.500000
	End Object
	sl_Side=moSlider'sl_SideSlider'

	Begin Object Class=moSlider Name=sl_SmoothingSlider
		MinValue=0.000000
		MaxValue=1.000000
		ComponentJustification=TXTA_Left
		CaptionWidth=0.450000
		Caption="Camera smoothing"
		OnCreateComponent=sl_SmoothingSlider.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="How loosely the camera follows you over steps, jumps and turns of speed. At 0 it keeps exactly to you. Turning is never smoothed."
		WinTop=0.320000
		WinLeft=0.250000
		WinWidth=0.500000
	End Object
	sl_Smoothing=moSlider'sl_SmoothingSlider'

	Begin Object Class=moCheckBox Name=ch_SightsFirstPersonCheck
		ComponentJustification=TXTA_Left
		CaptionWidth=0.900000
		Caption="First person while using sights"
		OnCreateComponent=ch_SightsFirstPersonCheck.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="Switch to first person while the sights or the scope are up, and back when they come down."
		WinTop=0.390000
		WinLeft=0.250000
		WinHeight=0.040000
	End Object
	ch_SightsFirstPerson=moCheckBox'ch_SightsFirstPersonCheck'

	Begin Object Class=moCheckBox Name=ch_AimCrosshairCheck
		ComponentJustification=TXTA_Left
		CaptionWidth=0.900000
		Caption="Crosshair shows where shots land"
		OnCreateComponent=ch_AimCrosshairCheck.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="In third person your shots leave your eyes, not the camera. With this the crosshair moves to what they would hit, so a wall or a corner in front of your gun shows. Without it the crosshair stays in the middle of the screen."
		WinTop=0.440000
		WinLeft=0.250000
		WinHeight=0.040000
	End Object
	ch_AimCrosshair=moCheckBox'ch_AimCrosshairCheck'

	Begin Object Class=GUILabel Name=PresetsLabel
		Caption="Camera presets"
		TextColor=(B=255,G=255,R=255)
		WinTop=0.520000
		WinLeft=0.250000
		WinWidth=0.500000
		WinHeight=0.040000
	End Object
	l_Presets=GUILabel'PresetsLabel'

	Begin Object Class=GUIButton Name=ShoulderButton
		Caption="Shoulder"
		Hint="Over the shoulder: close behind and to the right of your head."
		WinTop=0.570000
		WinLeft=0.250000
		WinWidth=0.160000
		OnClick=ConfigTab_ThirdPerson.InternalOnClick
		OnKeyEvent=ShoulderButton.InternalOnKeyEvent
	End Object
	b_Shoulder=GUIButton'ShoulderButton'

	Begin Object Class=GUIButton Name=HighButton
		Caption="High"
		Hint="Above and behind: further back and higher, straight behind you."
		WinTop=0.570000
		WinLeft=0.420000
		WinWidth=0.160000
		OnClick=ConfigTab_ThirdPerson.InternalOnClick
		OnKeyEvent=HighButton.InternalOnKeyEvent
	End Object
	b_High=GUIButton'HighButton'

	Begin Object Class=GUIButton Name=CloseButton
		Caption="Close"
		Hint="Close up: just behind your right shoulder."
		WinTop=0.570000
		WinLeft=0.590000
		WinWidth=0.160000
		OnClick=ConfigTab_ThirdPerson.InternalOnClick
		OnKeyEvent=CloseButton.InternalOnKeyEvent
	End Object
	b_Close=GUIButton'CloseButton'

	Begin Object Class=GUILabel Name=KeysLabel
		Caption="Keys: Third Person and Swap Shoulder, under Controls > Ballistic Weapons Keybinds. In a vehicle the Third Person key works as before."
		TextColor=(B=200,G=200,R=200)
		bMultiLine=True
		WinTop=0.660000
		WinLeft=0.250000
		WinWidth=0.500000
		WinHeight=0.150000
	End Object
	l_Keys=GUILabel'KeysLabel'
}
