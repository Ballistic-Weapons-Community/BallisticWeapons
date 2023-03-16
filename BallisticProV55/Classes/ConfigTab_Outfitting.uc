//=============================================================================
// ConfigTab_Outfitting.
//
// This tab is used to configure loadout boxes for Ballistic Loadout mutator
// Includes:
// * A list of weapons in selected box
// * 5 loadout boxes
// * Weapon Name title
// * Weapon icon
// * Weapon description
// * List headings
// * Multi ticks
// * Other weapons tick
// * Startup showing a weapon
//
// Azarael edits:
// This tab also sets up Team Outfitting.
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ConfigTab_Outfitting extends ConfigTabBase config(BallisticProV55);

const NUM_BOXES=7;
const NUM_BOXES_TOTAL=21;

var config bool							bUseAllWeapons;

var automated GUIImage					Box_New, Box_WeapIcon, Pic_Weapon;
var automated GUILabel					l_NewList, l_WeapTitle;
var automated BC_GUICheckListMultiBox	lb_NewWeapons;
var automated GUIButton					BAddAll, BRemoveAll, BBox1, BBox2, BBox3, BBox4, BBox5, BBox6, BBox7;
var automated GUIScrollTextBox			lb_Desc;
var automated moCheckbox				ch_AllWeaps;
var automated moFloatEdit				fl_ChangeInterval;

struct LoadOutBox
{
	var array<string>	WeaponNames;
};

var LoadoutBox				Boxes[NUM_BOXES_TOTAL]; //DM, and the two teams
var localized string		BoxNames[NUM_BOXES];
var int						SelectedBox;
var() localized string 		Headings[12];

struct LOWeapInfo
{
	var string		ClassName;
	var string		Description;
	var Material	Icon;
	var IntBox		IconCoords;
};
var   array<LOWeapInfo> 	WeaponInfo;

function InitializeConfigTab()
{
	lb_NewWeapons.CheckList.OnClick = InternalOnClick;
	lb_NewWeapons.CheckList.OnRightClick = InternalOnRightClick;
	ch_AllWeaps.MyCheckBox.OnClick = InternalOnClick;

	ch_AllWeaps.MyCheckBox.SetChecked(bUseAllWeapons);
	fl_ChangeInterval.SetValue(class'ClientOutfittingInterface'.default.ChangeInterval);

	LoadList();

	LoadBoxesFromMutator();
	LoadBox(0);
}

