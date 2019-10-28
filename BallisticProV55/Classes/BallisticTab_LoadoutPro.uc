//=============================================================================
// BallisticTab_LoadoutPro.
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
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticTab_LoadoutPro extends UT2K4TabPanel config(BallisticProV55) DependsOn(Mut_Loadout);

var BallisticConfigMenuPro		p_Anchor;
var bool					bInitialized;
var config bool				bUseAllWeapons;

var automated GUIImage				Box_New, Box_WeapIcon, Pic_Weapon;
var automated GUILabel				l_NewList, l_WeapTitle;
var automated BC_GUICheckListBox	lb_NewWeapons;
var automated GUIButton				BAddAll, BRemoveAll, BBox1, BBox2, BBox3, BBox4, BBox5;
var automated moCheckbox			ch_AllWeaps;
var automated moFloatEdit			fl_RequiredTime, fl_RequiredFrags, fl_RequiredEfficiency, fl_RequiredDmgRate, fl_RequiredSnprEff, fl_RequiredStgnEff, fl_RequiredHzrdEff;

struct LoadOutBox
{
	var array<string>	WeaponNames;
};
var LoadoutBox	Boxes[5];
var localized string		BoxNames[5];
var int			SelectedBox;

var() localized string Headings[12];

struct LOWeapInfo
{
	var string		ClassName;
	var string		Description;
	var Material	Icon;
	var IntBox		IconCoords;

	var float		ReqTime;
	var float		ReqFrags;
	var float		ReqEff;
	var float		ReqDmgRate;
	var float		ReqSnprEff;
	var float		ReqStgnEff;
	var float		ReqHzrdEff;
};
var   array<LOWeapInfo> WeaponInfo;

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

	lb_NewWeapons.CheckList.OnClick = InternalOnClick;
	lb_NewWeapons.CheckList.OnRightClick = InternalOnRightClick;
	ch_AllWeaps.MyCheckBox.OnClick = InternalOnClick;

	ch_AllWeaps.MyCheckBox.SetChecked(bUseAllWeapons);

	LoadList();

	LoadBoxesFromMutator();
	LoadBox(0);
	bInitialized = true;
}

