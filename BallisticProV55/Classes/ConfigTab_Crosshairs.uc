//=============================================================================
// ConfigTab_Crosshairs
//
// What all crosshairs share: their type, where they go, their colours and their
// size, with a preview drawn the way the game draws them, at their real size.
// Each weapon's own graphical crosshair is on ConfigMenu_WeaponCrosshairs.
//=============================================================================
class ConfigTab_Crosshairs extends ConfigTabBase;

const PRESET_COUNT = 10;				// With the last one, Custom
const COLOUR_MAIN = 0;
const COLOUR_EMPTY = 1;
const COLOUR_COCKING = 2;
const PREVIEW_GAP = 4;					// The Simple crosshair's gap at rest

var automated moComboBox	co_Crosshairs, co_Colour, co_EmptyColour, co_CockingColour;
var automated moCheckbox	ch_FirstPersonAim, ch_Crosshairdot, ch_Distance, ch_OneColour, ch_Warnings;
var automated moSlider		sl_GlobalScale, sl_CrossGrow, sl_Opacity, sl_Red, sl_Green, sl_Blue;
var automated GUIImage		Img_BackShot, Box_Shot;
var automated GUIButton		b_WeaponCrosshairs;
var automated GUILabel		l_Custom, l_StockNote;

var() localized string		PresetNames[PRESET_COUNT];
var() Color					PresetColours[PRESET_COUNT];	// The first is the default crosshair, the last two the default warnings' places
var() localized string		CustomCaptions[3];

var Color					Colours[3];		// The three colours being edited, without their opacity
var int						CustomColour;	// Which of them the Custom sliders show
var bool					bSettingUp;		// The boxes are being filled, not changed by the player
var float					PreviewTime;

function InitializeConfigTab()
{
	co_Crosshairs.AddItem("Simple" ,,string(0));
	co_Crosshairs.AddItem("Graphical" ,,string(1));
	co_Crosshairs.AddItem("UT2004" ,,string(2));
	co_Crosshairs.ReadOnly(True);

	AddPresets(co_Colour);
	AddPresets(co_EmptyColour);
	AddPresets(co_CockingColour);
}

function AddPresets(moComboBox Box)
{
	local int i;

	for (i = 0; i < PRESET_COUNT; i++)
		Box.AddItem(PresetNames[i] ,,string(i));
	Box.ReadOnly(True);
}

function moComboBox ColourBox(int i)
{
	switch (i)
	{
		case COLOUR_EMPTY:		return co_EmptyColour;
		case COLOUR_COCKING:	return co_CockingColour;
	}
	return co_Colour;
}

// The preset with this colour, or Custom
function int FindPreset(Color Col)
{
	local int i;

	for (i = 0; i < PRESET_COUNT - 1; i++)
		if (PresetColours[i].R == Col.R && PresetColours[i].G == Col.G && PresetColours[i].B == Col.B)
			return i;
	return PRESET_COUNT - 1;
}

function SetColours(Color Main, Color Empty, Color Cocking, byte Opacity)
{
	Colours[COLOUR_MAIN] = Main;
	Colours[COLOUR_EMPTY] = Empty;
	Colours[COLOUR_COCKING] = Cocking;

	bSettingUp = true;
	co_Colour.SetIndex(FindPreset(Main));
	co_EmptyColour.SetIndex(FindPreset(Empty));
	co_CockingColour.SetIndex(FindPreset(Cocking));
	sl_Opacity.SetValue(Opacity);
	bSettingUp = false;

	ShowCustomColour(COLOUR_MAIN);
}

// What the Custom sliders say belongs to the colour they show
function ReadCustomColour()
{
	if (!sl_Red.bVisible)
		return;

	Colours[CustomColour].R = sl_Red.GetValue();
	Colours[CustomColour].G = sl_Green.GetValue();
	Colours[CustomColour].B = sl_Blue.GetValue();
}

// The Custom sliders belong to the colour box used last, and only show if it is on Custom
function ShowCustomColour(int i)
{
	local bool bCustom;

	CustomColour = i;
	bCustom = ColourBox(i).GetIndex() == PRESET_COUNT - 1;

	sl_Red.SetVisibility(bCustom);
	sl_Green.SetVisibility(bCustom);
	sl_Blue.SetVisibility(bCustom);
	l_Custom.SetVisibility(bCustom);
	l_Custom.Caption = CustomCaptions[i];

	if (bCustom)
	{
		bSettingUp = true;
		sl_Red.SetValue(Colours[i].R);
		sl_Green.SetValue(Colours[i].G);
		sl_Blue.SetValue(Colours[i].B);
		bSettingUp = false;
	}
}