//===========================================================================
// LoadList
//
// Loads weapons from standard cache then props from default cache, then inserts them 
// into the weapon list.
//===========================================================================
function LoadList()
{
	local int i, j;
	local array<CacheManager.WeaponRecord> Recs;
	local string s;
	local int Index[12];
	local bool OtherLoaded, MiscLoaded;
	local BC_WeaponInfoCache.WeaponInfo WI;

	lb_NewWeapons.CheckList.Add(Headings[0],,"MELEE",true);
	lb_NewWeapons.CheckList.Add(Headings[1],,"SIDEARM",true);
	lb_NewWeapons.CheckList.Add(Headings[2],,"SPREAD",true);
	lb_NewWeapons.CheckList.Add(Headings[3],,"SMG",true);
	lb_NewWeapons.CheckList.Add(Headings[4],,"AR",true);
	lb_NewWeapons.CheckList.Add(Headings[5],,"MG",true);
	lb_NewWeapons.CheckList.Add(Headings[6],,"SNIPER",true);
	lb_NewWeapons.CheckList.Add(Headings[7],,"HEAVY",true);
	lb_NewWeapons.CheckList.Add(Headings[8],,"SPECIAL",true);
	lb_NewWeapons.CheckList.Add(Headings[9],,"TRAPS",true);

	for (j=0;j<12;j++)
		Index[j] = j+1;

	WeaponInfo.length = 0;

	class'CacheManager'.static.GetWeaponList(Recs);
	for (i=0;i<Recs.Length;i++)
	{
		j = InStr(Recs[i].ClassName, ".");
		
		if (j != -1)
		{
			s = Left(Recs[i].ClassName, j);
			
			if (!class'BC_WeaponInfoCache'.static.IsValid(Recs[i].ClassName))
				continue;
				
			if (!bUseAllWeapons)
			{
				if (InStr(s,"Ballistic")==-1 && InStr(s,"BWBP")==-1 && InStr(s,"JunkWar")==-1 && InStr(s,"JWBP")==-1)
					continue;
			}
		}

		// Use the BW weapon cache system to get the info needed without loading the classes (huge optimization)
		WI = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(Recs[i].ClassName, j);
		if (j == -1)
			continue;

		j = WeaponInfo.length;
		WeaponInfo.length = j+1;
		WeaponInfo[j].Description = Recs[i].Description;
		WeaponInfo[j].ClassName = Recs[i].ClassName;
		if (WI.bIsBW)
		{
			WeaponInfo[j].Icon = WI.BigIconMaterial;
			WeaponInfo[j].IconCoords.X1 = -1;
			WeaponInfo[j].IconCoords.X2 = -1;
			WeaponInfo[j].IconCoords.Y1 = -1;
			WeaponInfo[j].IconCoords.Y2 = -1;
		}
		else
		{
			WeaponInfo[j].Icon = WI.SmallIconMaterial;
			WeaponInfo[j].IconCoords = WI.SmallIconCoords;
		}
		if (WI.ClassName != "")
		{
			if (WI.bIsBW)
			{
				if (WI.InventoryGroup > 0 && WI.InventoryGroup < 10)
				{
					lb_NewWeapons.CheckList.Insert(Index[WI.InventoryGroup-1], Recs[i].FriendlyName,, string(j));
					for (j=WI.InventoryGroup-1;j<12;j++)
						Index[j]++;
				}
				else if (WI.InventoryGroup == 0)
				{
					lb_NewWeapons.CheckList.Insert(Index[9], Recs[i].FriendlyName,, string(j));
					for (j=9;j<12;j++)
						Index[j]++;
				}
				else
				{
					if (!MiscLoaded)
					{
						MiscLoaded=true;
						lb_NewWeapons.CheckList.Add(Headings[10],,"MISC",true);
					}
					lb_NewWeapons.CheckList.Insert(Index[10], Recs[i].FriendlyName,, string(j));
					Index[10]++;
					Index[11]++;
				}
 			}
			else if (bUseAllWeapons)
			{
				if (!OtherLoaded)
				{
					OtherLoaded=true;
					lb_NewWeapons.CheckList.Add(Headings[11],,"OTHER",true);
				}
				lb_NewWeapons.CheckList.Insert(Index[11], Recs[i].FriendlyName,, string(j));
				Index[11]++;
			}
		}
	}
	class'BC_WeaponInfoCache'.static.EndSession();

	if ((lb_NewWeapons.CheckList.Index == 0 && lb_NewWeapons.CheckList.IsSection()) || lb_NewWeapons.CheckList.Index >= lb_NewWeapons.CheckList.ItemCount)
		lb_NewWeapons.CheckList.SetIndex(1);
}

