//=============================================================================
// BallisticConflictWeaponMenuPro
//
// The weapons each team can buy in Conflict, opened from the game's options:
// the shared weapon chooser, a switch for the team shown and 'Both teams use
// the same weapons'.
//=============================================================================
class BallisticConflictWeaponMenuPro extends UT2K4GUIPage;

var automated GUIImage				MyBack;
var automated GUIHeader				MyHeader;
var automated BC_WeaponListEditor	Editor;
var automated GUILabel				l_Team;
var automated moCheckBox			ch_SameTeams;
var automated moComboBox			co_LoadOpt;
var automated GUIButton				BDone, BCancel;
var BC_TabRow						TeamRow;

var array<string>					RedNames, BlueNames;
var int								ShownTeam;		// 0 red, 1 blue
var bool							bLoading;

var() localized string				Headings[4];
var() localized string				TeamCaptions[2], TeamListCaptions[2], BothListCaption;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local array<CacheManager.WeaponRecord> Recs;
	local array<string> ItemNameList, Captions;
	local array<byte> Kind;
	local class<ConflictItem> CI;
	local int i, k;

	Super.InitComponent(MyController, MyOwner);

	// Ballistic weapons, the Conflict items, UT2004 weapons, the rest
	class'CacheManager'.static.GetWeaponList(Recs);
	class'BC_WeaponInfoCache'.static.SortWeaponRecords(Recs);
	Kind.Length = Recs.Length;
	for (i = 0; i < Recs.Length; i++)
	{
		if (Recs[i].ClassName == "" || !class'BC_WeaponInfoCache'.static.IsValid(Recs[i].ClassName))
			Kind[i] = 255;
		else if (class'BC_WeaponInfoCache'.static.AutoWeaponInfo(Recs[i].ClassName).bIsBW)
			Kind[i] = 0;
		else if (Left(Recs[i].ClassName, 9) ~= "XWeapons." || Left(Recs[i].ClassName, 10) ~= "UTClassic." || Left(Recs[i].ClassName, 9) ~= "Onslaught")
			Kind[i] = 2;
		else
			Kind[i] = 3;
	}
	class'BC_WeaponInfoCache'.static.EndSession();

	Editor.ClearCatalogue();
	for (k = 0; k < 4; k++)
	{
		Editor.AddSection(Headings[k]);
		if (k == 1)
		{
			PlayerOwner().GetAllInt("ConflictItem", ItemNameList);
			for (i = 0; i < ItemNameList.length; i++)
			{
				CI = class<ConflictItem>(DynamicLoadObject(ItemNameList[i], class'Class'));
				if (CI != None)
					Editor.AddWeapon(CI.default.ItemName, ItemNameList[i]);
			}
		}
		else
			for (i = 0; i < Recs.Length; i++)
				if (Kind[i] == k)
					Editor.AddWeapon(Recs[i].FriendlyName, Recs[i].ClassName);
	}
	Editor.OnChosenChanged = ChosenChanged;

	Captions[0] = TeamCaptions[0];
	Captions[1] = TeamCaptions[1];
	TeamRow = class'BC_TabRow'.static.Create(self, Editor, 0.230000, 0.175000, 0.280000, 0.040000, Captions);
	TeamRow.OnSwitch = TeamSwitched;

	for (i = 0; i < class'Mut_ConflictLoadout'.default.LoadoutOptionText.Length; i++)
		co_LoadOpt.AddItem(class'Mut_ConflictLoadout'.default.LoadoutOptionText[i],, string(i));
	co_LoadOpt.ReadOnly(True);
	co_LoadOpt.SetIndex(int(class'Mut_ConflictLoadout'.default.LoadoutOption));

	for (i = 0; i < class'Mut_ConflictLoadout'.default.ConflictWeapons.Length; i++)
	{
		if (class'Mut_ConflictLoadout'.default.ConflictWeapons[i].bRed)
			RedNames[RedNames.Length] = class'Mut_ConflictLoadout'.default.ConflictWeapons[i].ClassName;
		if (class'Mut_ConflictLoadout'.default.ConflictWeapons[i].bBlue)
			BlueNames[BlueNames.Length] = class'Mut_ConflictLoadout'.default.ConflictWeapons[i].ClassName;
	}
	bLoading = true;
	ch_SameTeams.Checked(class'ConfigTab_ConflictLoadout'.static.SameNames(RedNames, BlueNames));
	bLoading = false;
	ShowTeam();
}

