//=============================================================================
// BallisticOutfittingMenu.
//
// Menu for selecting weapon loadout. Consists of several categories, user can
// pick what weapon they want for each category (e.g. melee, sidearm, grenade)
//
// by Nolan "Dark Carnivour" Richert.
// Modified by Azarael
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticOutfittingWeaponsTab extends UT2K4TabPanel config(BallisticProV55);

// Use GUILoadOutItems to select weapons. This control has some text with an image that cycles when you click on it

var automated GUILoadOutItem 		Item_Melee, Item_SideArm, Item_Primary, Item_Secondary, Item_Grenade;
var automated GUIComboBox	 		cb_Melee, cb_SideArm, cb_Primary, cb_Secondary, cb_Grenade;
var automated GUIComboBox	 		cb_Melee_LI, cb_SideArm_LI, cb_Primary_LI, cb_Secondary_LI, cb_Grenade_LI;
var automated GUIComboBox	 		cb_Melee_CI, cb_SideArm_CI, cb_Primary_CI, cb_Secondary_CI, cb_Grenade_CI;
var automated moComboBox			cb_Presets;
var Automated GUIImage 				Box_Melee, Box_SideArm, Box_Primary, Box_Secondary, Box_Grenade, Box_Streak1, Box_Streak2, Box_Streak3, MeleeBack, SideArmBack, PrimaryBack, SecondaryBack, GrenadeBack;
var Automated GUIButton 			BDone, BCancel, BSavePreset;
var automated GUILabel				l_Receiving;
var BallisticOutfittingMenu 		p_Anchor;

var config int						CurrentIndex;
var config bool 					bInitialized;
var bool 							bWeaponsLoaded;

struct LoadoutWeapons
{
    var string PresetName;
	var string Weapons[5];
	var int Layouts[5];
	var int Camos[5];
};

var() config array<LoadoutWeapons>	SavedLoadouts[5];  //Saved loadouts

struct WeaponItemInfo
{
	var string ItemCap;
	var Material ItemImage;
	var string ItemClassName;
	var IntBox ImageCoords;
	var int InventoryGroup;
	var byte Index;
};

var array<WeaponItemInfo> 			sortedPrimaries;
var array<WeaponItemInfo> 			sortedSecondaries;

var int NumPresets;

var() localized string 				QuickListText;

var localized string 				ReceivingText[2];

var ClientOutfittingInterface 		COI;	// The ClientOutfittingInterface actor we can use to communicate with the mutator

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);
	
	if(BallisticOutfittingMenu(Controller.ActivePage) != None)
		p_Anchor = BallisticOutfittingMenu(Controller.ActivePage);
		
	Item_Melee.OnItemChange = OnLoadoutItemChange;
	Item_Sidearm.OnItemChange = OnLoadoutItemChange;
	Item_Primary.OnItemChange = OnLoadoutItemChange;
	Item_Secondary.OnItemChange = OnLoadoutItemChange;
	Item_Grenade.OnItemChange = OnLoadoutItemChange;
}

function ShowPanel(bool bShow)
{
	local int i;
	
	super.ShowPanel(bShow);
	
	if (!bInitialized)
	{
		for(i=0;i<5;i++)
		SavedLoadouts[0].Weapons[i] = class'Mut_Outfitting'.default.LoadOut[i];
		SavedLoadouts[0].Layouts[i] = class'Mut_Outfitting'.default.Layout[i];
		SavedLoadouts[0].Camos[i] = class'Mut_Outfitting'.default.Camo[i];
		bInitialized=True;
		SaveConfig();
	}
	
	if(!bWeaponsLoaded)
	{
		if (COI == None || COI.bWeaponsReady)
		{
			if (PlayerOwner().level.NetMode == NM_Client)
			{
				l_Receiving.Caption = ReceivingText[0];
				SetTimer(0.5, true);
			}
			else
			{
				l_Receiving.Caption = ReceivingText[1];
				SetTimer(0.1, true);
			}
		}
		else
		{
			LoadWeapons();
			bWeaponsLoaded=True;
		}
	
		cb_Melee.List.bSorted=true;
		cb_SideArm.List.bSorted=true;
		cb_Grenade.List.bSorted=true;
	}
}

event Timer()
{
	if (COI != None && COI.bWeaponsReady && !bWeaponsLoaded)
	{
		KillTimer();
		LoadWeapons();
		bWeaponsLoaded=True;
	}
}

