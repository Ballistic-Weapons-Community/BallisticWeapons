//=============================================================================
// GunGameWeaponMenu
//
// The Weapon List button of GunGame's game options: the Ballistic weapon
// chooser with spare weapons on the left and GunGame's level order on the
// right. The first weapon is the standard weapon, the last one wins.
//
// DONE writes the whole level order to GunGameConfig.WeaponList in
// GunGameBW.ini, also when it is the stock list, so the file can be copied
// to a server as it is. The menu and the game both read the list from there.
//
// A GUICustomPropertyPage: the game options' Edit button (UT2K4PlayInfoPanel.
// CustomClicked) takes the page it opens as one.
//=============================================================================
class GunGameWeaponMenu extends GUICustomPropertyPage;

var automated BC_WeaponListEditor	Editor;
var automated GUILabel				l_Status;
var automated GUIButton				b_Reset;

var() localized string				Heading;
var() localized string				TooFewText;
var() localized string				DoneText, DoneHint, CancelText, CancelHint;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local array<string> Names;

	Super.InitComponent(MyController, MyOwner);

	// the chooser has its own frames
	sb_Main.SetVisibility(false);

	b_OK.Caption = DoneText;
	b_OK.SetHint(DoneHint);
	b_Cancel.Caption = CancelText;
	b_Cancel.SetHint(CancelHint);
	b_Reset.WinTop = b_OK.WinTop;
	l_Status.WinTop = b_OK.WinTop;

	// Ballistic weapons only: no UT2004 or other weapons on offer
	Editor.AddAllGameWeapons(Heading, "", "");
	Editor.MaxChosen = class'GunGameConfig'.static.MaxWeapons();
	Editor.OnChosenChanged = ChosenChanged;

	if (class'GunGameConfig'.default.WeaponList.Length > 0)
		ClassNames(class'GunGameConfig'.default.WeaponList, Names);
	else
		ClassNames(class'GunGameConfig'.default.StockWeaponList, Names);
	Editor.Chosen = Names;
	Editor.SetOrdered(true, true);
}

function ClassNames(array< class<Weapon> > List, out array<string> Names)
{
	local int i;

	Names.Length = 0;
	for (i = 0; i < List.Length; i++)
		if (List[i] != None)
			Names[Names.Length] = string(List[i]);
}

function ChosenChanged(BC_WeaponListEditor Sender)
{
	l_Status.Caption = "";
}

function bool Save()
{
	local array<string> Names;
	local array< class<Weapon> > List;
	local class<Weapon> W;
	local int i;

	Editor.GetChosen(Names);
	for (i = 0; i < Names.Length; i++)
	{
		W = class<Weapon>(DynamicLoadObject(Names[i], class'Class', true));
		if (W != None)
			List[List.Length] = W;
	}

	if (List.Length < class'GunGameConfig'.static.MinWeapons())
	{
		l_Status.Caption = TooFewText;
		return false;
	}

	class'GunGameConfig'.default.WeaponList = List;
	class'GunGameConfig'.static.StaticSaveConfig();
	return true;
}

// The value the game options keep for the Weapon List row: how many levels the saved list has
function string GetDataString()
{
	local array< class<Weapon> > List;

	class'GunGameConfig'.static.GetWeaponList(List);
	return string(List.Length);
}

function bool InternalOnClick(GUIComponent Sender)
{
	local array<string> Names;

	if (Sender == b_Reset)
	{
		ClassNames(class'GunGameConfig'.default.StockWeaponList, Names);
		Editor.SetChosen(Names);
		l_Status.Caption = "";
	}
	else if (Sender == b_Cancel)
		Controller.CloseMenu(true);
	else if (Sender == b_OK && Save())
		Controller.CloseMenu(false);
	return true;
}

// The X on the title bar closes without saving
function bool XButtonClicked(GUIComponent Sender)
{
	Controller.CloseMenu(true);
	return true;
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
	if (Key == 0x0D && State == 3)	// Enter
		return InternalOnClick(b_OK);
	return false;
}

defaultproperties
{
	Begin Object Class=BC_WeaponListEditor Name=WeaponEditor
		ChosenCaption="Level Order"
		bBoundToParent=True
		bScaleToParent=True
		WinTop=0.080000
		WinLeft=0.030000
		WinWidth=0.940000
		WinHeight=0.780000
		TabOrder=0
	End Object
	Editor=BC_WeaponListEditor'GunGameBW.GunGameWeaponMenu.WeaponEditor'

	Begin Object Class=GUIButton Name=ResetButton
		Caption="RESET TO DEFAULT"
		Hint="Put back the list GunGame comes with."
		bBoundToParent=True
		WinTop=0.900000
		WinLeft=0.030000
		WinWidth=0.200000
		TabOrder=1
		OnClick=GunGameWeaponMenu.InternalOnClick
		OnKeyEvent=ResetButton.InternalOnKeyEvent
	End Object
	b_Reset=GUIButton'GunGameBW.GunGameWeaponMenu.ResetButton'

	Begin Object Class=GUILabel Name=StatusLabel
		TextAlign=TXTA_Center
		TextColor=(B=80,G=80,R=255)
		bBoundToParent=True
		WinTop=0.900000
		WinLeft=0.270000
		WinWidth=0.270000
		WinHeight=0.040000
	End Object
	l_Status=GUILabel'GunGameBW.GunGameWeaponMenu.StatusLabel'

	Heading="Ballistic Weapons"
	TooFewText="GunGame needs at least 2 weapons"
	DoneText="DONE"
	DoneHint="Save the level order to GunGameBW.ini."
	CancelText="CANCEL"
	CancelHint="Close without saving."

	WindowName="GunGame Weapon List"
	bMoveAllowed=False
	bResizeWidthAllowed=False
	bResizeHeightAllowed=False
	bAllowedAsLast=True
	DefaultLeft=0.050000
	DefaultTop=0.150000
	DefaultWidth=0.900000
	DefaultHeight=0.750000
	WinLeft=0.050000
	WinTop=0.150000
	WinWidth=0.900000
	WinHeight=0.750000
	OnKeyEvent=GunGameWeaponMenu.InternalOnKeyEvent
}
