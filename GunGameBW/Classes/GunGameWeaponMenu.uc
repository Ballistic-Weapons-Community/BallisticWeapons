//=============================================================================
// GunGameWeaponMenu
//
// The Weapon List button of GunGame's game options: the Ballistic weapon
// chooser with spare weapons on the left and GunGame's level order on the
// right. The first weapon is the standard weapon, the last one wins. Saves
// GunGameConfig.WeaponList (GunGameBW.ini); a list the same as the stock one
// is saved as no list, so the stock list keeps up with new versions.
//=============================================================================
class GunGameWeaponMenu extends UT2K4GUIPage;

var automated GUIImage				MyBack;
var automated GUIHeader				MyHeader;
var automated BC_WeaponListEditor	Editor;
var automated GUILabel				l_Status;
var automated GUIButton				b_Reset, b_Done, b_Cancel;

var() localized string				Headings[3];
var() localized string				TooFewText;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local array<string> Names;

	Super.InitComponent(MyController, MyOwner);

	FillCatalogue();
	Editor.MaxChosen = class'GunGameConfig'.static.MaxWeapons();
	Editor.OnChosenChanged = ChosenChanged;

	if (class'GunGameConfig'.default.WeaponList.Length > 0)
		ClassNames(class'GunGameConfig'.default.WeaponList, Names);
	else
		ClassNames(class'GunGameConfig'.default.StockWeaponList, Names);
	Editor.Chosen = Names;
	Editor.SetOrdered(true, true);
}

// Every weapon of the game: Ballistic, then UT2004, then the rest
function FillCatalogue()
{
	local array<CacheManager.WeaponRecord> Recs;
	local array<byte> Kind;
	local int i, k;

	class'CacheManager'.static.GetWeaponList(Recs);
	class'BC_WeaponInfoCache'.static.SortWeaponRecords(Recs);

	Kind.Length = Recs.Length;
	for (i = 0; i < Recs.Length; i++)
	{
		if (!class'BC_WeaponInfoCache'.static.IsValid(Recs[i].ClassName))
			Kind[i] = 255;
		else if (class'BC_WeaponInfoCache'.static.AutoWeaponInfo(Recs[i].ClassName).bIsBW)
			Kind[i] = 0;
		else if (Left(Recs[i].ClassName, 9) ~= "XWeapons." || Left(Recs[i].ClassName, 10) ~= "UTClassic." || Left(Recs[i].ClassName, 9) ~= "Onslaught")
			Kind[i] = 1;
		else
			Kind[i] = 2;
	}
	class'BC_WeaponInfoCache'.static.EndSession();

	Editor.ClearCatalogue();
	for (k = 0; k < 3; k++)
	{
		Editor.AddSection(Headings[k]);
		for (i = 0; i < Recs.Length; i++)
			if (Kind[i] == k)
				Editor.AddWeapon(Recs[i].FriendlyName, Recs[i].ClassName);
	}
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

function bool SameAsStock(array< class<Weapon> > List)
{
	local int i;

	if (List.Length != class'GunGameConfig'.default.StockWeaponList.Length)
		return false;
	for (i = 0; i < List.Length; i++)
		if (List[i] != class'GunGameConfig'.default.StockWeaponList[i])
			return false;
	return true;
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

	if (SameAsStock(List))
	{
		class'GunGameConfig'.default.WeaponList.Length = 0;
		class'GunGameConfig'.static.StaticClearConfig("WeaponList");
	}
	else
	{
		class'GunGameConfig'.default.WeaponList = List;
		class'GunGameConfig'.static.StaticSaveConfig();
	}
	return true;
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
	else if (Sender == b_Done && Save())
		Controller.CloseMenu(false);
	return true;
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
	if (Key == 0x0D && State == 3)	// Enter
		return InternalOnClick(b_Done);
	return false;
}

defaultproperties
{
	Begin Object Class=GUIImage Name=BackImage
		Image=Texture'2K4Menus.NewControls.Display95'
		ImageStyle=ISTY_Stretched
		WinTop=0.150000
		WinLeft=0.050000
		WinWidth=0.900000
		WinHeight=0.750000
		RenderWeight=0.001000
	End Object
	MyBack=GUIImage'GunGameBW.GunGameWeaponMenu.BackImage'

	Begin Object Class=GUIHeader Name=DaBeegHeader
		bUseTextHeight=True
		Caption="GunGame Weapon List"
		WinTop=0.150000
		WinLeft=0.050000
		WinWidth=0.900000
		WinHeight=0.750000
	End Object
	MyHeader=GUIHeader'GunGameBW.GunGameWeaponMenu.DaBeegHeader'

	Begin Object Class=BC_WeaponListEditor Name=WeaponEditor
		ChosenCaption="Level Order"
		WinTop=0.220000
		WinLeft=0.080000
		WinWidth=0.840000
		WinHeight=0.560000
		TabOrder=0
	End Object
	Editor=BC_WeaponListEditor'GunGameBW.GunGameWeaponMenu.WeaponEditor'

	Begin Object Class=GUIButton Name=ResetButton
		Caption="RESET TO DEFAULT"
		Hint="Put back the list GunGame comes with."
		WinTop=0.810000
		WinLeft=0.080000
		WinWidth=0.220000
		TabOrder=1
		OnClick=GunGameWeaponMenu.InternalOnClick
		OnKeyEvent=ResetButton.InternalOnKeyEvent
	End Object
	b_Reset=GUIButton'GunGameBW.GunGameWeaponMenu.ResetButton'

	Begin Object Class=GUILabel Name=StatusLabel
		TextAlign=TXTA_Center
		TextColor=(B=80,G=80,R=255)
		WinTop=0.810000
		WinLeft=0.310000
		WinWidth=0.340000
		WinHeight=0.040000
	End Object
	l_Status=GUILabel'GunGameBW.GunGameWeaponMenu.StatusLabel'

	Begin Object Class=GUIButton Name=DoneButton
		Caption="DONE"
		WinTop=0.810000
		WinLeft=0.660000
		WinWidth=0.120000
		TabOrder=2
		OnClick=GunGameWeaponMenu.InternalOnClick
		OnKeyEvent=DoneButton.InternalOnKeyEvent
	End Object
	b_Done=GUIButton'GunGameBW.GunGameWeaponMenu.DoneButton'

	Begin Object Class=GUIButton Name=CancelButton
		Caption="CANCEL"
		WinTop=0.810000
		WinLeft=0.800000
		WinWidth=0.120000
		TabOrder=3
		OnClick=GunGameWeaponMenu.InternalOnClick
		OnKeyEvent=CancelButton.InternalOnKeyEvent
	End Object
	b_Cancel=GUIButton'GunGameBW.GunGameWeaponMenu.CancelButton'

	Headings(0)="Ballistic Weapons"
	Headings(1)="UT2004 Standard"
	Headings(2)="Other"
	TooFewText="GunGame needs at least 2 weapons"
	bRenderWorld=True
	bAllowedAsLast=True
	OnKeyEvent=GunGameWeaponMenu.InternalOnKeyEvent
}