//===========================================================================
// LoadBoxesFromMutator
//
// Copies over the loadout groups from the Loadout muts and purges anything from them which isn't
// in the WeaponInfo list (couldn't be loaded in cache.)
//===========================================================================
function LoadBoxesFromMutator ()
{
	local int i, j, k;
	
	//DM
	Boxes[0].WeaponNames = class'Mut_Outfitting'.default.LoadoutGroup0;
	Boxes[1].WeaponNames = class'Mut_Outfitting'.default.LoadoutGroup1;
	Boxes[2].WeaponNames = class'Mut_Outfitting'.default.LoadoutGroup2;
	Boxes[3].WeaponNames = class'Mut_Outfitting'.default.LoadoutGroup3;
	Boxes[4].WeaponNames = class'Mut_Outfitting'.default.LoadoutGroup4;
	Boxes[5].WeaponNames = class'Mut_Killstreak'.default.Streak1s;
	Boxes[6].WeaponNames = class'Mut_Killstreak'.default.Streak2s;
	//Red
	Boxes[7].WeaponNames = class'Mut_TeamOutfitting'.default.RedLoadoutGroup0;
	Boxes[8].WeaponNames = class'Mut_TeamOutfitting'.default.RedLoadoutGroup1;
	Boxes[9].WeaponNames = class'Mut_TeamOutfitting'.default.RedLoadoutGroup2;
	Boxes[10].WeaponNames = class'Mut_TeamOutfitting'.default.RedLoadoutGroup3;
	Boxes[11].WeaponNames = class'Mut_TeamOutfitting'.default.RedLoadoutGroup4;
	Boxes[12].WeaponNames = class'Mut_Killstreak'.default.Streak1s;
	Boxes[13].WeaponNames = class'Mut_Killstreak'.default.Streak2s;
	//Blue
	Boxes[14].WeaponNames = class'Mut_TeamOutfitting'.default.BlueLoadoutGroup0;
	Boxes[15].WeaponNames = class'Mut_TeamOutfitting'.default.BlueLoadoutGroup1;
	Boxes[16].WeaponNames = class'Mut_TeamOutfitting'.default.BlueLoadoutGroup2;
	Boxes[17].WeaponNames = class'Mut_TeamOutfitting'.default.BlueLoadoutGroup3;
	Boxes[18].WeaponNames = class'Mut_TeamOutfitting'.default.BlueLoadoutGroup4;
	Boxes[19].WeaponNames = class'Mut_Killstreak'.default.Streak1s;
	Boxes[20].WeaponNames = class'Mut_Killstreak'.default.Streak2s;
	
	// Get rid of things that are no longer around
	for(i=0;i<NUM_BOXES_TOTAL;i++)
		for (j=0;j<Boxes[i].WeaponNames.length;j++)
		{
			for (k=0;k<WeaponInfo.length;k++)
				if (Boxes[i].WeaponNames[j] ~= WeaponInfo[k].ClassName)
					break;
			if (k >= WeaponInfo.length)
			{
				Boxes[i].WeaponNames.Remove(j, 1);
				j--;
			}
		}

}

//===========================================================================
// Saves the weapon assignments to the mutator.
//===========================================================================
function SaveBoxesToMutator ()
{
	local int i;
	// An empty box must have at least one line otherwise the mutator defaults take over
	for(i=0;i<NUM_BOXES_TOTAL;i++)
		if (Boxes[i].WeaponNames.length < 1)
			Boxes[i].WeaponNames.length = 1;
	class'Mut_Outfitting'.default.LoadoutGroup0 = Boxes[0].WeaponNames;
	class'Mut_Outfitting'.default.LoadoutGroup1 = Boxes[1].WeaponNames;
	class'Mut_Outfitting'.default.LoadoutGroup2 = Boxes[2].WeaponNames;
	class'Mut_Outfitting'.default.LoadoutGroup3 = Boxes[3].WeaponNames;
	class'Mut_Outfitting'.default.LoadoutGroup4 = Boxes[4].WeaponNames;
	class'Mut_Killstreak'.default.Streak1s = Boxes[5].WeaponNames;
	class'Mut_Killstreak'.default.Streak2s = Boxes[6].WeaponNames;
	
	class'Mut_TeamOutfitting'.default.RedLoadoutGroup0 = Boxes[7].WeaponNames;
	class'Mut_TeamOutfitting'.default.RedLoadoutGroup1 = Boxes[8].WeaponNames;
	class'Mut_TeamOutfitting'.default.RedLoadoutGroup2 = Boxes[9].WeaponNames;
	class'Mut_TeamOutfitting'.default.RedLoadoutGroup3 = Boxes[10].WeaponNames;
	class'Mut_TeamOutfitting'.default.RedLoadoutGroup4 = Boxes[11].WeaponNames;
	//class'Mut_TeamOutfitting'.default.RedLoadoutGroup5 = Boxes[12].WeaponNames;
	//class'Mut_TeamOutfitting'.default.RedLoadoutGroup6 = Boxes[13].WeaponNames;
	
	class'Mut_TeamOutfitting'.default.BlueLoadoutGroup0 = Boxes[14].WeaponNames;
	class'Mut_TeamOutfitting'.default.BlueLoadoutGroup1 = Boxes[15].WeaponNames;
	class'Mut_TeamOutfitting'.default.BlueLoadoutGroup2 = Boxes[16].WeaponNames;
	class'Mut_TeamOutfitting'.default.BlueLoadoutGroup3 = Boxes[17].WeaponNames;
	class'Mut_TeamOutfitting'.default.BlueLoadoutGroup4 = Boxes[18].WeaponNames;
	//class'Mut_TeamOutfitting'.default.BlueLoadoutGroup5 = Boxes[19].WeaponNames;
	//class'Mut_TeamOutfitting'.default.BlueLoadoutGroup6 = Boxes[20].WeaponNames;
	
	class'Mut_Outfitting'.static.StaticSaveConfig();
	class'Mut_TeamOutfitting'.static.StaticSaveConfig();
	class'Mut_Killstreak'.static.StaticSaveConfig();
}