function LoadWeapons()
{
	local int i;
	local string IC, ICN;
	local Material IMat;
	local IntBox ICrds;
	local int lastIndex;
	
	// Load the weapons into their GUILoadOutItems

	for(i=0;i<COI.GroupLength(0);i++)
	{
		if (GetItemInfo(0, i, IC, IMat, ICN, ICrds))
		{
			Item_Melee.AddItem(IC, IMat, ICN, ICrds);
   			cb_Melee.AddItem(IC, ,ICN);
	   		cb_Melee.SetText(QuickListText);
   		}
	}

	for(i=0;i<COI.GroupLength(1);i++)
	{
		if (GetItemInfo(1, i, IC, IMat, ICN, ICrds))
		{
			Item_SideArm.AddItem(IC, IMat, ICN, ICrds);
   			cb_SideArm.AddItem(IC, ,ICN);
   			cb_SideArm.SetText(QuickListText);
   		}
	}

	//=======================================================================
	// Special handling for primary and secondary slots.	
	//=======================================================================
	for(i=0;i<COI.GroupLength(2);i++)
		FillItemInfos(2, i);
		
	lastIndex = -1;
	
	for(i=0; i<sortedPrimaries.Length; i++)
	{
		if (sortedPrimaries[i].InventoryGroup > lastIndex)
		{
			lastIndex = sortedPrimaries[i].InventoryGroup;
			cb_Primary.MyListBox.List.Add(class'BallisticWeaponClassInfo'.static.GetHeading(lastIndex),None,"",true);
		}
		
		Item_Primary.AddItem(
			sortedPrimaries[i].ItemCap, 
			sortedPrimaries[i].ItemImage, 
			sortedPrimaries[i].ItemClassName, 
			sortedPrimaries[i].ImageCoords
			);
		cb_Primary.AddItem(sortedPrimaries[i].ItemCap,  ,sortedPrimaries[i].ItemClassName);
		cb_Primary.SetText(QuickListText);
	}

	for(i=0;i<COI.GroupLength(3);i++)
		FillItemInfos(3, i);
		
	lastIndex = -1;
		
	for(i=0; i<sortedSecondaries.Length; i++)
	{
		if (sortedSecondaries[i].InventoryGroup > lastIndex)
		{
			lastIndex = sortedSecondaries[i].InventoryGroup;
			cb_Secondary.MyListBox.List.Add(class'BallisticWeaponClassInfo'.static.GetHeading(lastIndex),None,"",true);
		}
		
		Item_Secondary.AddItem(
			sortedSecondaries[i].ItemCap, 
			sortedSecondaries[i].ItemImage, 
			sortedSecondaries[i].ItemClassName, 
			sortedSecondaries[i].ImageCoords
			);
		cb_Secondary.AddItem(sortedSecondaries[i].ItemCap,  ,sortedSecondaries[i].ItemClassName);
		cb_Secondary.SetText(QuickListText);
	}

	for(i=0;i<COI.GroupLength(4);i++)
	{
		if (GetItemInfo(4, i, IC, IMat, ICN, ICrds))
		{
			Item_Grenade.AddItem(IC, IMat, ICN, ICrds);
   			cb_Grenade.AddItem(IC, ,ICN);
   			cb_Grenade.SetText(QuickListText);
   		}
	}
	
	Item_Melee.SetItem(SavedLoadOuts[CurrentIndex].Weapons[0]);
	LoadLayouts(0, Item_Melee.Index, cb_Melee_LI);
	cb_Melee_LI.setIndex(SavedLoadOuts[CurrentIndex].Layouts[0]);
	LoadCamos(0, cb_Melee_LI.getIndex(), Item_Melee.Index, cb_Melee_CI);
	
	Item_SideArm.SetItem(SavedLoadOuts[CurrentIndex].Weapons[1]);
	LoadLayouts(1, Item_SideArm.Index, cb_SideArm_LI);
	cb_SideArm_LI.setIndex(SavedLoadOuts[CurrentIndex].Layouts[1]);
	LoadCamos(1, cb_SideArm_LI.getIndex(), Item_SideArm.Index, cb_SideArm_CI);
	
	Item_Primary.SetItem(SavedLoadOuts[CurrentIndex].Weapons[2]);
	LoadLayouts(2, sortedPrimaries[Item_Primary.Index].Index, cb_Primary_LI);
	cb_Primary_LI.setIndex(SavedLoadOuts[CurrentIndex].Layouts[2]);
	LoadCamos(2, cb_Primary_LI.getIndex(), sortedPrimaries[Item_Primary.Index].Index, cb_Primary_CI);
	
	Item_Secondary.SetItem(SavedLoadOuts[CurrentIndex].Weapons[3]);
	LoadLayouts(3, sortedSecondaries[Item_Secondary.Index].Index, cb_Secondary_LI);
	cb_Secondary_LI.setIndex(SavedLoadOuts[CurrentIndex].Layouts[3]);
	LoadCamos(3, cb_Secondary_LI.getIndex(), sortedSecondaries[Item_Secondary.Index].Index, cb_Secondary_CI);
	
	Item_Grenade.SetItem(SavedLoadOuts[CurrentIndex].Weapons[4]);
	LoadLayouts(4, Item_Grenade.Index, cb_Grenade_LI);
	cb_Grenade_LI.setIndex(SavedLoadOuts[CurrentIndex].Layouts[4]);
	LoadCamos(4, cb_Grenade_LI.getIndex(), Item_Grenade.Index, cb_Grenade_CI);
	
	//Add Random and None forcibly as separate items here.
	
	//Load presets
	for(i=0;i<5;i++)
	    cb_Presets.AddItem(SavedLoadouts[i].PresetName ,,string(i));
	cb_Presets.SetIndex(Clamp(CurrentIndex, 0, 5));  
	
	class'BC_WeaponInfoCache'.static.EndSession();
	l_Receiving.Caption = "";
}

// Get Name, BigIconMaterial and classname of weapon at index? in group?
function bool GetItemInfo(int Group, int Index, out string ItemCap, out Material ItemImage, out string ItemClassName, optional out IntBox ImageCoords)
{
	local BC_WeaponInfoCache.WeaponInfo WI;
	local int i;

	if (COI.GetGroupItem(Group, Index) == "")
		return false;
	WI = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(COI.GetGroupItem(Group, Index), i);
	if (i==-1)
	{
		log("Error loading item for outfitting: "$COI.GetGroupItem(Group, Index), 'Warning');
		return false;
	}
	ItemCap = WI.ItemName;
	ItemClassName = COI.GetGroupItem(Group, Index);
	if (WI.bIsBW)
	{
		ItemImage = WI.BigIconMaterial;
		ImageCoords.X1=-1; ImageCoords.X2=-1; ImageCoords.Y1=-1; ImageCoords.Y2=-1;
	}
	else
	{
		ItemImage = WI.SmallIconMaterial;
		ImageCoords = WI.SmallIconCoords;
	}
	return true;
}