// Rows that mean nothing for this crosshair type are greyed out, and the warning boxes with the warnings off
function UpdateRows()
{
	local bool bBallistic, bSimple, bGraphical;

	bSimple = co_Crosshairs.GetIndex() == 0;
	bGraphical = co_Crosshairs.GetIndex() == 1;
	bBallistic = bSimple || bGraphical;

	l_StockNote.SetVisibility(!bBallistic);
	SetRowEnabled(ch_Crosshairdot, bSimple);
	SetRowEnabled(sl_CrossGrow, bGraphical);
	SetRowEnabled(ch_OneColour, bGraphical);
	SetRowEnabled(co_Colour, bBallistic);
	SetRowEnabled(sl_Opacity, bBallistic);
	SetRowEnabled(ch_Warnings, bBallistic);
	SetRowEnabled(ch_Distance, bBallistic);
	SetRowEnabled(co_EmptyColour, bBallistic && ch_Warnings.IsChecked());
	SetRowEnabled(co_CockingColour, bBallistic && ch_Warnings.IsChecked());
}

function LoadSettings()
{
	bSettingUp = true;
	co_Crosshairs.SetIndex(class'BallisticWeapon'.default.CrosshairMode);
	ch_FirstPersonAim.Checked(class'BC_CrosshairSettings'.default.CrosshairAim == 2);
	ch_Crosshairdot.Checked(class'BallisticWeapon'.default.bDrawCrosshairDot);
	ch_Distance.Checked(class'BC_CrosshairSettings'.default.bDistanceSize);
	ch_OneColour.Checked(class'BC_CrosshairSettings'.default.bOneColour);
	ch_Warnings.Checked(class'BC_CrosshairSettings'.default.bWarningColours);
	sl_GlobalScale.SetValue(class'HUD'.default.CrosshairScale);
	sl_CrossGrow.SetValue(class'BallisticWeapon'.default.NDCrosshairScaleFactor);
	bSettingUp = false;

	SetColours(class'BC_CrosshairSettings'.default.CrosshairColor, class'BC_CrosshairSettings'.default.MagEmptyColor,
		class'BC_CrosshairSettings'.default.CockingColor, class'BC_CrosshairSettings'.default.CrosshairColor.A);
	UpdateRows();
}

function SaveSettings()
{
	local Color Col;
	local byte Opacity;

	if (!bInitialized)
		return;

	class'BallisticWeapon'.default.CrosshairMode			= ECrosshairMode(co_Crosshairs.GetIndex());
	class'BallisticWeapon'.default.bDrawCrosshairDot		= ch_Crosshairdot.IsChecked();
	class'BallisticWeapon'.default.NDCrosshairScaleFactor	= sl_CrossGrow.GetValue();
	class'HUD'.default.CrosshairScale						= sl_GlobalScale.GetValue();

	ReadCustomColour();
	Opacity = sl_Opacity.GetValue();
	// third person always follows the aim: the setting is only first person's (CHA_Always), kept as the old values
	if (ch_FirstPersonAim.IsChecked())
		class'BC_CrosshairSettings'.default.CrosshairAim	= 2;
	else
		class'BC_CrosshairSettings'.default.CrosshairAim	= 1;
	class'BC_CrosshairSettings'.default.bDistanceSize		= ch_Distance.IsChecked();
	class'BC_CrosshairSettings'.default.bOneColour			= ch_OneColour.IsChecked();
	class'BC_CrosshairSettings'.default.bWarningColours		= ch_Warnings.IsChecked();
	Col = Colours[COLOUR_MAIN];
	Col.A = Opacity;
	class'BC_CrosshairSettings'.default.CrosshairColor		= Col;
	Col = Colours[COLOUR_EMPTY];
	Col.A = Opacity;
	class'BC_CrosshairSettings'.default.MagEmptyColor		= Col;
	Col = Colours[COLOUR_COCKING];
	Col.A = Opacity;
	class'BC_CrosshairSettings'.default.CockingColor		= Col;

	class'BallisticWeapon'.static.StaticSaveConfig();
	class'BC_CrosshairSettings'.static.StaticSaveConfig();
	class'HUD'.static.StaticSaveConfig();

	// A weapon decides on the UT2004 crosshair as it comes up, so the one in the hands has to be told
	if (PlayerOwner().Pawn != None && BallisticWeapon(PlayerOwner().Pawn.Weapon) != None)
		BallisticWeapon(PlayerOwner().Pawn.Weapon).HideStockCrosshair(co_Crosshairs.GetIndex() != 2);
}