//===========================================================================
// LoadBox
//===========================================================================
function LoadBox (int BoxNum)
{
	local int i, j, k;
	local int WatchedSection[3];
	local BC_GUICheckListMulti.CheckStruct Empty;
	
	SelectedBox = BoxNum;
	for (i=0;i<3;i++)
		WatchedSection[i] = -1;
	
	// Iterates through the weapons in the weapon list. Clear all checks.
	for (i=0;i<lb_NewWeapons.CheckList.Elements.length;i++)
	{
		lb_NewWeapons.CheckList.CheckStore[i] = Empty; //necessary, apparently
		lb_NewWeapons.CheckList.SetChecked(i, 0, false);
		lb_NewWeapons.CheckList.SetChecked(i, 1, false);
		lb_NewWeapons.CheckList.SetChecked(i, 2, false);
		
		// If we've reached a new section and all the weapons were checked for
		// the previous one in any of the categories, check the last section in the same one.
		if (lb_NewWeapons.CheckList.Elements[i].bSection)
		{
			for(j=0; j < 3; j++)
			{
				if (WatchedSection[j] > -1 && i - WatchedSection[j] > 1)
					lb_NewWeapons.CheckList.SetChecked(WatchedSection[j], j, true);
				WatchedSection[j] = i;
			}
			continue;
		}
		
		// If any of the weapons in the mutator's list matches the current weapon in the list, check.
		// Repeat for subsequent mutators
		for (j=0; j < 3; j++)
		{
			for (k=0;k<Boxes[BoxNum + j*NUM_BOXES].WeaponNames.length;k++)
			{
				if (Boxes[BoxNum + j*NUM_BOXES].WeaponNames[k] ~= WeaponInfo[int(lb_NewWeapons.CheckList.Elements[i].ExtraStrData)].ClassName)
				{
					lb_NewWeapons.CheckList.SetChecked(i, j, true);
					break;
				}
			}
			//Not in list, section header can't be checked now.
			if (k >= Boxes[BoxNum + j*NUM_BOXES].WeaponNames.length)
				WatchedSection[j] = -1;
		}
	}
	
	//Finished, handle last section headers.
	for (i = 0; i < 3; i++)
	{
		if (WatchedSection[i] > -1 && WatchedSection[i] != lb_NewWeapons.CheckList.Elements.length-1)
			lb_NewWeapons.CheckList.SetChecked(WatchedSection[i], i, true);
	}

	//Set list name accordingly
	l_NewList.Caption = BoxNames[BoxNum];
	
	//Set current index to first actual weapon.
	if (!lb_NewWeapons.CheckList.IsValid())
	{
		for (i=0;i<lb_NewWeapons.CheckList.ItemCount;i++)
			if (!lb_NewWeapons.CheckList.Elements[i].bSection)
			{
				lb_NewWeapons.CheckList.SetIndex(i);
				break;
			}
		DisplayWeapon();
	}
	else if (!bInitialized)
		DisplayWeapon();
}

//===========================================================================
// DisplayWeapon
// Updates the weapon information in the right sidebar
//===========================================================================
function DisplayWeapon ()
{
	local int i;

	if (lb_NewWeapons.List.IsSection())
		return;
	l_WeapTitle.Caption = lb_NewWeapons.List.Get();

	i = int(lb_NewWeapons.List.GetExtra());
	Pic_Weapon.Image = WeaponInfo[i].Icon;
	Pic_Weapon.X1 	 = WeaponInfo[i].IconCoords.X1;
	Pic_Weapon.X2	 = WeaponInfo[i].IconCoords.X2;
	Pic_Weapon.Y1 	 = WeaponInfo[i].IconCoords.Y1;
	Pic_Weapon.Y2	 = WeaponInfo[i].IconCoords.Y2;
	lb_Desc.SetContent(WeaponInfo[i].Description);
}