// Get Name, BigIconMaterial and classname of weapon at index? in group?
function FillItemInfos(int Group, int Index)
{
	local BC_WeaponInfoCache.WeaponInfo WI;
	local int i;
	local WeaponItemInfo WInfo;

	if (COI.GetGroupItem(Group, Index) == "")
		return;
	WI = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(COI.GetGroupItem(Group, Index), i);
	if (i==-1)
	{
		log("Error loading item for outfitting: "$COI.GetGroupItem(Group, Index), 'Warning');
		return;
	}
	WInfo.ItemCap = WI.ItemName;
	WInfo.InventoryGroup = WI.InventoryGroup;
	WInfo.ItemClassName = COI.GetGroupItem(Group, Index);
	WInfo.Index = Index;
	if (WI.bIsBW)
	{
		WInfo.ItemImage = WI.BigIconMaterial;
		WInfo.ImageCoords.X1=-1; WInfo.ImageCoords.X2=-1; WInfo.ImageCoords.Y1=-1; WInfo.ImageCoords.Y2=-1;
	}
	else
	{
		WInfo.ItemImage = WI.SmallIconMaterial;
		WInfo.ImageCoords = WI.SmallIconCoords;
	}

	// Sort
	if (Group == 2)
	{
		if (sortedPrimaries.Length == 0)
			sortedPrimaries[sortedPrimaries.Length] = WInfo;
		else 
		{
			for (i = 0; i < sortedPrimaries.Length; ++i)
			{
				if (WInfo.InventoryGroup < sortedPrimaries[i].InventoryGroup)
				{
					sortedPrimaries.Insert(i, 1);
					sortedPrimaries[i] = WInfo;
					break;
				}
				
				if (WInfo.InventoryGroup == sortedPrimaries[i].InventoryGroup)
					if (StrCmp(WInfo.ItemCap, sortedPrimaries[i].ItemCap, 6, True) <= 0)
					{	
						sortedPrimaries.Insert(i, 1);
						sortedPrimaries[i] = WInfo;
						break;
					}

				if (i == sortedPrimaries.Length - 1)
				{
					sortedPrimaries[sortedPrimaries.Length] = WInfo;
					break;
				}
			}
		}
	}
	
	else
	{
		if (sortedSecondaries.Length == 0)
			sortedSecondaries[sortedSecondaries.Length] = WInfo;
		else 
		{	
			for (i = 0; i < sortedSecondaries.Length; ++i)
			{
				if (WInfo.InventoryGroup < sortedSecondaries[i].InventoryGroup)
				{
					sortedSecondaries.Insert(i, 1);
					sortedSecondaries[i] = WInfo;
					break;
				}
				
				if (WInfo.InventoryGroup == sortedSecondaries[i].InventoryGroup)
					if (StrCmp(WInfo.ItemCap, sortedSecondaries[i].ItemCap, 6, True) <= 0)
					{	
						sortedSecondaries.Insert(i, 1);
						sortedSecondaries[i] = WInfo;
						break;
					}
				
				if (i == sortedSecondaries.Length - 1)
				{
					sortedSecondaries[sortedSecondaries.Length] = WInfo;
					break;
				}
			}
		}
	}
}

function OnLoadoutItemChange(GUIComponent Sender)
{
	if (Sender == Item_Melee)
	{
		LoadLayouts(0, Item_Melee.Index, cb_Melee_LI);
		LoadCamos(0, cb_Melee_LI.getIndex(), Item_Melee.Index, cb_Melee_CI);
	}
	else if (Sender == Item_SideArm)
	{
		LoadLayouts(1, Item_SideArm.Index, cb_SideArm_LI);
		LoadCamos(1, cb_SideArm_LI.getIndex(), Item_SideArm.Index, cb_SideArm_CI);
	}
	else if (Sender == Item_Primary)
	{
		LoadLayouts(2, sortedPrimaries[Item_Primary.Index].Index, cb_Primary_LI);
		LoadCamos(2, cb_Primary_LI.getIndex(), sortedPrimaries[Item_Primary.Index].Index, cb_Primary_CI);
	}
	else if (Sender == Item_Secondary)
	{
		LoadLayouts(3, sortedSecondaries[Item_Secondary.Index].Index, cb_Secondary_LI);
		LoadCamos(3, cb_Secondary_LI.getIndex(), sortedSecondaries[Item_Secondary.Index].Index, cb_Secondary_CI);
	}
	else if (Sender == Item_Grenade)
	{
		LoadLayouts(4, Item_Grenade.Index, cb_Grenade_LI);
		LoadCamos(4, cb_Grenade_LI.getIndex(), Item_Grenade.Index, cb_Grenade_CI);
	}
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
	return false;
}

function bool InternalOnClick(GUIComponent Sender)
{
    if (Sender==BSavePreset) //SAVE PRESET
	{
			SavedLoadouts[cb_Presets.GetIndex()].PresetName = cb_Presets.GetText();
		if (Item_Melee.Items.length > Item_Melee.Index)
		{
			SavedLoadouts[cb_Presets.GetIndex()].Weapons[0] = Item_Melee.Items[Item_Melee.Index].Text;
			SavedLoadouts[cb_Presets.GetIndex()].Layouts[0] = cb_Melee_LI.getIndex();
			SavedLoadouts[cb_Presets.GetIndex()].Camos[0] = int(cb_Melee_CI.getExtra());
		}
		if (Item_SideArm.Items.length > Item_SideArm.Index)
		{
			SavedLoadouts[cb_Presets.GetIndex()].Weapons[1] = Item_SideArm.Items[Item_SideArm.Index].Text;
			SavedLoadouts[cb_Presets.GetIndex()].Layouts[1] = cb_SideArm_LI.getIndex();
			SavedLoadouts[cb_Presets.GetIndex()].Camos[1] = int(cb_SideArm_CI.getExtra());
		}
		if (Item_Primary.Items.length > Item_Primary.Index)
		{
			SavedLoadouts[cb_Presets.GetIndex()].Weapons[2] = Item_Primary.Items[Item_Primary.Index].Text;
			SavedLoadouts[cb_Presets.GetIndex()].Layouts[2] = cb_Primary_LI.getIndex();
			SavedLoadouts[cb_Presets.GetIndex()].Camos[2] = int(cb_Primary_CI.getExtra());
		}
		if (Item_Secondary.Items.length > Item_Secondary.Index)
		{
			SavedLoadouts[cb_Presets.GetIndex()].Weapons[3] = Item_Secondary.Items[Item_Secondary.Index].Text;
			SavedLoadouts[cb_Presets.GetIndex()].Layouts[3] = cb_Secondary_LI.getIndex();
			SavedLoadouts[cb_Presets.GetIndex()].Camos[3] = int(cb_Secondary_CI.getExtra());
		}
		if (Item_Grenade.Items.length > Item_Grenade.Index)
		{
			SavedLoadouts[cb_Presets.GetIndex()].Weapons[4] = Item_Grenade.Items[Item_Grenade.Index].Text;
			SavedLoadouts[cb_Presets.GetIndex()].Layouts[4] = cb_Grenade_LI.getIndex();
			SavedLoadouts[cb_Presets.GetIndex()].Camos[4] = int(cb_Grenade_CI.getExtra());
		}
		SaveConfig();	
	}
	return true;
}