function LoadList()
{
	local int i, j, k;
//	local class<Weapon> Weap;
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
//	lb_NewWeapons.CheckList.Add(Headings[10],,"MISC",true);
//	lb_NewWeapons.CheckList.Add(Headings[11],,"OTHER",true);
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
		for (k=0;k<class'Mut_Loadout'.default.Items.length;k++)
		{
			if (class'Mut_Loadout'.default.Items[k].ItemName ~= Recs[i].ClassName)
			{
				WeaponInfo[j].ReqTime = class'Mut_Loadout'.default.Items[k].Requirements.MatchTime;
				WeaponInfo[j].ReqFrags = class'Mut_Loadout'.default.Items[k].Requirements.Frags;
				WeaponInfo[j].ReqEff = class'Mut_Loadout'.default.Items[k].Requirements.Efficiency;
				WeaponInfo[j].ReqDmgRate = class'Mut_Loadout'.default.Items[k].Requirements.DamageRate;
				WeaponInfo[j].ReqSnprEff = class'Mut_Loadout'.default.Items[k].Requirements.SniperEff;
				WeaponInfo[j].ReqStgnEff = class'Mut_Loadout'.default.Items[k].Requirements.ShotgunEff;
				WeaponInfo[j].ReqHzrdEff = class'Mut_Loadout'.default.Items[k].Requirements.HazardEff;
				break;
			}
		}
		if (k >= class'Mut_Loadout'.default.Items.length && WI.bIsBW)
		{
			SetDefaultRequirements(Recs[i].ClassName, j);
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
			else
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

function bool SetDefaultRequirements(string ClassName, int Index)
{
	local class<BallisticWeapon> BW;
	local string s;
	local array<string> RS;

	BW = class<BallisticWeapon>( DynamicLoadObject(ClassName, class'class') );
	if (BW == None)
		return false;

	s = BW.static.StaticGetSpecialInfo('EvoDefs');
	if (s == "")
		return false;
	Split(s, ";", RS);
	switch (RS.Length-1)
	{
		case 6:	WeaponInfo[Index].ReqHzrdEff	= float(RS[6]);
		case 5:	WeaponInfo[Index].ReqStgnEff	= float(RS[5]);
		case 4:	WeaponInfo[Index].ReqSnprEff	= float(RS[4]);
		case 3:	WeaponInfo[Index].ReqDmgRate	= float(RS[3]);
		case 2:	WeaponInfo[Index].ReqEff		= float(RS[2]);
		case 1:	WeaponInfo[Index].ReqFrags		= float(RS[1]);
		case 0:	WeaponInfo[Index].ReqTime		= float(RS[0]);
	}
	return true;
}

function LoadBoxesFromMutator ()
{
	local int i, j, k;

	for (i=0;i<class'Mut_Loadout'.default.Items.length;i++)
		for (j=0;j<5;j++)
			if ((class'Mut_Loadout'.default.Items[i].Groups & (1<<j)) > 0)
				Boxes[j].WeaponNames[Boxes[j].WeaponNames.length] = class'Mut_Loadout'.default.Items[i].ItemName;

	// Get rid of things that are no longer around
	for(i=0;i<5;i++)
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
function SaveBoxesToMutator ()
{
	local int i, j, k, l, Groups;

	// An empty box must have at least one line otherwise the mutator defaults take over
	for(i=0;i<5;i++)
		if (Boxes[i].WeaponNames.length < 1)
			Boxes[i].WeaponNames.length = 1;

//	class'Mut_Loadout'.default.Items.length = 0;
	for (i=0;i<WeaponInfo.length;i++)
	{
		if (WeaponInfo[i].ClassName == "")
			continue;
		for (j=0;j<5;j++)
		{
			for (k=0;k<Boxes[j].WeaponNames.length;k++)
			{
				if (Boxes[j].WeaponNames[k] ~= WeaponInfo[i].ClassName)
				{
					Groups = Groups | (1<<j);
					break;
				}
			}
		}
		for (l=0;l<class'Mut_Loadout'.default.Items.length;l++)
			if (class'Mut_Loadout'.default.Items[l].ItemName ~= WeaponInfo[i].ClassName)
				break;
//		if (Groups > 0)
//		{
		if (l >= class'Mut_Loadout'.default.Items.length)
			class'Mut_Loadout'.default.Items.length = l + 1;
		class'Mut_Loadout'.default.Items[l].ItemName = WeaponInfo[i].ClassName;
		class'Mut_Loadout'.default.Items[l].Groups = Groups;
		class'Mut_Loadout'.default.Items[l].Requirements.MatchTime = WeaponInfo[i].ReqTime;
		class'Mut_Loadout'.default.Items[l].Requirements.Frags = WeaponInfo[i].ReqFrags;
		class'Mut_Loadout'.default.Items[l].Requirements.Efficiency = WeaponInfo[i].ReqEff;
		class'Mut_Loadout'.default.Items[l].Requirements.DamageRate = WeaponInfo[i].ReqDmgRate;
		class'Mut_Loadout'.default.Items[l].Requirements.SniperEff	= WeaponInfo[i].ReqSnprEff;
		class'Mut_Loadout'.default.Items[l].Requirements.ShotgunEff = WeaponInfo[i].ReqStgnEff;
		class'Mut_Loadout'.default.Items[l].Requirements.HazardEff 	= WeaponInfo[i].ReqHzrdEff;
//		}
		Groups = 0;
	}
	class'Mut_Loadout'.static.StaticSaveConfig();
}

function LoadBox (int BoxNum)
{
	local int i, j, WatchedSection;

	SelectedBox = BoxNum;
	WatchedSection = -1;
	for (i=0;i<lb_NewWeapons.CheckList.Elements.length;i++)
	{
		lb_NewWeapons.CheckList.SetChecked(i, false);
		if (lb_NewWeapons.CheckList.Elements[i].bSection)
		{
			if (WatchedSection > -1 && i - WatchedSection > 1)
				lb_NewWeapons.CheckList.SetChecked(WatchedSection, true);
			WatchedSection = i;
			continue;
		}
		for (j=0;j<Boxes[BoxNum].WeaponNames.length;j++)
		{
			if (Boxes[BoxNum].WeaponNames[j] ~= WeaponInfo[int(lb_NewWeapons.CheckList.Elements[i].ExtraStrData)].ClassName)
//			if (Boxes[BoxNum].WeaponNames[j] ~= lb_NewWeapons.CheckList.Elements[i].ExtraStrData)
			{
				lb_NewWeapons.CheckList.SetChecked(i, true);
				break;
			}
		}
		if (j >= Boxes[BoxNum].WeaponNames.length)
			WatchedSection = -1;
	}
	if (WatchedSection > -1 && WatchedSection != lb_NewWeapons.CheckList.Elements.length-1)
		lb_NewWeapons.CheckList.SetChecked(WatchedSection, true);

	if (!lb_NewWeapons.List.IsSection() && bInitialized)
	{
		i = int(lb_NewWeapons.List.GetExtra());

		WeaponInfo[i].ReqTime = fl_RequiredTime.GetValue();
		WeaponInfo[i].ReqFrags = fl_RequiredFrags.GetValue();
		WeaponInfo[i].ReqEff = fl_RequiredEfficiency.GetValue();
		WeaponInfo[i].ReqDmgRate = fl_RequiredDmgRate.GetValue();
		WeaponInfo[i].ReqSnprEff = fl_RequiredSnprEff.GetValue();
		WeaponInfo[i].ReqStgnEff = fl_RequiredStgnEff.GetValue();
		WeaponInfo[i].ReqHzrdEff = fl_RequiredHzrdEff.GetValue();
	}

	l_NewList.Caption = BoxNames[BoxNum];
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

	fl_RequiredTime.SetValue(WeaponInfo[i].ReqTime);
	fl_RequiredFrags.SetValue(WeaponInfo[i].ReqFrags);
	fl_RequiredEfficiency.SetValue(WeaponInfo[i].ReqEff);
	fl_RequiredDmgRate.SetValue(WeaponInfo[i].ReqDmgRate);
	fl_RequiredSnprEff.SetValue(WeaponInfo[i].ReqSnprEff);
	fl_RequiredStgnEff.SetValue(WeaponInfo[i].ReqStgnEff);
	fl_RequiredHzrdEff.SetValue(WeaponInfo[i].ReqHzrdEff);
}

function SectionCheck (bool bChecked, int Index)
{
	local int i, j;
	for (j=Index+1;j<lb_NewWeapons.CheckList.Elements.length;j++)
	{
		if (lb_NewWeapons.CheckList.Elements[j].bSection)
			return;

		lb_NewWeapons.CheckList.SetChecked(j, bChecked);
		if (bChecked)
		{
			for (i=0;i<Boxes[SelectedBox].WeaponNames.length;i++)
				if (Boxes[SelectedBox].WeaponNames[i] ~= WeaponInfo[int(lb_NewWeapons.CheckList.Elements[j].ExtraStrData)].ClassName)
					break;
			if (i >= Boxes[SelectedBox].WeaponNames.length)
				Boxes[SelectedBox].WeaponNames[Boxes[SelectedBox].WeaponNames.length] = WeaponInfo[int(lb_NewWeapons.CheckList.Elements[j].ExtraStrData)].ClassName;
		}
		else
		{
			for (i=0;i<Boxes[SelectedBox].WeaponNames.length;i++)
				if (Boxes[SelectedBox].WeaponNames[i] ~= WeaponInfo[int(lb_NewWeapons.CheckList.Elements[j].ExtraStrData)].ClassName)
				{
					Boxes[SelectedBox].WeaponNames.Remove(i, 1);
					i--;
				}
		}
	}
}

function bool InternalOnClick(GUIComponent Sender)
{
	local int i, j;

	if (Sender == lb_NewWeapons.CheckList)	// Weapons list
	{
		if (!lb_NewWeapons.List.IsSection())
		{
			i = int(lb_NewWeapons.List.GetExtra());

			WeaponInfo[i].ReqTime = fl_RequiredTime.GetValue();
			WeaponInfo[i].ReqFrags = fl_RequiredFrags.GetValue();
			WeaponInfo[i].ReqEff = fl_RequiredEfficiency.GetValue();
			WeaponInfo[i].ReqDmgRate = fl_RequiredDmgRate.GetValue();
			WeaponInfo[i].ReqSnprEff = fl_RequiredSnprEff.GetValue();
			WeaponInfo[i].ReqStgnEff = fl_RequiredStgnEff.GetValue();
			WeaponInfo[i].ReqHzrdEff = fl_RequiredHzrdEff.GetValue();
		}

		lb_NewWeapons.CheckList.InternalOnClick(Sender);
//		lb_NewWeapons.CheckList.ToggleChecked(lb_NewWeapons.CheckList.Index);

//		if (lb_NewWeapons.CheckList.IsSection())
//			SectionCheck(lb_NewWeapons.CheckList.Checks[lb_NewWeapons.CheckList.LastCheckChanged] > 0);
		if (lb_NewWeapons.CheckList.LastClickWasCheck)
		{
			if (lb_NewWeapons.CheckList.Elements[lb_NewWeapons.CheckList.LastCheckChanged].bSection)
				SectionCheck(lb_NewWeapons.CheckList.Checks[lb_NewWeapons.CheckList.LastCheckChanged] > 0, lb_NewWeapons.CheckList.LastCheckChanged);
			else
			{
				if (lb_NewWeapons.CheckList.Checks[lb_NewWeapons.CheckList.LastCheckChanged] > 0)
				{
					for (i=0;i<Boxes[SelectedBox].WeaponNames.length;i++)
						if (Boxes[SelectedBox].WeaponNames[i] ~= WeaponInfo[int(lb_NewWeapons.List.GetExtraAtIndex(lb_NewWeapons.CheckList.LastCheckChanged))].ClassName)
							break;
					if (i >= Boxes[SelectedBox].WeaponNames.length)
						Boxes[SelectedBox].WeaponNames[Boxes[SelectedBox].WeaponNames.length] = WeaponInfo[int(lb_NewWeapons.List.GetExtraAtIndex(lb_NewWeapons.CheckList.LastCheckChanged))].ClassName;
				}
				else
				{
					for (i=0;i<Boxes[SelectedBox].WeaponNames.length;i++)
						if (Boxes[SelectedBox].WeaponNames[i] ~= WeaponInfo[int(lb_NewWeapons.List.GetExtraAtIndex(lb_NewWeapons.CheckList.LastCheckChanged))].ClassName)
						{
							Boxes[SelectedBox].WeaponNames.Remove(i, 1);
							i--;
						}
				}
			}
		}
		else
			DisplayWeapon();
	}
	else if (Sender == BAddAll)				// FILL
	{
		Boxes[SelectedBox].WeaponNames.length = 0;
		for (j=0;j<lb_NewWeapons.CheckList.Elements.length;j++)
		{
			lb_NewWeapons.CheckList.SetChecked(j, true);
			if (!lb_NewWeapons.CheckList.Elements[j].bSection)

				Boxes[SelectedBox].WeaponNames[Boxes[SelectedBox].WeaponNames.length] = WeaponInfo[int(lb_NewWeapons.CheckList.Elements[j].ExtraStrData)].ClassName;
		}
	}
	else if (Sender == BRemoveAll)			// EMPTY
	{
		Boxes[SelectedBox].WeaponNames.length = 0;
		for (j=0;j<lb_NewWeapons.CheckList.Elements.length;j++)
			lb_NewWeapons.CheckList.SetChecked(j, false);
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
	else if (Sender == ch_AllWeaps.MyCheckBox)	// All weapons checkbox
	{
		ch_AllWeaps.MyCheckBox.InternalOnClick(Sender);
		bUseAllWeapons = ch_AllWeaps.IsChecked();
		lb_NewWeapons.CheckList.Clear();
		lb_NewWeapons.CheckList.Checks.Length = 0;
		LoadList();
		LoadBox(SelectedBox);
	}
	return true;
}

function bool InternalOnRightClick(GUIComponent Sender)
{
	local int i;
	if (Sender == lb_NewWeapons.CheckList)	// Weapons list
	{
		if (!lb_NewWeapons.List.IsSection())
		{
			i = int(lb_NewWeapons.List.GetExtra());

			WeaponInfo[i].ReqTime = fl_RequiredTime.GetValue();
			WeaponInfo[i].ReqFrags = fl_RequiredFrags.GetValue();
			WeaponInfo[i].ReqEff = fl_RequiredEfficiency.GetValue();
			WeaponInfo[i].ReqDmgRate = fl_RequiredDmgRate.GetValue();
			WeaponInfo[i].ReqSnprEff = fl_RequiredSnprEff.GetValue();
			WeaponInfo[i].ReqStgnEff = fl_RequiredStgnEff.GetValue();
			WeaponInfo[i].ReqHzrdEff = fl_RequiredHzrdEff.GetValue();
		}
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
	local int i;
	if (!bInitialized)
		return;
	if (!lb_NewWeapons.List.IsSection())
	{
		i = int(lb_NewWeapons.List.GetExtra());

		WeaponInfo[i].ReqTime = fl_RequiredTime.GetValue();
		WeaponInfo[i].ReqFrags = fl_RequiredFrags.GetValue();
		WeaponInfo[i].ReqEff = fl_RequiredEfficiency.GetValue();
		WeaponInfo[i].ReqDmgRate = fl_RequiredDmgRate.GetValue();
		WeaponInfo[i].ReqSnprEff = fl_RequiredSnprEff.GetValue();
		WeaponInfo[i].ReqStgnEff = fl_RequiredStgnEff.GetValue();
		WeaponInfo[i].ReqHzrdEff = fl_RequiredHzrdEff.GetValue();
	}
	SaveBoxesToMutator();
	SaveConfig();
}

function DefaultSettings()
{
	class'Mut_Loadout'.static.ResetConfig("Items");

	LoadBoxesFromMutator();
	bInitialized=false;
	LoadBox(SelectedBox);
	bInitialized=true;
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
     Box_New=GUIImage'BallisticProV55.BallisticTab_LoadoutPro.Box_NewImg'

     Begin Object Class=GUIImage Name=Box_WeapIconImg
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.050000
         WinLeft=0.025000
         WinWidth=0.450000
         WinHeight=0.800000
         RenderWeight=0.002000
     End Object
     Box_WeapIcon=GUIImage'BallisticProV55.BallisticTab_LoadoutPro.Box_WeapIconImg'

     Begin Object Class=GUIImage Name=Pic_WeaponImg
         ImageStyle=ISTY_Scaled
         WinTop=0.090000
         WinLeft=0.040000
         WinWidth=0.420000
         WinHeight=0.279000
         RenderWeight=0.004000
     End Object
     Pic_Weapon=GUIImage'BallisticProV55.BallisticTab_LoadoutPro.Pic_WeaponImg'

     Begin Object Class=GUILabel Name=l_NewListlabel
         Caption="Weapons"
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255,R=255)
         WinTop=0.050000
         WinLeft=0.525000
         WinWidth=0.450000
         WinHeight=0.050000
     End Object
     l_NewList=GUILabel'BallisticProV55.BallisticTab_LoadoutPro.l_NewListlabel'

     Begin Object Class=GUILabel Name=l_WeapTitlelabel
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255,R=255)
         WinTop=0.050000
         WinLeft=0.035000
         WinWidth=0.430000
         WinHeight=0.050000
     End Object
     l_WeapTitle=GUILabel'BallisticProV55.BallisticTab_LoadoutPro.l_WeapTitlelabel'

     Begin Object Class=BC_GUICheckListBox Name=lb_NewWeaponsList
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
     lb_NewWeapons=BC_GUICheckListBox'BallisticProV55.BallisticTab_LoadoutPro.lb_NewWeaponsList'

     Begin Object Class=GUIButton Name=AddAllButton
         Caption="ALL"
         Hint="Checks all to replace the original weapon currently selected"
         WinTop=0.850000
         WinLeft=0.580000
         WinWidth=0.150000
         TabOrder=0
         OnClick=BallisticTab_LoadoutPro.InternalOnClick
         OnKeyEvent=AddAllButton.InternalOnKeyEvent
     End Object
     BAddAll=GUIButton'BallisticProV55.BallisticTab_LoadoutPro.AddAllButton'

     Begin Object Class=GUIButton Name=RemoveAllButton
         Caption="NONE"
         Hint="Unchecks all to replace the original weapon currently selected"
         WinTop=0.850000
         WinLeft=0.780000
         WinWidth=0.150000
         TabOrder=0
         OnClick=BallisticTab_LoadoutPro.InternalOnClick
         OnKeyEvent=RemoveAllButton.InternalOnKeyEvent
     End Object
     BRemoveAll=GUIButton'BallisticProV55.BallisticTab_LoadoutPro.RemoveAllButton'

     Begin Object Class=GUIButton Name=BBox1Button
         Caption="Melee"
         Hint="View the list of weapons in the 'Melee' box"
         WinTop=0.950000
         WinLeft=0.025000
         WinWidth=0.150000
         TabOrder=0
         OnClick=BallisticTab_LoadoutPro.InternalOnClick
         OnKeyEvent=BBox1Button.InternalOnKeyEvent
     End Object
     BBox1=GUIButton'BallisticProV55.BallisticTab_LoadoutPro.BBox1Button'

     Begin Object Class=GUIButton Name=BBox2Button
         Caption="Sidearm"
         Hint="View the list of weapons in the 'Sidearm' box"
         WinTop=0.950000
         WinLeft=0.225000
         WinWidth=0.150000
         TabOrder=0
         OnClick=BallisticTab_LoadoutPro.InternalOnClick
         OnKeyEvent=BBox2Button.InternalOnKeyEvent
     End Object
     BBox2=GUIButton'BallisticProV55.BallisticTab_LoadoutPro.BBox2Button'

     Begin Object Class=GUIButton Name=BBox3Button
         Caption="Primary"
         Hint="View the list of weapons in the 'Primary' box"
         WinTop=0.950000
         WinLeft=0.425000
         WinWidth=0.150000
         TabOrder=0
         OnClick=BallisticTab_LoadoutPro.InternalOnClick
         OnKeyEvent=BBox3Button.InternalOnKeyEvent
     End Object
     BBox3=GUIButton'BallisticProV55.BallisticTab_LoadoutPro.BBox3Button'

     Begin Object Class=GUIButton Name=BBox4Button
         Caption="Secondary"
         Hint="View the list of weapons in the 'Secondary' box"
         WinTop=0.950000
         WinLeft=0.625000
         WinWidth=0.150000
         TabOrder=0
         OnClick=BallisticTab_LoadoutPro.InternalOnClick
         OnKeyEvent=BBox4Button.InternalOnKeyEvent
     End Object
     BBox4=GUIButton'BallisticProV55.BallisticTab_LoadoutPro.BBox4Button'

     Begin Object Class=GUIButton Name=BBox5Button
         Caption="Grenade"
         Hint="View the list of weapons in the 'Grenade' box"
         WinTop=0.950000
         WinLeft=0.825000
         WinWidth=0.150000
         TabOrder=0
         OnClick=BallisticTab_LoadoutPro.InternalOnClick
         OnKeyEvent=BBox5Button.InternalOnKeyEvent
     End Object
     BBox5=GUIButton'BallisticProV55.BallisticTab_LoadoutPro.BBox5Button'

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
     ch_AllWeaps=moCheckBox'BallisticProV55.BallisticTab_LoadoutPro.ch_AllWeapsCheck'

     Begin Object Class=moFloatEdit Name=RequirementTimeEdit
         MinValue=0.000000
         MaxValue=999999.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Time"
         OnCreateComponent=RequirementTimeEdit.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="How much match time must have passed for this weapon to be available (simply delays availability)"
         WinTop=0.350000
         WinLeft=0.040000
         WinWidth=0.420000
         WinHeight=0.040000
     End Object
     fl_RequiredTime=moFloatEdit'BallisticProV55.BallisticTab_LoadoutPro.RequirementTimeEdit'

     Begin Object Class=moFloatEdit Name=RequirementFragsEdit
         MaxValue=999999.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Frags"
         OnCreateComponent=RequirementFragsEdit.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Mimimum frags required to choose this weapon (benefit by killing lots)"
         WinTop=0.400000
         WinLeft=0.040000
         WinWidth=0.420000
         WinHeight=0.040000
     End Object
     fl_RequiredFrags=moFloatEdit'BallisticProV55.BallisticTab_LoadoutPro.RequirementFragsEdit'

     Begin Object Class=moFloatEdit Name=RequirementEffEdit
         MaxValue=999999.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Efficiency"
         OnCreateComponent=RequirementEffEdit.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Frags divided by Deaths efficiency required to access this weapon (benefit by not wasting lives)"
         WinTop=0.450000
         WinLeft=0.040000
         WinWidth=0.420000
         WinHeight=0.040000
     End Object
     fl_RequiredEfficiency=moFloatEdit'BallisticProV55.BallisticTab_LoadoutPro.RequirementEffEdit'

     Begin Object Class=moFloatEdit Name=RequirementDmgRtEdit
         MaxValue=999999.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="DamageRate"
         OnCreateComponent=RequirementDmgRtEdit.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Damage Inflicted divided by Kills. How much the player has contibuted to kills (benfit by targeting strong players)"
         WinTop=0.500000
         WinLeft=0.040000
         WinWidth=0.420000
         WinHeight=0.040000
     End Object
     fl_RequiredDmgRate=moFloatEdit'BallisticProV55.BallisticTab_LoadoutPro.RequirementDmgRtEdit'

     Begin Object Class=moFloatEdit Name=fl_RequiredSnprEffEdit
         MaxValue=999999.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Sniper Eff"
         OnCreateComponent=RequirementDmgRtEdit.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Headshot kills divided by deaths. How efficient the player is at headshots (benfit by getting headshots and avoiding death)"
         WinTop=0.550000
         WinLeft=0.040000
         WinWidth=0.420000
         WinHeight=0.040000
     End Object
     fl_RequiredSnprEff=moFloatEdit'BallisticProV55.BallisticTab_LoadoutPro.fl_RequiredSnprEffEdit'

     Begin Object Class=moFloatEdit Name=fl_RequiredStgnEffEdit
         MaxValue=999999.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Shotgun Eff"
         OnCreateComponent=RequirementDmgRtEdit.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Gun kills divided by range and deaths. How efficient the player is at clsoe combat with guns (benfit by using guns close up and avoiding death)"
         WinTop=0.600000
         WinLeft=0.040000
         WinWidth=0.420000
         WinHeight=0.040000
     End Object
     fl_RequiredStgnEff=moFloatEdit'BallisticProV55.BallisticTab_LoadoutPro.fl_RequiredStgnEffEdit'

     Begin Object Class=moFloatEdit Name=fl_RequiredHzrdEffEdit
         MaxValue=999999.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Hazard Eff"
         OnCreateComponent=RequirementDmgRtEdit.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Kills minus deaths with traps and hazardous weapons divided by deaths. (benfit by killing with hazardous weapons and avoiding death)"
         WinTop=0.650000
         WinLeft=0.040000
         WinWidth=0.420000
         WinHeight=0.040000
     End Object
     fl_RequiredHzrdEff=moFloatEdit'BallisticProV55.BallisticTab_LoadoutPro.fl_RequiredHzrdEffEdit'

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