//===========================================================================
// SectionCheck
//
// Called when a section header is checked.
// Sets all checkboxes up until the next section, in the same column, to its own value.
//===========================================================================
function SectionCheck (bool bChecked, int Index, byte Column)
{
	local int i, j;
	for (j=Index+1;j<lb_NewWeapons.CheckList.Elements.length;j++)
	{
		if (lb_NewWeapons.CheckList.Elements[j].bSection)
			return;

		lb_NewWeapons.CheckList.SetChecked(j, Column, bChecked);

		if (bChecked)
		{
			for (i=0;i<Boxes[SelectedBox + Column * NUM_BOXES].WeaponNames.length;i++)
				if (Boxes[SelectedBox + Column * NUM_BOXES].WeaponNames[i] ~= WeaponInfo[int(lb_NewWeapons.CheckList.Elements[j].ExtraStrData)].ClassName)
					break;
			if (i >= Boxes[SelectedBox + Column * NUM_BOXES].WeaponNames.length)
				Boxes[SelectedBox + Column * NUM_BOXES].WeaponNames[Boxes[SelectedBox + Column * NUM_BOXES].WeaponNames.length] = WeaponInfo[int(lb_NewWeapons.CheckList.Elements[j].ExtraStrData)].ClassName;
		}
		else
		{
			for (i=0;i<Boxes[SelectedBox + Column * NUM_BOXES].WeaponNames.length;i++)
				if (Boxes[SelectedBox + Column * NUM_BOXES].WeaponNames[i] ~= WeaponInfo[int(lb_NewWeapons.CheckList.Elements[j].ExtraStrData)].ClassName)
				{
					Boxes[SelectedBox + Column * NUM_BOXES].WeaponNames.Remove(i, 1);
					i--;
				}
		}
	}
}

//===========================================================================
// InternalOnClick
//
// Handles clicks for components.
//===========================================================================
function bool InternalOnClick(GUIComponent Sender)
{
	local int i, j;
	local int LastCheck;
	local byte LastColumn;

	if (Sender == lb_NewWeapons.CheckList)	// Weapons list
	{
		lb_NewWeapons.CheckList.InternalOnClick(Sender);
		
		if (lb_NewWeapons.CheckList.LastClickWasCheck)
		{
			LastCheck = lb_NewWeapons.CheckList.LastCheckChanged;
			LastColumn = lb_NewWeapons.CheckList.LastColumnChanged;
			//section check
			if (lb_NewWeapons.CheckList.Elements[LastCheck].bSection)
				SectionCheck(	lb_NewWeapons.CheckList.CheckStore[LastCheck].Checks[LastColumn] > 0, LastCheck, LastColumn);
			else
			{
				//add
				if (lb_NewWeapons.CheckList.CheckStore[LastCheck].Checks[LastColumn] > 0)
				{

					for (j=0;j<Boxes[SelectedBox + LastColumn*NUM_BOXES].WeaponNames.length;j++)
						if (Boxes[SelectedBox + LastColumn*NUM_BOXES].WeaponNames[j] ~= WeaponInfo[int(lb_NewWeapons.List.GetExtraAtIndex(LastCheck))].ClassName)
							break;
					if (j >= Boxes[SelectedBox + LastColumn*NUM_BOXES].WeaponNames.length)
						Boxes[SelectedBox + LastColumn*NUM_BOXES].WeaponNames[Boxes[SelectedBox + LastColumn*NUM_BOXES].WeaponNames.length] = WeaponInfo[int(lb_NewWeapons.List.GetExtraAtIndex(LastCheck))].ClassName;
				}
				//remove
				else
				{
					for (j=0;j<Boxes[SelectedBox + LastColumn*NUM_BOXES].WeaponNames.length;j++)
						if (Boxes[SelectedBox + LastColumn*NUM_BOXES].WeaponNames[j] ~= WeaponInfo[int(lb_NewWeapons.List.GetExtraAtIndex(LastCheck))].ClassName)
						{
							Boxes[SelectedBox + LastColumn*NUM_BOXES].WeaponNames.Remove(j, 1);
							j--;
						}
				}
			}
		}
		else
			DisplayWeapon();
	}
	
	// Fill
	else if (Sender == BAddAll)				
	{
		for(i=0;i<3;i++)
		{
			Boxes[SelectedBox + i*NUM_BOXES].WeaponNames.length = 0;
			for (j=0;j<lb_NewWeapons.CheckList.Elements.length;j++)
			{
				lb_NewWeapons.CheckList.SetChecked(j, i, true);
				if (!lb_NewWeapons.CheckList.Elements[j].bSection)
					Boxes[SelectedBox + i*NUM_BOXES].WeaponNames[Boxes[SelectedBox + i*NUM_BOXES].WeaponNames.length] = WeaponInfo[int(lb_NewWeapons.CheckList.Elements[j].ExtraStrData)].ClassName;
			}
		}
	}
	
	// Empty
	else if (Sender == BRemoveAll)			
	{
		for(i=0;i<3;i++)
		{
			Boxes[SelectedBox + i*NUM_BOXES].WeaponNames.length = 0;
			for (j=0;j<lb_NewWeapons.CheckList.Elements.length;j++)
				lb_NewWeapons.CheckList.SetChecked(j, i, false); //check none
		}
	}
	else if (Sender == BBox1)
		LoadBox(0);
	else if (Sender == BBox2)
		LoadBox(1);
	else if (Sender == BBox3)
		LoadBox(2);
	else if (Sender == BBox4)
		LoadBox(3);
	else if (Sender == BBox5)
		LoadBox(4);
	else if (Sender == BBox6)
		LoadBox(5);
	else if (Sender == BBox7)
		LoadBox(6);
	else if (Sender == ch_AllWeaps.MyCheckBox)	// All weapons checkbox
	{
		ch_AllWeaps.MyCheckBox.InternalOnClick(Sender);
		bUseAllWeapons = ch_AllWeaps.IsChecked();
		lb_NewWeapons.CheckList.Clear();
		lb_NewWeapons.CheckList.CheckStore.Length = 0;
		LoadList();
		LoadBox(SelectedBox);
	}
	return true;
}