function ShowTeam()
{
	if (ch_SameTeams.IsChecked())
	{
		Editor.ChosenCaption = BothListCaption;
		Editor.SetChosen(RedNames);
	}
	else
	{
		Editor.ChosenCaption = TeamListCaptions[ShownTeam];
		if (ShownTeam == 0)
			Editor.SetChosen(RedNames);
		else
			Editor.SetChosen(BlueNames);
	}
	TeamRow.SetEnabled(!ch_SameTeams.IsChecked());
}

function ChosenChanged(BC_WeaponListEditor Sender)
{
	local array<string> Names;

	Editor.GetChosen(Names);
	if (ch_SameTeams.IsChecked())
	{
		RedNames = Names;
		BlueNames = Names;
	}
	else if (ShownTeam == 0)
		RedNames = Names;
	else
		BlueNames = Names;
}

function TeamSwitched(BC_TabRow Sender, int Index)
{
	ShownTeam = Index;
	ShowTeam();
}

function InternalOnChange(GUIComponent Sender)
{
	if (Sender != ch_SameTeams || bLoading || TeamRow == None)
		return;
	if (ch_SameTeams.IsChecked())
	{
		if (ShownTeam == 0)
			BlueNames = RedNames;
		else
			RedNames = BlueNames;
	}
	ShowTeam();
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
	if (Key == 0x0D && State == 3)	// Enter
		return InternalOnClick(BDone);
	return false;
}

function bool InternalOnClick(GUIComponent Sender)
{
	local int i, k;
	local string S;

	if (Sender == BCancel)
		Controller.CloseMenu(true);
	else if (Sender == BDone)
	{
		class'Mut_ConflictLoadout'.default.LoadoutOption = co_LoadOpt.GetIndex();
		class'Mut_ConflictLoadout'.default.ConflictWeapons.length = 0;
		// every weapon and item, with the teams that have it
		for (i = 0; i < Editor.Catalogue.Length; i++)
		{
			if (Editor.Catalogue[i].bSection)
				continue;
			S = Editor.Catalogue[i].ClassName;
			k = class'Mut_ConflictLoadout'.default.ConflictWeapons.length;
			class'Mut_ConflictLoadout'.default.ConflictWeapons.length = k + 1;
			class'Mut_ConflictLoadout'.default.ConflictWeapons[k].ClassName = S;
			class'Mut_ConflictLoadout'.default.ConflictWeapons[k].bRed = class'ConfigTab_ConflictLoadout'.static.HasName(RedNames, S);
			class'Mut_ConflictLoadout'.default.ConflictWeapons[k].bBlue = class'ConfigTab_ConflictLoadout'.static.HasName(BlueNames, S);
		}
		class'Mut_ConflictLoadout'.static.StaticSaveConfig();
		Controller.CloseMenu(false);
	}
	return true;
}