//Save selected weapons to the preset and mut defaults, COI reads from mut defaults to send to user
function SaveWeapons()
{
		SavedLoadouts[cb_Presets.GetIndex()].PresetName = cb_Presets.GetText();
			
		if (Item_Melee.Items.length > Item_Melee.Index)
		{
			SavedLoadouts[cb_Presets.GetIndex()].Weapons[0] = Item_Melee.Items[Item_Melee.Index].Text;
			SavedLoadouts[cb_Presets.GetIndex()].Layouts[0] = cb_Melee_LI.getIndex();
			SavedLoadouts[cb_Presets.GetIndex()].Camos[0] = int(cb_Melee_CI.getExtra());
		}
		if (Item_SideArm.Items.length > Item_SideArm.Index)
		{
			SavedLoadouts[cb_Presets.GetIndex()].Weapons[1] = Item_SideArm.Items[Item_SideArm.Index].Text;
			SavedLoadouts[cb_Presets.GetIndex()].Layouts[1] = cb_SideArm_LI.getIndex();
			SavedLoadouts[cb_Presets.GetIndex()].Camos[1] = int(cb_SideArm_CI.getExtra());
		}
		if (Item_Primary.Items.length > Item_Primary.Index)
		{
			SavedLoadouts[cb_Presets.GetIndex()].Weapons[2] = Item_Primary.Items[Item_Primary.Index].Text;
			SavedLoadouts[cb_Presets.GetIndex()].Layouts[2] = cb_Primary_LI.getIndex();
			SavedLoadouts[cb_Presets.GetIndex()].Camos[2] = int(cb_Primary_CI.getExtra());
		}
		if (Item_Secondary.Items.length > Item_Secondary.Index)
		{
			SavedLoadouts[cb_Presets.GetIndex()].Weapons[3] = Item_Secondary.Items[Item_Secondary.Index].Text;
			SavedLoadouts[cb_Presets.GetIndex()].Layouts[3] = cb_Secondary_LI.getIndex();
			SavedLoadouts[cb_Presets.GetIndex()].Camos[3] = int(cb_Secondary_CI.getExtra());
		}
		if (Item_Grenade.Items.length > Item_Grenade.Index)
		{
			SavedLoadouts[cb_Presets.GetIndex()].Weapons[4] = Item_Grenade.Items[Item_Grenade.Index].Text;
			SavedLoadouts[cb_Presets.GetIndex()].Layouts[4] = cb_Grenade_LI.getIndex();
			SavedLoadouts[cb_Presets.GetIndex()].Camos[4] = int(cb_Grenade_CI.getExtra());
		}

		if (Item_Melee.Items.length > Item_Melee.Index)
		{
			class'Mut_Outfitting'.default.LoadOut[0] = Item_Melee.Items[Item_Melee.Index].Text;
			class'Mut_Outfitting'.default.Layout[0] = cb_Melee_LI.getIndex();
			class'Mut_Outfitting'.default.Camo[0] = int(cb_Melee_CI.getExtra());
		}
		if (Item_SideArm.Items.length > Item_SideArm.Index)
		{
			class'Mut_Outfitting'.default.LoadOut[1] = Item_SideArm.Items[Item_SideArm.Index].Text;
			class'Mut_Outfitting'.default.Layout[1] = cb_SideArm_LI.getIndex();
			class'Mut_Outfitting'.default.Camo[1] = int(cb_SideArm_CI.getExtra());
		}
		if (Item_Primary.Items.length > Item_Primary.Index)
		{
			class'Mut_Outfitting'.default.LoadOut[2] = Item_Primary.Items[Item_Primary.Index].Text;
			class'Mut_Outfitting'.default.Layout[2] = cb_Primary_LI.getIndex();
			class'Mut_Outfitting'.default.Camo[2] = int(cb_Primary_CI.getExtra());
		}
		if (Item_Secondary.Items.length > Item_Secondary.Index)
		{
			class'Mut_Outfitting'.default.LoadOut[3] = Item_Secondary.Items[Item_Secondary.Index].Text;
			class'Mut_Outfitting'.default.Layout[3] = cb_Secondary_LI.getIndex();
			class'Mut_Outfitting'.default.Camo[3] = int(cb_Secondary_CI.getExtra());
		}
		if (Item_Grenade.Items.length > Item_Grenade.Index)
		{
			class'Mut_Outfitting'.default.LoadOut[4] = Item_Grenade.Items[Item_Grenade.Index].Text;
			class'Mut_Outfitting'.default.Layout[4] = cb_Grenade_LI.getIndex();
			class'Mut_Outfitting'.default.Camo[4] = int(cb_Grenade_CI.getExtra());
		}
		
		CurrentIndex=cb_Presets.GetIndex();
		
		SaveConfig();
		class'Mut_Outfitting'.static.StaticSaveConfig();
		
		//COI.LoadoutChanged(class'Mut_Outfitting'.default.LoadOut);
}

