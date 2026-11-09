//=============================================================================
// BWMenuTheme
//
// The dark menu theme: BC_MenuMemory.MenuTheme 1 (0, the default, keeps the
// game's blue menus). Menus that take it (ConfigMenuBase.bThemed) swap the
// styles of their controls for the BWSTY_Dark ones and draw their sections
// and background dark.
//=============================================================================
class BWMenuTheme extends Object;

var Color PageColour;

static function bool IsDark()
{
	return class'BC_MenuMemory'.default.MenuTheme == 1;
}

static function Register(GUIController C)
{
	local GUI.eFontScale FS;

	FS = FNS_Medium;
	if (C.GetStyle("BWDarkButton", FS) != None)
		return;

	C.RegisterStyle(class'BWSTY_DarkButton');
	C.RegisterStyle(class'BWSTY_DarkTab');
	C.RegisterStyle(class'BWSTY_DarkTabBack');
	C.RegisterStyle(class'BWSTY_DarkHeader');
	C.RegisterStyle(class'BWSTY_DarkEdit');
	C.RegisterStyle(class'BWSTY_DarkCheckBox');
	C.RegisterStyle(class'BWSTY_DarkSliderBar');
	C.RegisterStyle(class'BWSTY_DarkList');
}

// The dark style that stands in for a stock one, or the style itself
static function GUIStyles Swap(GUIController C, GUIStyles S, GUI.eFontScale FontScale)
{
	local string Key;
	local GUIStyles NewStyle;

	if (S == None)
		return None;

	switch (S.KeyName)
	{
		case "SquareButton":	Key = "BWDarkButton";		break;
		case "TabButton":		Key = "BWDarkTab";			break;
		case "TabBackground":	Key = "BWDarkTabBack";		break;
		case "Header":			Key = "BWDarkHeader";		break;
		case "EditBox":			Key = "BWDarkEdit";			break;
		case "CheckBox":		Key = "BWDarkCheckBox";		break;
		case "SliderBar":		Key = "BWDarkSliderBar";	break;
		case "ComboListBox":	Key = "BWDarkList";			break;
		default:				return S;
	}
	NewStyle = C.GetStyle(Key, FontScale);
	if (NewStyle == None)
		return S;
	return NewStyle;
}

// Every control in and under Comp. Safe to run again on the same controls
static function Apply(GUIController C, GUIComponent Comp)
{
	Register(C);
	ApplyTo(C, Comp);
}

static function ApplyTo(GUIController C, GUIComponent Comp)
{
	local int i;
	local GUIMultiComponent M;
	local GUITabControl Tabs;

	if (Comp == None)
		return;

	Comp.Style = Swap(C, Comp.Style, Comp.FontScale);

	if (GUISlider(Comp) != None)
		GUISlider(Comp).BarStyle = Swap(C, GUISlider(Comp).BarStyle, Comp.FontScale);
	if (BWMenuSection(Comp) != None)
		BWMenuSection(Comp).SetDark(true);

	Tabs = GUITabControl(Comp);
	if (Tabs != None)
	{
		Tabs.BackgroundStyle = Swap(C, Tabs.BackgroundStyle, Comp.FontScale);
		for (i = 0; i < Tabs.TabStack.Length; i++)
		{
			ApplyTo(C, Tabs.TabStack[i]);
			if (Tabs.TabStack[i] != None)
				ApplyTo(C, Tabs.TabStack[i].MyPanel);
		}
	}

	M = GUIMultiComponent(Comp);
	if (M != None)
		for (i = 0; i < M.Controls.Length; i++)
			ApplyTo(C, M.Controls[i]);
}

// A menu's background image as a plain dark panel
static function DarkBackground(GUIImage Back)
{
	if (Back == None)
		return;
	Back.Image = Texture'Engine.WhiteTexture';
	Back.ImageColor = default.PageColour;
	Back.ImageStyle = ISTY_Stretched;
	Back.ImageRenderStyle = MSTY_Alpha;
}

defaultproperties
{
	PageColour=(R=18,G=21,B=28,A=242)
}