function bool InternalOnRightClick(GUIComponent Sender)
{
	if (Sender == lb_NewWeapons.CheckList)	// Weapons list
	{
		lb_NewWeapons.CheckList.InternalOnClick(Sender);
		if (!lb_NewWeapons.CheckList.IsSection())
			DisplayWeapon();
	}
	return true;
}

function LoadSettings()
{
	LoadBoxesFromMutator();
	LoadBox(SelectedBox);
}

function SaveSettings()
{
	if (!bInitialized)
		return;
	class'ClientOutfittingInterface'.default.ChangeInterval = fl_ChangeInterval.GetValue();
	class'ClientOutfittingInterface'.static.StaticSaveConfig();
	SaveBoxesToMutator();
	SaveConfig();
}

static function String GetHeading (int i)
{
	if (i == 0)
		return default.Headings[9];
	return default.Headings[i-1];
}

//INCOMPLETE!
function DefaultSettings()
{
	class'Mut_Outfitting'.static.ResetConfig("LoadoutGroup0");
	class'Mut_Outfitting'.static.ResetConfig("LoadoutGroup1");
	class'Mut_Outfitting'.static.ResetConfig("LoadoutGroup2");
	class'Mut_Outfitting'.static.ResetConfig("LoadoutGroup3");
	class'Mut_Outfitting'.static.ResetConfig("LoadoutGroup4");

	class'Mut_Outfitting'.static.ResetConfig("LoadoutGroup5");
	class'Mut_Outfitting'.static.ResetConfig("LoadoutGroup6");
	
	class'Mut_Killstreak'.static.ResetConfig("Streak1s");
	class'Mut_Killstreak'.static.ResetConfig("Streak2s");
	LoadBoxesFromMutator();
	LoadBox(SelectedBox);
}