function DefaultSettings()
{
	bSettingUp = true;
	co_Crosshairs.SetIndex(0);
	ch_FirstPersonAim.Checked(false);
	ch_Crosshairdot.Checked(true);
	ch_Distance.Checked(false);
	ch_OneColour.Checked(false);
	ch_Warnings.Checked(true);
	sl_GlobalScale.SetValue(1.0);
	sl_CrossGrow.SetValue(1.0);
	bSettingUp = false;

	SetColours(PresetColours[0], PresetColours[7], PresetColours[8], 150);
	UpdateRows();
}

function InternalOnChange(GUIComponent Sender)
{
	if (!bInitialized || bSettingUp)
		return;

	switch (Sender)
	{
		case co_Colour:			PickColour(COLOUR_MAIN);	break;
		case co_EmptyColour:	PickColour(COLOUR_EMPTY);	break;
		case co_CockingColour:	PickColour(COLOUR_COCKING);	break;
		case co_Crosshairs:
		case ch_Warnings:		UpdateRows();				break;
	}
}

function PickColour(int i)
{
	local int Preset;

	ReadCustomColour();
	Preset = ColourBox(i).GetIndex();
	if (Preset < PRESET_COUNT - 1)
		Colours[i] = PresetColours[Preset];
	ShowCustomColour(i);
}

function bool InternalOnClick(GUIComponent Sender)
{
	if (Sender == b_WeaponCrosshairs)
		Controller.OpenMenu("BallisticProV55.ConfigMenu_WeaponCrosshairs");
	return true;
}

// The crosshair of the weapon in the player's hands, or of the M50 outside a game
function BallisticWeapon.NonDefCrosshairCfg PreviewCrosshair()
{
	if (PlayerOwner().Pawn != None && BallisticWeapon(PlayerOwner().Pawn.Weapon) != None)
		return BallisticWeapon(PlayerOwner().Pawn.Weapon).NDCrosshairCfg;
	return class'M50AssaultRifle'.default.NDCrosshairCfg;
}

function DrawPreviewCrosshair(Canvas C, float X, float Y, int ColourIndex, float DistanceScale)
{
	local BallisticWeapon.NonDefCrosshairCfg Cfg;
	local IntBox Size;
	local Color Col;
	local float Scale;

	Col = Colours[ColourIndex];
	Col.A = sl_Opacity.GetValue();

	if (co_Crosshairs.GetIndex() == 0)
	{
		class'BallisticWeapon'.static.DrawCrosshairBars(C, X, Y, PREVIEW_GAP, PREVIEW_GAP, Col, C.ClipY / 1080 * sl_GlobalScale.GetValue(), DistanceScale, ch_Crosshairdot.IsChecked());
		return;
	}

	Cfg = PreviewCrosshair();
	if (ch_OneColour.IsChecked() || ColourIndex != COLOUR_MAIN)
	{
		Cfg.Color1 = Col;
		Cfg.Color2 = Col;
	}
	Scale = C.ClipX / 1600 * sl_GlobalScale.GetValue() * DistanceScale;
	Size.X1 = Cfg.StartSize1 * Scale;
	Size.Y1 = Size.X1;
	Size.X2 = Cfg.StartSize2 * Scale;
	Size.Y2 = Size.X2;
	class'BallisticWeapon'.static.DrawCrosshairImages(C, X, Y, Cfg, Size);
}