function InternalOnChange(GUIComponent Sender)
{
	if (COI == None || !COI.bWeaponsReady)
		return;
		
	if (Sender == cb_Melee)
	{
		Item_Melee.SetItem(cb_Melee.GetExtra());
		LoadLayouts(0, Item_Melee.Index, cb_Melee_LI);
		LoadCamos(0, cb_Melee_LI.getIndex(), Item_Melee.Index, cb_Melee_CI);
	}
	else if (Sender == cb_SideArm)
	{
		Item_SideArm.SetItem(cb_SideArm.GetExtra());
		LoadLayouts(1, Item_SideArm.Index, cb_SideArm_LI);
		LoadCamos(1, cb_SideArm_LI.getIndex(), Item_SideArm.Index, cb_SideArm_CI);
	}
	else if (Sender == cb_Primary)
	{
		Item_Primary.SetItem(cb_Primary.GetExtra());
		LoadLayouts(2, sortedPrimaries[Item_Primary.Index].Index, cb_Primary_LI);
		LoadCamos(2, cb_Primary_LI.getIndex(), sortedPrimaries[Item_Primary.Index].Index, cb_Primary_CI);
	}
	else if (Sender == cb_Secondary)
	{
		Item_Secondary.SetItem(cb_Secondary.GetExtra());
		LoadLayouts(3, sortedSecondaries[Item_Secondary.Index].Index, cb_Secondary_LI);
		LoadCamos(3, cb_Secondary_LI.getIndex(), sortedSecondaries[Item_Secondary.Index].Index, cb_Secondary_CI);
	}
	else if (Sender == cb_Grenade)
	{
		Item_Grenade.SetItem(cb_Grenade.GetExtra());
		LoadLayouts(4, Item_Grenade.Index, cb_Grenade_LI);
		LoadCamos(4, cb_Grenade_LI.getIndex(), Item_Grenade.Index, cb_Grenade_CI);
	}
		
	else if (Sender == cb_Presets && cb_Presets.GetExtra() != "") //Grab the preset data
	{
		Item_Melee.SetItem(SavedLoadOuts[cb_Presets.GetIndex()].Weapons[0]);
		LoadLayouts(0, Item_Melee.Index, cb_Melee_LI);
		cb_Melee_LI.setIndex(SavedLoadOuts[CurrentIndex].Layouts[0]);
		LoadCamos(0, cb_Melee_LI.getIndex(), Item_Melee.Index, cb_Melee_CI);
		
		Item_SideArm.SetItem(SavedLoadOuts[cb_Presets.GetIndex()].Weapons[1]);
		LoadLayouts(1, Item_SideArm.Index, cb_SideArm_LI);
		cb_SideArm_LI.setIndex(SavedLoadOuts[CurrentIndex].Layouts[1]);
		LoadCamos(1, cb_SideArm_LI.getIndex(), Item_SideArm.Index, cb_SideArm_CI);
		
		Item_Primary.SetItem(SavedLoadOuts[cb_Presets.GetIndex()].Weapons[2]);
		LoadLayouts(2, sortedPrimaries[Item_Primary.Index].Index, cb_Primary_LI);
		cb_Primary_LI.setIndex(SavedLoadOuts[CurrentIndex].Layouts[2]);
		LoadCamos(2, cb_Primary_LI.getIndex(), sortedPrimaries[Item_Primary.Index].Index, cb_Primary_CI);
		
		Item_Secondary.SetItem(SavedLoadOuts[cb_Presets.GetIndex()].Weapons[3]);
		LoadLayouts(3, sortedSecondaries[Item_Secondary.Index].Index, cb_Secondary_LI);
		cb_Secondary_LI.setIndex(SavedLoadOuts[CurrentIndex].Layouts[3]);
		LoadCamos(3, cb_Secondary_LI.getIndex(), sortedSecondaries[Item_Secondary.Index].Index, cb_Secondary_CI);
		
		Item_Grenade.SetItem(SavedLoadOuts[cb_Presets.GetIndex()].Weapons[4]);
		LoadLayouts(4, Item_Grenade.Index, cb_Grenade_LI);
		cb_Grenade_LI.setIndex(SavedLoadOuts[CurrentIndex].Layouts[4]);
		LoadCamos(4, cb_Grenade_LI.getIndex(), Item_Grenade.Index, cb_Grenade_CI);
	}
}

//give this function a gun, grab an array of layouts from cache, add each value to the combobox
function bool LoadLayouts(int GroupIndex, int Index, GUIComboBox LayoutComboBox)
{
	local byte GameStyleIndex;
	local int i;
	local class<BallisticWeapon> BW;
		
	//clear old layouts
	LayoutComboBox.Clear();
	
	BW = class<BallisticWeapon>(DynamicLoadObject(COI.GetGroupItem(GroupIndex, Index), class'Class'));
	if (BW == None)
	{
		log("Error loading item for outfitting: "$BW, 'Warning');
		return false;
	}
	
	GameStyleIndex = class'BallisticReplicationInfo'.default.GameStyle;
	if (BW.default.ParamsClasses.length < GameStyleIndex)
	{
		log("Error loading item for outfitting: "$BW, 'Warning');
		return false;
	}
	
	for (i=0; i < BW.default.ParamsClasses[GameStyleIndex].default.Layouts.length; i++)
	{
		if (BW.default.ParamsClasses[GameStyleIndex].default.Layouts[i].LayoutName == "")
		{
			if (BW.default.ParamsClasses[GameStyleIndex].default.Layouts.length == 1)
				LayoutComboBox.AddItem("Default");
			else
				LayoutComboBox.AddItem("Layout: "$string(i));
		}
		else
			LayoutComboBox.AddItem(BW.default.ParamsClasses[GameStyleIndex].default.Layouts[i].LayoutName);
	}
	
	return true;
}

//give this function a gun, grab an array of layouts from cache, add each value to the combobox
//Unlike the load layouts function above, this one will try and read your last camo index to find which value to default
//This is required due to the allowed camos changing for various layouts
function bool LoadCamos(int GroupIndex, int LayoutIndex, int Index, GUIComboBox CamoComboBox)
{
	local byte GameStyleIndex;
	local int i;
	local array<int> AllowedCamos;
	local class<BallisticWeapon> BW;
	
	if (LayoutIndex == -1) //layout box isn't even loaded yet
		return false;
	
	//clear old camos
	CamoComboBox.Clear();
	
	GameStyleIndex = class'BallisticReplicationInfo'.default.GameStyle;
	
	BW = class<BallisticWeapon>(DynamicLoadObject(COI.GetGroupItem(GroupIndex, Index), class'Class'));
	if (BW == None)
	{
		log("Error loading item for outfitting: "$BW, 'Warning');
		return false;
	}

	// weapon has no parameters for this index
	if (BW.default.ParamsClasses.length < GameStyleIndex)
	{
		log("Error loading item for outfitting: "$BW, 'Warning');
		return false;
	}

	AllowedCamos = BW.default.ParamsClasses[GameStyleIndex].default.Layouts[LayoutIndex].AllowedCamos;

	if (AllowedCamos.Length == 0 )
	{
		for (i=0; i < BW.default.ParamsClasses[GameStyleIndex].default.Camos.length; i++)
		{
			if (BW.default.ParamsClasses[GameStyleIndex].default.Camos[i].CamoName == "")
			{
				if (BW.default.ParamsClasses[GameStyleIndex].default.Camos.length == 1)
					CamoComboBox.AddItem("None",, "0");
				else
					CamoComboBox.AddItem("Layout: "$string(i),, String(BW.default.ParamsClasses[GameStyleIndex].default.Camos[i].Index));
			}
			CamoComboBox.AddItem(BW.default.ParamsClasses[GameStyleIndex].default.Camos[i].CamoName,, String(BW.default.ParamsClasses[GameStyleIndex].default.Camos[i].Index));
		}
		CamoComboBox.setIndex(SavedLoadOuts[CurrentIndex].Camos[GroupIndex]);
	}
	else
	{
		for (i = 0; i < AllowedCamos.Length; i++)
		{
			CamoComboBox.AddItem(BW.default.ParamsClasses[GameStyleIndex].default.Camos[AllowedCamos[i]].CamoName,, String(BW.default.ParamsClasses[GameStyleIndex].default.Camos[AllowedCamos[i]].Index));
			if (SavedLoadOuts[CurrentIndex].Camos[GroupIndex] == BW.default.ParamsClasses[GameStyleIndex].default.Camos[AllowedCamos[i]].Index) //these damn boxes changing sizes
				CamoComboBox.setIndex(i);
		}
	}
	
	if (CamoComboBox.ItemCount() == 0)
		CamoComboBox.AddItem("None",, "255");
	
	if (CamoComboBox.ItemCount() > 1)
	{
		CamoComboBox.AddItem("Random",, "255");
		if (SavedLoadOuts[CurrentIndex].Camos[GroupIndex] == 255) //these damn boxes changing sizes
			CamoComboBox.setIndex(CamoComboBox.ItemCount()-1);
	}
	
	return true;
}