defaultproperties
{
     Begin Object Class=GUIImage Name=Box_NewImg
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.050000
         WinLeft=0.525000
         WinWidth=0.450000
         WinHeight=0.800000
         RenderWeight=0.002000
     End Object
     Box_New=GUIImage'BallisticProV55.ConfigTab_Outfitting.Box_NewImg'

     Begin Object Class=GUIImage Name=Box_WeapIconImg
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.050000
         WinLeft=0.025000
         WinWidth=0.450000
         WinHeight=0.800000
         RenderWeight=0.002000
     End Object
     Box_WeapIcon=GUIImage'BallisticProV55.ConfigTab_Outfitting.Box_WeapIconImg'

     Begin Object Class=GUIImage Name=Pic_WeaponImg
         ImageStyle=ISTY_Scaled
         WinTop=0.090000
         WinLeft=0.040000
         WinWidth=0.420000
         WinHeight=0.279000
         RenderWeight=0.004000
     End Object
     Pic_Weapon=GUIImage'BallisticProV55.ConfigTab_Outfitting.Pic_WeaponImg'

     Begin Object Class=GUILabel Name=l_NewListlabel
         Caption="Weapons"
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255,R=255)
         WinTop=0.050000
         WinLeft=0.525000
         WinWidth=0.450000
         WinHeight=0.050000
     End Object
     l_NewList=GUILabel'BallisticProV55.ConfigTab_Outfitting.l_NewListlabel'

     Begin Object Class=GUILabel Name=l_WeapTitlelabel
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255,R=255)
         WinTop=0.050000
         WinLeft=0.035000
         WinWidth=0.430000
         WinHeight=0.050000
     End Object
     l_WeapTitle=GUILabel'BallisticProV55.ConfigTab_Outfitting.l_WeapTitlelabel'

     Begin Object Class=BC_GUICheckListMultiBox Name=lb_NewWeaponsList
         bVisibleWhenEmpty=True
         OnCreateComponent=lb_NewWeaponsList.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Tick the weapons that you want in the chosen loadout box."
         WinTop=0.100000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.740000
         RenderWeight=0.520000
         TabOrder=1
     End Object
     lb_NewWeapons=BC_GUICheckListMultiBox'BallisticProV55.ConfigTab_Outfitting.lb_NewWeaponsList'

     Begin Object Class=GUIButton Name=AddAllButton
         Caption="ALL"
         Hint="Checks all to replace the original weapon currently selected"
         WinTop=0.850000
         WinLeft=0.580000
         WinWidth=0.150000
         TabOrder=0
         OnClick=ConfigTab_Outfitting.InternalOnClick
         OnKeyEvent=AddAllButton.InternalOnKeyEvent
     End Object
     BAddAll=GUIButton'BallisticProV55.ConfigTab_Outfitting.AddAllButton'

     Begin Object Class=GUIButton Name=RemoveAllButton
         Caption="NONE"
         Hint="Unchecks all to replace the original weapon currently selected"
         WinTop=0.850000
         WinLeft=0.780000
         WinWidth=0.150000
         TabOrder=0
         OnClick=ConfigTab_Outfitting.InternalOnClick
         OnKeyEvent=RemoveAllButton.InternalOnKeyEvent
     End Object
     BRemoveAll=GUIButton'BallisticProV55.ConfigTab_Outfitting.RemoveAllButton'

     Begin Object Class=GUIButton Name=BBox1Button
         Caption="Melee"
         Hint="View the list of weapons in the 'Melee' box"
         WinTop=0.940000
         WinLeft=0.025000
         WinWidth=0.150000
         TabOrder=0
         OnClick=ConfigTab_Outfitting.InternalOnClick
         OnKeyEvent=BBox1Button.InternalOnKeyEvent
     End Object
     BBox1=GUIButton'BallisticProV55.ConfigTab_Outfitting.BBox1Button'

     Begin Object Class=GUIButton Name=BBox2Button
         Caption="Sidearm"
         Hint="View the list of weapons in the 'Sidearm' box"
         WinTop=0.940000
         WinLeft=0.225000
         WinWidth=0.150000
         TabOrder=0
         OnClick=ConfigTab_Outfitting.InternalOnClick
         OnKeyEvent=BBox2Button.InternalOnKeyEvent
     End Object
     BBox2=GUIButton'BallisticProV55.ConfigTab_Outfitting.BBox2Button'

     Begin Object Class=GUIButton Name=BBox3Button
         Caption="Primary"
         Hint="View the list of weapons in the 'Primary' box"
         WinTop=0.940000
         WinLeft=0.425000
         WinWidth=0.150000
         TabOrder=0
         OnClick=ConfigTab_Outfitting.InternalOnClick
         OnKeyEvent=BBox3Button.InternalOnKeyEvent
     End Object
     BBox3=GUIButton'BallisticProV55.ConfigTab_Outfitting.BBox3Button'

     Begin Object Class=GUIButton Name=BBox4Button
         Caption="Secondary"
         Hint="View the list of weapons in the 'Secondary' box"
         WinTop=0.940000
         WinLeft=0.625000
         WinWidth=0.150000
         TabOrder=0
         OnClick=ConfigTab_Outfitting.InternalOnClick
         OnKeyEvent=BBox4Button.InternalOnKeyEvent
     End Object
     BBox4=GUIButton'BallisticProV55.ConfigTab_Outfitting.BBox4Button'

     Begin Object Class=GUIButton Name=BBox5Button
         Caption="Grenade"
         Hint="View the list of weapons in the 'Grenade' box"
         WinTop=0.940000
         WinLeft=0.825000
         WinWidth=0.150000
         TabOrder=0
         OnClick=ConfigTab_Outfitting.InternalOnClick
         OnKeyEvent=BBox5Button.InternalOnKeyEvent
     End Object
     BBox5=GUIButton'BallisticProV55.ConfigTab_Outfitting.BBox5Button'

     Begin Object Class=GUIButton Name=BBox6Button
         Caption="Streak 1"
         Hint="View the list of weapons in the 'Streak 1' box"
         WinTop=0.980000
         WinLeft=0.225000
         WinWidth=0.150000
         TabOrder=0
         OnClick=ConfigTab_Outfitting.InternalOnClick
         OnKeyEvent=BBox6Button.InternalOnKeyEvent
     End Object
     BBox6=GUIButton'BallisticProV55.ConfigTab_Outfitting.BBox6Button'

     Begin Object Class=GUIButton Name=BBox7Button
         Caption="Streak 2"
         Hint="View the list of weapons in the 'Streak 2' box"
         WinTop=0.980000
         WinLeft=0.625000
         WinWidth=0.150000
         TabOrder=0
         OnClick=ConfigTab_Outfitting.InternalOnClick
         OnKeyEvent=BBox7Button.InternalOnKeyEvent
     End Object
     BBox7=GUIButton'BallisticProV55.ConfigTab_Outfitting.BBox7Button'

     Begin Object Class=GUIScrollTextBox Name=WeaponDescription
         CharDelay=0.001500
         EOLDelay=0.250000
         bVisibleWhenEmpty=True
         OnCreateComponent=WeaponDescription.InternalOnCreateComponent
         FontScale=FNS_Small
         WinTop=0.370000
         WinLeft=0.040000
         WinWidth=0.420000
         WinHeight=0.450000
         RenderWeight=0.510000
         TabOrder=0
         bAcceptsInput=False
         bNeverFocus=True
     End Object
     lb_Desc=GUIScrollTextBox'BallisticProV55.ConfigTab_Outfitting.WeaponDescription'

     Begin Object Class=moCheckBox Name=ch_AllWeapsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Use All Weapons"
         OnCreateComponent=ch_AllWeapsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable non BW weapons in the list."
         WinTop=0.850000
         WinLeft=0.025000
         WinWidth=0.450000
         WinHeight=0.040000
     End Object
     ch_AllWeaps=moCheckBox'BallisticProV55.ConfigTab_Outfitting.ch_AllWeapsCheck'

     Begin Object Class=moFloatEdit Name=fl_ChangeIntervalFloat
         MinValue=0.000000
         MaxValue=600.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.800000
         Caption="Loadout Change Interval"
         OnCreateComponent=fl_ChangeIntervalFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Time which must pass before you can change your weapons with Loadout while still alive."
         WinTop=0.900000
         WinLeft=0.025000
         WinWidth=0.450000
         WinHeight=0.040000
     End Object
     fl_ChangeInterval=moFloatEdit'BallisticProV55.ConfigTab_Outfitting.fl_ChangeIntervalFloat'

     BoxNames(0)="Melee"
     BoxNames(1)="Sidearm"
     BoxNames(2)="Primary"
     BoxNames(3)="Secondary"
     BoxNames(4)="Grenade"
	 Headings(0)="Melee"
     Headings(1)="Sidearms"
     Headings(2)="Sub Machineguns"
     Headings(3)="Assault Rifles"
     Headings(4)="Energy Weapons"
     Headings(5)="Heavy Machineguns"
     Headings(6)="Shotguns"
     Headings(7)="Ordnance"
     Headings(8)="Sniper Rifles"
     Headings(9)="Grenades"
     Headings(10)="Miscellaneous"
     Headings(11)="Non-BW"
}