// With distance on, the crosshair goes through the sizes it has from near to far. With warnings on, they stand beside it
function DrawPreview(Canvas C)
{
	local float Left, Top, Width, Height, DistanceScale;

	if (!bInitialized || co_Crosshairs.GetIndex() == 2)
		return;

	ReadCustomColour();

	Left = Img_BackShot.ActualLeft();
	Top = Img_BackShot.ActualTop();
	Width = Img_BackShot.ActualWidth();
	Height = Img_BackShot.ActualHeight();

	DistanceScale = 1;
	if (ch_Distance.IsChecked())
	{
		PreviewTime += Controller.RenderDelta;
		DistanceScale = class'BallisticWeapon'.static.CrosshairDistanceScale(Exp((0.5 - 0.5 * Cos(PreviewTime * 1.5)) * 8.3));
	}

	C.Style = 5; //STY_Alpha
	if (ch_Warnings.IsChecked())
	{
		DrawPreviewCrosshair(C, Left + Width * 0.2, Top + Height * 0.5, COLOUR_EMPTY, DistanceScale);
		DrawPreviewCrosshair(C, Left + Width * 0.8, Top + Height * 0.5, COLOUR_COCKING, DistanceScale);
	}
	DrawPreviewCrosshair(C, Left + Width * 0.5, Top + Height * 0.5, COLOUR_MAIN, DistanceScale);
}