defaultproperties
{
     Begin Object Class=GUILoadOutItem Name=MeleeImage
         NAImage=Texture'BW_Core_WeaponTex.Icons.BigIcon_NA'
         Caption="Gear"
         WinTop=0.050000
         WinLeft=0.100000
         WinWidth=0.200000
         WinHeight=0.200000
         OnRendered=MeleeImage.InternalOnDraw
         OnClick=MeleeImage.InternalOnClick
         OnRightClick=MeleeImage.InternalOnRightClick
     End Object
     Item_Melee=GUILoadOutItem'BallisticProV55.BallisticOutfittingWeaponsTab.MeleeImage'

     Begin Object Class=GUILoadOutItem Name=SideArmImage
         NAImage=Texture'BW_Core_WeaponTex.Icons.BigIcon_NA'
         Caption="Sidearm"
         WinTop=0.050000
         WinLeft=0.400000
         WinWidth=0.200000
         WinHeight=0.200000
         OnRendered=SideArmImage.InternalOnDraw
         OnClick=SideArmImage.InternalOnClick
         OnRightClick=SideArmImage.InternalOnRightClick
     End Object
     Item_SideArm=GUILoadOutItem'BallisticProV55.BallisticOutfittingWeaponsTab.SideArmImage'

     Begin Object Class=GUILoadOutItem Name=PrimaryImage
         NAImage=Texture'BW_Core_WeaponTex.Icons.BigIcon_NA'
         Caption="Primary Weapon"
         WinTop=0.350000
         WinLeft=0.250000
         WinWidth=0.200000
         WinHeight=0.200000
         OnRendered=PrimaryImage.InternalOnDraw
         OnClick=PrimaryImage.InternalOnClick
         OnRightClick=PrimaryImage.InternalOnRightClick
     End Object
     Item_Primary=GUILoadOutItem'BallisticProV55.BallisticOutfittingWeaponsTab.PrimaryImage'

     Begin Object Class=GUILoadOutItem Name=SecondaryImage
         NAImage=Texture'BW_Core_WeaponTex.Icons.BigIcon_NA'
         Caption="Secondary Weapon"
         WinTop=0.350000
         WinLeft=0.550000
         WinWidth=0.200000
         WinHeight=0.200000
         OnRendered=SecondaryImage.InternalOnDraw
         OnClick=SecondaryImage.InternalOnClick
         OnRightClick=SecondaryImage.InternalOnRightClick
     End Object
     Item_Secondary=GUILoadOutItem'BallisticProV55.BallisticOutfittingWeaponsTab.SecondaryImage'

     Begin Object Class=GUILoadOutItem Name=GrenadeImage
         NAImage=Texture'BW_Core_WeaponTex.Icons.BigIcon_NA'
         Caption="Grenades"
         WinTop=0.050000
         WinLeft=0.700000
         WinWidth=0.200000
         WinHeight=0.200000
         OnRendered=GrenadeImage.InternalOnDraw
         OnClick=GrenadeImage.InternalOnClick
         OnRightClick=GrenadeImage.InternalOnRightClick
     End Object
     Item_Grenade=GUILoadOutItem'BallisticProV55.BallisticOutfittingWeaponsTab.GrenadeImage'

     Begin Object Class=GUIComboBox Name=cb_MeleeComBox
         MaxVisibleItems=16
         Hint="Quick list of gear."
         WinTop=0.250000
         WinLeft=0.102148
         WinWidth=0.196094
         WinHeight=0.040000
         TabOrder=0
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
         OnKeyEvent=cb_MeleeComBox.InternalOnKeyEvent
     End Object
     cb_Melee=GUIComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.cb_MeleeComBox'

	Begin Object Class=GUIComboBox Name=cb_MeleeComBox_LI
         MaxVisibleItems=16
         Hint="Gear layouts."
         WinTop=0.290000
         WinLeft=0.092148
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
         OnKeyEvent=cb_MeleeComBox_LI.InternalOnKeyEvent
     End Object
     cb_Melee_LI=GUIComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.cb_MeleeComBox_LI'

	Begin Object Class=GUIComboBox Name=cb_MeleeComBox_CI
         MaxVisibleItems=16
         Hint="Gear camos."
         WinTop=0.290000
         WinLeft=0.212148
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
         OnKeyEvent=cb_MeleeComBox_CI.InternalOnKeyEvent
     End Object
     cb_Melee_CI=GUIComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.cb_MeleeComBox_CI'
	 
     Begin Object Class=GUIComboBox Name=cb_SideArmBox
         MaxVisibleItems=16
         Hint="Quick list of sidearms."
         WinTop=0.250000
         WinLeft=0.402930
         WinWidth=0.196094
         WinHeight=0.040000
         TabOrder=0
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
         OnKeyEvent=cb_SideArmBox.InternalOnKeyEvent
     End Object
     cb_SideArm=GUIComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.cb_SideArmBox'
	 
     Begin Object Class=GUIComboBox Name=cb_SideArmBox_LI
         MaxVisibleItems=16
         Hint="Sidearm layouts."
         WinTop=0.290000
         WinLeft=0.392930
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
         OnKeyEvent=cb_SideArmBox_LI.InternalOnKeyEvent
     End Object
     cb_SideArm_LI=GUIComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.cb_SideArmBox_LI'
	 
     Begin Object Class=GUIComboBox Name=cb_SideArmBox_CI
         MaxVisibleItems=16
         Hint="Sidearm camos."
         WinTop=0.290000
         WinLeft=0.512930
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
         OnKeyEvent=cb_SideArmBox_CI.InternalOnKeyEvent
     End Object
     cb_SideArm_CI=GUIComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.cb_SideArmBox_CI'

     Begin Object Class=GUIComboBox Name=cb_PrimaryComBox
         MaxVisibleItems=16
         Hint="Quick list of primary weapons."
         WinTop=0.550000
         WinLeft=0.251563
         WinWidth=0.196094
         WinHeight=0.040000
         TabOrder=0
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
         OnKeyEvent=cb_PrimaryComBox.InternalOnKeyEvent
     End Object
     cb_Primary=GUIComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.cb_PrimaryComBox'

     Begin Object Class=GUIComboBox Name=cb_PrimaryComBox_LI
         MaxVisibleItems=16
         Hint="Primary Weapon layouts."
         WinTop=0.590000
         WinLeft=0.241563
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
         OnKeyEvent=cb_PrimaryComBox_LI.InternalOnKeyEvent
     End Object
     cb_Primary_LI=GUIComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.cb_PrimaryComBox_LI'

     Begin Object Class=GUIComboBox Name=cb_PrimaryComBox_CI
         MaxVisibleItems=16
         Hint="Primary Weapon camos."
         WinTop=0.590000
         WinLeft=0.361563
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
         OnKeyEvent=cb_PrimaryComBox_CI.InternalOnKeyEvent
     End Object
     cb_Primary_CI=GUIComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.cb_PrimaryComBox_CI'

     Begin Object Class=GUIComboBox Name=cb_SecondaryComBox
         MaxVisibleItems=16
         Hint="Quick list of secondary weapons."
         WinTop=0.550000
         WinLeft=0.550977
         WinWidth=0.196094
         WinHeight=0.040000
         TabOrder=0
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
         OnKeyEvent=cb_SecondaryComBox.InternalOnKeyEvent
     End Object
     cb_Secondary=GUIComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.cb_SecondaryComBox'

     Begin Object Class=GUIComboBox Name=cb_SecondaryComBox_LI
         MaxVisibleItems=16
         Hint="Secondary weapon layouts."
         WinTop=0.590000
         WinLeft=0.540977
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
         OnKeyEvent=cb_SecondaryComBox_LI.InternalOnKeyEvent
     End Object
     cb_Secondary_LI=GUIComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.cb_SecondaryComBox_LI'

     Begin Object Class=GUIComboBox Name=cb_SecondaryComBox_CI
         MaxVisibleItems=16
         Hint="Secondary weapon camos."
         WinTop=0.590000
         WinLeft=0.660977
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
         OnKeyEvent=cb_SecondaryComBox_CI.InternalOnKeyEvent
     End Object
     cb_Secondary_CI=GUIComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.cb_SecondaryComBox_CI'

     Begin Object Class=GUIComboBox Name=cb_GrenadeComBox
         MaxVisibleItems=16
         Hint="Quick list of grenades and traps."
         WinTop=0.250000
         WinLeft=0.702148
         WinWidth=0.196094
         WinHeight=0.040000
         TabOrder=0
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
         OnKeyEvent=cb_GrenadeComBox.InternalOnKeyEvent
     End Object
     cb_Grenade=GUIComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.cb_GrenadeComBox'

     Begin Object Class=GUIComboBox Name=cb_GrenadeComBox_LI
         MaxVisibleItems=16
         Hint="Grenade layouts."
         WinTop=0.290000
         WinLeft=0.692148
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
         OnKeyEvent=cb_GrenadeComBox_LI.InternalOnKeyEvent
     End Object
     cb_Grenade_LI=GUIComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.cb_GrenadeComBox_LI'

     Begin Object Class=GUIComboBox Name=cb_GrenadeComBox_CI
         MaxVisibleItems=16
         Hint="Grenade layouts."
         WinTop=0.290000
         WinLeft=0.812148
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
         OnKeyEvent=cb_GrenadeComBox_CI.InternalOnKeyEvent
     End Object
     cb_Grenade_CI=GUIComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.cb_GrenadeComBox_CI'

     Begin Object Class=moComboBox Name=co_PresetsCB
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Presets"
         OnCreateComponent=co_PresetsCB.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Choose a preset replacements configuration, or type a new preset name here and click 'Save' to make the current configuration a new preset."
         WinTop=0.640000
         WinLeft=0.630000
         WinWidth=0.250000
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
     End Object
     cb_Presets=moComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.co_PresetsCB'

     Begin Object Class=GUIImage Name=ImageBoxMelee
         Image=Texture'2K4Menus.NewControls.ScrollGripWatched'
         ImageStyle=ISTY_Stretched
         WinTop=0.030000
         WinLeft=0.087500
         WinWidth=0.225000
         WinHeight=0.240000
         RenderWeight=0.002000
     End Object
     Box_Melee=GUIImage'BallisticProV55.BallisticOutfittingWeaponsTab.ImageBoxMelee'

     Begin Object Class=GUIImage Name=ImageBoxSideArm
         Image=Texture'2K4Menus.NewControls.ScrollGripWatched'
         ImageStyle=ISTY_Stretched
         WinTop=0.030000
         WinLeft=0.387500
         WinWidth=0.225000
         WinHeight=0.240000
         RenderWeight=0.002000
     End Object
     Box_SideArm=GUIImage'BallisticProV55.BallisticOutfittingWeaponsTab.ImageBoxSideArm'

     Begin Object Class=GUIImage Name=ImageBoxPrimary
         Image=Texture'2K4Menus.NewControls.ScrollGripWatched'
         ImageStyle=ISTY_Stretched
         WinTop=0.337500
         WinLeft=0.237500
         WinWidth=0.225000
         WinHeight=0.240000
         RenderWeight=0.002000
     End Object
     Box_Primary=GUIImage'BallisticProV55.BallisticOutfittingWeaponsTab.ImageBoxPrimary'

     Begin Object Class=GUIImage Name=ImageBoxSecondary
         Image=Texture'2K4Menus.NewControls.ScrollGripWatched'
         ImageStyle=ISTY_Stretched
         WinTop=0.337500
         WinLeft=0.537500
         WinWidth=0.225000
         WinHeight=0.240000
         RenderWeight=0.002000
     End Object
     Box_Secondary=GUIImage'BallisticProV55.BallisticOutfittingWeaponsTab.ImageBoxSecondary'

     Begin Object Class=GUIImage Name=ImageBoxGrenade
         Image=Texture'2K4Menus.NewControls.ScrollGripWatched'
         ImageStyle=ISTY_Stretched
         WinTop=0.030000
         WinLeft=0.687500
         WinWidth=0.225000
         WinHeight=0.240000
         RenderWeight=0.002000
     End Object
     Box_Grenade=GUIImage'BallisticProV55.BallisticOutfittingWeaponsTab.ImageBoxGrenade'

    /*
     Begin Object Class=GUIImage Name=MeleeBackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.050000
         WinLeft=0.100000
         WinWidth=0.200000
         WinHeight=0.240000
         RenderWeight=0.003000
     End Object
     MeleeBack=GUIImage'BallisticProV55.BallisticOutfittingWeaponsTab.MeleeBackImage'

     Begin Object Class=GUIImage Name=SideArmBackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.050000
         WinLeft=0.400000
         WinWidth=0.200000
         WinHeight=0.200000
         RenderWeight=0.003000
     End Object
     SideArmBack=GUIImage'BallisticProV55.BallisticOutfittingWeaponsTab.SideArmBackImage'

     Begin Object Class=GUIImage Name=PrimaryBackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.350000
         WinLeft=0.250000
         WinWidth=0.200000
         WinHeight=0.200000
         RenderWeight=0.003000
     End Object
     PrimaryBack=GUIImage'BallisticProV55.BallisticOutfittingWeaponsTab.PrimaryBackImage'

     Begin Object Class=GUIImage Name=SecondaryBackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.350000
         WinLeft=0.550000
         WinWidth=0.200000
         WinHeight=0.200000
         RenderWeight=0.003000
     End Object
     SecondaryBack=GUIImage'BallisticProV55.BallisticOutfittingWeaponsTab.SecondaryBackImage'

     Begin Object Class=GUIImage Name=GrenadeBackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.050000
         WinLeft=0.700000
         WinWidth=0.200000
         WinHeight=0.200000
         RenderWeight=0.003000
     End Object
     GrenadeBack=GUIImage'BallisticProV55.BallisticOutfittingWeaponsTab.GrenadeBackImage'
*/
     Begin Object Class=GUIButton Name=BSavePresetButton
         Caption="SAVE"
         Hint="Saves the current configuration as a new preset."
         WinTop=0.640000
         WinLeft=0.115500
         WinWidth=0.257000
         WinHeight=0.065000
         TabOrder=0
         OnClick=BallisticOutfittingWeaponsTab.InternalOnClick
         OnKeyEvent=BSavePresetButton.InternalOnKeyEvent
     End Object
     BSavePreset=GUIButton'BallisticProV55.BallisticOutfittingWeaponsTab.BSavePresetButton'

     Begin Object Class=GUILabel Name=l_Receivinglabel
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         FontScale=FNS_Large
         WinTop=0.087000
         WinLeft=0.050000
         WinWidth=0.900000
         WinHeight=0.040000
     End Object
     l_Receiving=GUILabel'BallisticProV55.BallisticOutfittingWeaponsTab.l_Receivinglabel'

     SavedLoadouts(0)=(PresetName="DEFAULT",Weapons[0]="BallisticProV55.A909SkrithBlades",Layouts[0]=0,Camos[0]=0,Weapons[1]="BallisticProV55.A42SkrithPistol",Layouts[1]=0,Camos[1]=0,Weapons[2]="BallisticProV55.A73SkrithRifle",Layouts[2]=0,Camos[2]=0,Weapons[3]="BallisticProV55.A73SkrithRifle",Layouts[3]=0,Camos[3]=0,Weapons[4]="BallisticProV55.NRP57Grenade",Layouts[4]=0,Camos[4]=0)
     SavedLoadouts(1)=(PresetName="DEFAULT2",Weapons[0]="BallisticProV55.A909SkrithBlades",Layouts[0]=0,Camos[0]=0,Weapons[1]="BallisticProV55.A42SkrithPistol",Layouts[1]=0,Camos[1]=0,Weapons[2]="BallisticProV55.A73SkrithRifle",Layouts[2]=0,Camos[2]=0,Weapons[3]="BallisticProV55.A73SkrithRifle",Layouts[3]=0,Camos[3]=0,Weapons[4]="BallisticProV55.NRP57Grenade",Layouts[4]=0,Camos[4]=0)
     SavedLoadouts(2)=(PresetName="DEFAULT3",Weapons[0]="BallisticProV55.A909SkrithBlades",Layouts[0]=0,Camos[0]=0,Weapons[1]="BallisticProV55.A42SkrithPistol",Layouts[1]=0,Camos[1]=0,Weapons[2]="BallisticProV55.A73SkrithRifle",Layouts[2]=0,Camos[2]=0,Weapons[3]="BallisticProV55.A73SkrithRifle",Layouts[3]=0,Camos[3]=0,Weapons[4]="BallisticProV55.NRP57Grenade",Layouts[4]=0,Camos[4]=0)
     SavedLoadouts(3)=(PresetName="DEFAULT4",Weapons[0]="BallisticProV55.A909SkrithBlades",Layouts[0]=0,Camos[0]=0,Weapons[1]="BallisticProV55.A42SkrithPistol",Layouts[1]=0,Camos[1]=0,Weapons[2]="BallisticProV55.A73SkrithRifle",Layouts[2]=0,Camos[2]=0,Weapons[3]="BallisticProV55.A73SkrithRifle",Layouts[3]=0,Camos[3]=0,Weapons[4]="BallisticProV55.NRP57Grenade",Layouts[4]=0,Camos[4]=0)
     SavedLoadouts(4)=(PresetName="DEFAULT5",Weapons[0]="BallisticProV55.A909SkrithBlades",Layouts[0]=0,Camos[0]=0,Weapons[1]="BallisticProV55.A42SkrithPistol",Layouts[1]=0,Camos[1]=0,Weapons[2]="BallisticProV55.A73SkrithRifle",Layouts[2]=0,Camos[2]=0,Weapons[3]="BallisticProV55.A73SkrithRifle",Layouts[3]=0,Camos[3]=0,Weapons[4]="BallisticProV55.NRP57Grenade",Layouts[4]=0,Camos[4]=0)
     QuickListText="QuickList"
     ReceivingText(0)="Receiving..."
     ReceivingText(1)="Loading..."
}