defaultproperties
{
	Begin Object Class=GUIImage Name=BackImage
		Image=Texture'2K4Menus.NewControls.Display95'
		ImageStyle=ISTY_Stretched
		WinTop=0.100000
		WinLeft=0.050000
		WinWidth=0.900000
		WinHeight=0.800000
		RenderWeight=0.001000
	End Object
	MyBack=GUIImage'BallisticProV55.BallisticConflictWeaponMenuPro.BackImage'

	Begin Object Class=GUIHeader Name=DaBeegHeader
		bUseTextHeight=True
		Caption="Ballistic Conflict Team Weapons"
		WinTop=0.100000
		WinLeft=0.050000
		WinWidth=0.900000
		WinHeight=0.800000
	End Object
	MyHeader=GUIHeader'BallisticProV55.BallisticConflictWeaponMenuPro.DaBeegHeader'

	Begin Object Class=GUILabel Name=TeamLabel
		Caption="Weapons for:"
		TextColor=(B=255,G=255,R=255)
		WinTop=0.175000
		WinLeft=0.080000
		WinWidth=0.150000
		WinHeight=0.040000
	End Object
	l_Team=GUILabel'BallisticProV55.BallisticConflictWeaponMenuPro.TeamLabel'

	Begin Object Class=moCheckBox Name=SameTeamsCheck
		ComponentJustification=TXTA_Left
		CaptionWidth=0.900000
		Caption="Both teams use the same weapons"
		OnCreateComponent=SameTeamsCheck.InternalOnCreateComponent
		IniOption="@Internal"
		Hint="One list for both teams. Untick to give the teams different weapons."
		WinTop=0.178000
		WinLeft=0.540000
		WinWidth=0.380000
		WinHeight=0.035000
		OnChange=BallisticConflictWeaponMenuPro.InternalOnChange
	End Object
	ch_SameTeams=moCheckBox'BallisticProV55.BallisticConflictWeaponMenuPro.SameTeamsCheck'

	Begin Object Class=BC_WeaponListEditor Name=WeaponEditor
		WinTop=0.230000
		WinLeft=0.080000
		WinWidth=0.840000
		WinHeight=0.560000
		TabOrder=0
	End Object
	Editor=BC_WeaponListEditor'BallisticProV55.BallisticConflictWeaponMenuPro.WeaponEditor'

	Begin Object Class=moComboBox Name=LoadOptCombo
		Caption="Loadout Option"
		OnCreateComponent=LoadOptCombo.InternalOnCreateComponent
		IniOption="@Internal"
		IniDefault="High"
		Hint="Choose the type of loadout."
		WinTop=0.825000
		WinLeft=0.080000
		WinWidth=0.400000
		WinHeight=0.040000
		TabOrder=1
	End Object
	co_LoadOpt=moComboBox'BallisticProV55.BallisticConflictWeaponMenuPro.LoadOptCombo'

	Begin Object Class=GUIButton Name=DoneButton
		Caption="DONE"
		WinTop=0.825000
		WinLeft=0.660000
		WinWidth=0.120000
		TabOrder=2
		OnClick=BallisticConflictWeaponMenuPro.InternalOnClick
		OnKeyEvent=DoneButton.InternalOnKeyEvent
	End Object
	BDone=GUIButton'BallisticProV55.BallisticConflictWeaponMenuPro.DoneButton'

	Begin Object Class=GUIButton Name=CancelButton
		Caption="CANCEL"
		WinTop=0.825000
		WinLeft=0.800000
		WinWidth=0.120000
		TabOrder=3
		OnClick=BallisticConflictWeaponMenuPro.InternalOnClick
		OnKeyEvent=CancelButton.InternalOnKeyEvent
	End Object
	BCancel=GUIButton'BallisticProV55.BallisticConflictWeaponMenuPro.CancelButton'

	Headings(0)="Ballistic Weapons"
	Headings(1)="Items"
	Headings(2)="UT2004 Standard"
	Headings(3)="Other"
	TeamCaptions(0)="Red team"
	TeamCaptions(1)="Blue team"
	TeamListCaptions(0)="Red team's weapons"
	TeamListCaptions(1)="Blue team's weapons"
	BothListCaption="Both teams' weapons"
	bRenderWorld=True
	bAllowedAsLast=True
	OnKeyEvent=BallisticConflictWeaponMenuPro.InternalOnKeyEvent
}