defaultproperties
{
	Begin Object Class=moComboBox Name=co_CrosshairCombo
		ComponentJustification=TXTA_Left
		CaptionWidth=0.550000
		Caption="Crosshair Type"
		OnCreateComponent=co_CrosshairCombo.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="Simple shows inaccuracy with its gap. Graphical uses each weapon's own crosshair, and grows with inaccuracy and recoil. UT2004 uses your Unreal Tournament 2004 crosshair."
		WinTop=0.030000
		WinLeft=0.020000
		WinWidth=0.470000
		WinHeight=0.040000
		OnChange=ConfigTab_Crosshairs.InternalOnChange
	End Object
	co_Crosshairs=moComboBox'co_CrosshairCombo'

	Begin Object Class=moCheckBox Name=ch_FirstPersonAimCheck
		ComponentJustification=TXTA_Left
		CaptionWidth=0.900000
		Caption="Crosshair Follows Aim In First Person"
		OnCreateComponent=ch_FirstPersonAimCheck.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="The crosshair goes where a shot would land, following the gun's sway, recoil and the drop of a sprint, as it always does in third person (where the camera is beside your eyes). Off: it stays in the middle of the screen."
		WinTop=0.085000
		WinLeft=0.020000
		WinWidth=0.470000
		WinHeight=0.040000
	End Object
	ch_FirstPersonAim=moCheckBox'ch_FirstPersonAimCheck'

	Begin Object Class=moCheckBox Name=ch_CrosshairdotCheck
		ComponentJustification=TXTA_Left
		CaptionWidth=0.900000
		Caption="Show Dot In Crosshair"
		OnCreateComponent=ch_CrosshairdotCheck.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="Add a dot to the center of the Simple crosshair."
		WinTop=0.140000
		WinLeft=0.020000
		WinWidth=0.470000
		WinHeight=0.040000
	End Object
	ch_Crosshairdot=moCheckBox'ch_CrosshairdotCheck'

	Begin Object Class=moCheckBox Name=ch_DistanceCheck
		ComponentJustification=TXTA_Left
		CaptionWidth=0.900000
		Caption="Size Changes With Distance"
		OnCreateComponent=ch_DistanceCheck.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="The crosshair gets smaller the further away your shot would land, so it looks stuck to what you aim at. The Simple crosshair's gap still shows inaccuracy."
		WinTop=0.195000
		WinLeft=0.020000
		WinWidth=0.470000
		WinHeight=0.040000
	End Object
	ch_Distance=moCheckBox'ch_DistanceCheck'

	Begin Object Class=moSlider Name=sl_GlobalScaleSlider
		MaxValue=2.000000
		Caption="Global Size"
		OnCreateComponent=sl_GlobalScaleSlider.InternalOnCreateComponent
		Hint="The size of all crosshairs, including stock UT2004's."
		WinTop=0.250000
		WinLeft=0.020000
		WinWidth=0.470000
		WinHeight=0.040000
	End Object
	sl_GlobalScale=moSlider'sl_GlobalScaleSlider'

	Begin Object Class=moSlider Name=sl_CrossGrowSlider
		MaxValue=2.000000
		Caption="Crosshair Expansion"
		OnCreateComponent=sl_CrossGrowSlider.InternalOnCreateComponent
		Hint="How much graphical crosshairs grow to show inaccuracy and recoil."
		WinTop=0.305000
		WinLeft=0.020000
		WinWidth=0.470000
		WinHeight=0.040000
	End Object
	sl_CrossGrow=moSlider'sl_CrossGrowSlider'

	Begin Object Class=GUIButton Name=WeaponCrosshairsButton
		Caption="Edit Weapon Crosshairs"
		Hint="Choose each weapon's own graphical crosshair: its images, colours and sizes."
		WinTop=0.375000
		WinLeft=0.120000
		WinWidth=0.270000
		WinHeight=0.050000
		OnClick=ConfigTab_Crosshairs.InternalOnClick
		OnKeyEvent=WeaponCrosshairsButton.InternalOnKeyEvent
	End Object
	b_WeaponCrosshairs=GUIButton'WeaponCrosshairsButton'

	Begin Object Class=GUIImage Name=Box_ShotImg
		Image=Texture'2K4Menus.NewControls.Display99'
		ImageStyle=ISTY_Stretched
		WinTop=0.020000
		WinLeft=0.505000
		WinWidth=0.480000
		WinHeight=0.425000
		RenderWeight=0.001000
	End Object
	Box_Shot=GUIImage'Box_ShotImg'

	Begin Object Class=GUIImage Name=Img_BackShotImg
		Image=MaterialSequence'BW_Core_WeaponTex.Misc.MenuSequence'
		ImageStyle=ISTY_Scaled
		WinTop=0.035000
		WinLeft=0.520000
		WinWidth=0.450000
		WinHeight=0.395000
		RenderWeight=0.001500
		OnRendered=ConfigTab_Crosshairs.DrawPreview
	End Object
	Img_BackShot=GUIImage'Img_BackShotImg'

	Begin Object Class=GUILabel Name=StockNoteLabel
		Caption="The UT2004 crosshair is set in the game's own HUD settings."
		TextAlign=TXTA_Center
		TextColor=(B=255,G=255,R=255)
		bMultiLine=True
		WinTop=0.180000
		WinLeft=0.540000
		WinWidth=0.410000
		WinHeight=0.100000
		RenderWeight=0.002000
	End Object
	l_StockNote=GUILabel'StockNoteLabel'

	Begin Object Class=moComboBox Name=co_ColourCombo
		ComponentJustification=TXTA_Left
		CaptionWidth=0.550000
		Caption="Crosshair Colour"
		OnCreateComponent=co_ColourCombo.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="The colour of the Simple crosshair, and of Graphical ones with Use One Colour For All Weapons."
		WinTop=0.470000
		WinLeft=0.020000
		WinWidth=0.470000
		WinHeight=0.040000
		OnChange=ConfigTab_Crosshairs.InternalOnChange
	End Object
	co_Colour=moComboBox'co_ColourCombo'

	Begin Object Class=moSlider Name=sl_OpacitySlider
		MaxValue=255.000000
		bIntSlider=True
		Caption="Crosshair Opacity"
		OnCreateComponent=sl_OpacitySlider.InternalOnCreateComponent
		Hint="How solid the crosshair is, from invisible to fully solid. The Simple crosshair's dot stays stronger than its bars."
		WinTop=0.525000
		WinLeft=0.020000
		WinWidth=0.470000
		WinHeight=0.040000
	End Object
	sl_Opacity=moSlider'sl_OpacitySlider'

	Begin Object Class=moCheckBox Name=ch_OneColourCheck
		ComponentJustification=TXTA_Left
		CaptionWidth=0.900000
		Caption="Use One Colour For All Weapons"
		OnCreateComponent=ch_OneColourCheck.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="Graphical crosshairs take the colour and opacity above. Off: each weapon keeps its own."
		WinTop=0.580000
		WinLeft=0.020000
		WinWidth=0.470000
		WinHeight=0.040000
	End Object
	ch_OneColour=moCheckBox'ch_OneColourCheck'

	Begin Object Class=moCheckBox Name=ch_WarningsCheck
		ComponentJustification=TXTA_Left
		CaptionWidth=0.900000
		Caption="Warning Colours"
		OnCreateComponent=ch_WarningsCheck.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="The crosshair changes colour when the magazine is empty and when the gun needs cocking."
		WinTop=0.635000
		WinLeft=0.020000
		WinWidth=0.470000
		WinHeight=0.040000
		OnChange=ConfigTab_Crosshairs.InternalOnChange
	End Object
	ch_Warnings=moCheckBox'ch_WarningsCheck'

	Begin Object Class=moComboBox Name=co_EmptyColourCombo
		ComponentJustification=TXTA_Left
		CaptionWidth=0.550000
		Caption="Empty Magazine Colour"
		OnCreateComponent=co_EmptyColourCombo.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="The crosshair's colour when the magazine is empty."
		WinTop=0.690000
		WinLeft=0.020000
		WinWidth=0.470000
		WinHeight=0.040000
		OnChange=ConfigTab_Crosshairs.InternalOnChange
	End Object
	co_EmptyColour=moComboBox'co_EmptyColourCombo'

	Begin Object Class=moComboBox Name=co_CockingColourCombo
		ComponentJustification=TXTA_Left
		CaptionWidth=0.550000
		Caption="Needs Cocking Colour"
		OnCreateComponent=co_CockingColourCombo.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="The crosshair's colour when the gun needs cocking."
		WinTop=0.745000
		WinLeft=0.020000
		WinWidth=0.470000
		WinHeight=0.040000
		OnChange=ConfigTab_Crosshairs.InternalOnChange
	End Object
	co_CockingColour=moComboBox'co_CockingColourCombo'

	Begin Object Class=GUILabel Name=CustomLabel
		TextAlign=TXTA_Center
		TextColor=(B=0,G=180,R=255,A=255)
		WinTop=0.470000
		WinLeft=0.520000
		WinWidth=0.450000
		WinHeight=0.040000
	End Object
	l_Custom=GUILabel'CustomLabel'

	Begin Object Class=moSlider Name=sl_RedSlider
		MaxValue=255.000000
		bIntSlider=True
		CaptionWidth=0.350000
		Caption="Red"
		OnCreateComponent=sl_RedSlider.InternalOnCreateComponent
		Hint="The red in this custom colour."
		WinTop=0.525000
		WinLeft=0.520000
		WinWidth=0.450000
		WinHeight=0.040000
	End Object
	sl_Red=moSlider'sl_RedSlider'

	Begin Object Class=moSlider Name=sl_GreenSlider
		MaxValue=255.000000
		bIntSlider=True
		CaptionWidth=0.350000
		Caption="Green"
		OnCreateComponent=sl_GreenSlider.InternalOnCreateComponent
		Hint="The green in this custom colour."
		WinTop=0.580000
		WinLeft=0.520000
		WinWidth=0.450000
		WinHeight=0.040000
	End Object
	sl_Green=moSlider'sl_GreenSlider'

	Begin Object Class=moSlider Name=sl_BlueSlider
		MaxValue=255.000000
		bIntSlider=True
		CaptionWidth=0.350000
		Caption="Blue"
		OnCreateComponent=sl_BlueSlider.InternalOnCreateComponent
		Hint="The blue in this custom colour."
		WinTop=0.635000
		WinLeft=0.520000
		WinWidth=0.450000
		WinHeight=0.040000
	End Object
	sl_Blue=moSlider'sl_BlueSlider'

	PresetNames(0)="Default"
	PresetNames(1)="White"
	PresetNames(2)="Yellow"
	PresetNames(3)="Green"
	PresetNames(4)="Cyan"
	PresetNames(5)="Blue"
	PresetNames(6)="Magenta"
	PresetNames(7)="Red"
	PresetNames(8)="Orange"
	PresetNames(9)="Custom"

	PresetColours(0)=(B=255,G=225,R=255)
	PresetColours(1)=(B=255,G=255,R=255)
	PresetColours(2)=(B=0,G=255,R=255)
	PresetColours(3)=(B=0,G=255,R=0)
	PresetColours(4)=(B=255,G=255,R=0)
	PresetColours(5)=(B=255,G=120,R=80)
	PresetColours(6)=(B=255,G=0,R=255)
	PresetColours(7)=(B=50,G=50,R=255)
	PresetColours(8)=(B=50,G=175,R=255)

	CustomCaptions(0)="Custom crosshair colour"
	CustomCaptions(1)="Custom empty magazine colour"
	CustomCaptions(2)="Custom needs cocking colour"
}
