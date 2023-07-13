//=============================================================================
// BallisticTeamOutfittingMenu.
//
// Menu for selecting weapon loadout. Consists of several categories, user can
// pick what weapon they want for each category (e.g. melee, sidearm, grenade)
//
// by Nolan "Dark Carnivour" Richert.
// Modified by Azarael
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticTeamOutfittingMenu extends UT2K4GUIPage config(BallisticProV55);

// basic menu
var Automated GUIImage          MyBack;
var automated GUIHeader         MyHeader;
var automated GUIImage          Box_Melee, Box_SideArm, Box_Primary, Box_Secondary, Box_Grenade;
var automated GUILoadOutItem    Item_Melee, Item_SideArm, Item_Primary, Item_Secondary, Item_Grenade;
var automated GUIComboBox	 	cb_Melee_LI, cb_SideArm_LI, cb_Primary_LI, cb_Secondary_LI, cb_Grenade_LI;
var automated GUIComboBox	 	cb_Melee_CI, cb_SideArm_CI, cb_Primary_CI, cb_Secondary_CI, cb_Grenade_CI;
var Automated GUIButton         BDone, BCancel, BSavePreset;
var automated moComboBox		cb_Presets;
var automated GUILabel	        l_Receiving;
var int                         ActiveIndex;
var bool                        bWeaponsLoaded;

// select menu
//var automated GUIListBox	    lb_Melee, lb_SideArm, lb_Primary, lb_Secondary, lb_Grenade;
//var Automated GUIImage		    Box_WeapList, Pic_Weapon, Box_WeapIcon;
//var automated GUILabel   	    l_WeapTitle;
//var automated GUIScrollTextBox	tb_Desc;

struct LoadoutWeapons
{
    var string PresetName;
	var string Weapons[5];
	var int Layouts[5];
	var int Camos[5];
};

var config array<LoadoutWeapons>		SavedLoadouts[5];
var config int                          CurrentIndex;

var config bool                         bInitialized;

var int NumPresets;

var() localized string QuickListText;

var localized string ReceivingText[2];

var ClientTeamOutfittingInterface COI;	// The ClientOutfittingInterface actor we can use to comunicate with the mutator

// may need to replace with contents of showpanel
function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    local int i;

    Super.InitComponent(MyController, MyOwner);

    if (!bInitialized)
	{
		for(i = 0 ; i < 5; i++)
		{
			SavedLoadouts[0].Weapons[i] = class'Mut_Outfitting'.default.LoadOut[i];
			SavedLoadouts[0].Layouts[i] = class'Mut_Outfitting'.default.Layout[i];
			SavedLoadouts[0].Camos[i] = class'Mut_Outfitting'.default.Camo[i];
		}
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
	}
}

function SetupCOI(ClientTeamOutfittingInterface newCOI)
{
	COI = newCOI;
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

/*
//======================================================================
// InitWeaponLists
//
// Sets up the weapon list with the dividers, then adds weapons in after them by incrementing
// indices to get the new position. Adds the player's saved inventory to the inventory box.
// Won't add a weapon if it doesn't meet team requirements.
//
// Azarael: Uses Cache instead of DynamicLoadObject on the entire list, which caused 
// severe load lag.
//======================================================================
simulated function InitWeaponLists ()
{
	local class<actor> a;
	local class<Weapon> Weap;
	local class<ConflictItem> CI;
	local int i, lastIndex;
	local BC_WeaponInfoCache.WeaponInfo WI;
	
	Log("InitWeaponLists");

	l_Loading.Caption = "";
	l_Loading.Hide();

	lb_Weapons.List.Clear();

	lastIndex = -1;
	
	//Weapons here will be loaded explicitly if they're selected in the list, via the Extra string data.
	// The Full Inventory List is already sorted by inventory group and Conflict item status.
	for (i=0; i < CLRI.FullInventoryList.length; i++)
	{
        if (LoadWIFromCache(CLRI.FullInventoryList[i], WI))
        {
            if (WI.InventoryGroup != lastIndex)
            {
                lastIndex = WI.InventoryGroup;
                lb_Weapons.List.Add(class'BallisticWeaponClassInfo'.static.GetHeading(lastIndex),, "Weapon Category", true);
            }
            
            lb_Weapons.List.Add(WI.ItemName, , CLRI.FullInventoryList[i]);
        }
	}
}

//===========================================================================
// Update the boxes when the weapon list changes
//
// Azarael: Uses Cache.
//===========================================================================
function UpdateWeaponIconAndDesc()
{
	local class<BallisticWeapon> BW;
	
    l_WeapTitle.Caption = lb_Weapons.List.SelectedText();
    
    //Section header.
    if (lb_Weapons.List.IsSection())
    {
        tb_Desc.SetContent(class'BallisticWeaponClassInfo'.static.GetClassDescription(lb_Weapons.List.SelectedText()));
        Pic_Weapon.Image = None;
        return;
    }

    //Check for items which have already been loaded.
    if (lb_Weapons.List.GetObject() != None)
    {
        if (class<BallisticWeapon>(lb_Weapons.List.GetObject()) != None)
        {
            Pic_Weapon.Image = class<BallisticWeapon>(lb_Weapons.List.GetObject()).default.BigIconMaterial;
            tb_Desc.SetContent(class<BallisticWeapon>(lb_Weapons.List.GetObject()).static.GetShortManual());
            return;
        }
        if (class<ConflictItem>(lb_Weapons.List.GetObject()) != None)
        {
            Pic_Weapon.Image = class<ConflictItem>(lb_Weapons.List.GetObject()).default.Icon;
            tb_Desc.SetContent(class<ConflictItem>(lb_Weapons.List.GetObject()).default.Description);
            return;
        }
        return;
    }
    
    //Item not loaded. Load it and add it as the Object for the weapons list's current position.
    if (lb_Weapons.List.GetExtra() != "")
    {
        BW = class<BallisticWeapon>(DynamicLoadObject(lb_Weapons.List.GetExtra(), class'Class'));
        if (BW != None)
        {
            Pic_Weapon.Image = BW.default.BigIconMaterial;
            tb_Desc.SetContent(BW.static.GetShortManual());
            lb_Weapons.List.SetObjectAtIndex(lb_Weapons.List.Index, BW);
        }
    }	
}
*/

function LoadWeapons()
{
	local int i;
	local string IC, ICN;
	local Material IMat;
	local IntBox ICrds;

	// Load the weapons into their GUILoadOutItems

	for(i = 0 ;i < COI.GroupLength(0); i++)
	{
		if (GetItemInfo(0, i, IC, IMat, ICN, ICrds))
		{
			Item_Melee.AddItem(IC, IMat, ICN, ICrds);
			Item_Melee.SetItem(SavedLoadOuts[CurrentIndex].Weapons[0]);
			LoadLayouts(0, Item_Melee.Index, cb_Melee_LI, SavedLoadOuts[CurrentIndex].Layouts[0]);
			LoadCamos(0, cb_Melee_LI.getIndex(), Item_Melee.Index, cb_Melee_CI, SavedLoadOuts[CurrentIndex].Camos[0]);
   		}
	}

	for(i = 0; i < COI.GroupLength(1); i++)
	{
		if (GetItemInfo(1, i, IC, IMat, ICN, ICrds))
		{
			Item_SideArm.AddItem(IC, IMat, ICN, ICrds);
			Item_SideArm.SetItem(SavedLoadOuts[CurrentIndex].Weapons[1]);
			LoadLayouts(1, Item_SideArm.Index, cb_SideArm_LI, SavedLoadOuts[CurrentIndex].Layouts[1]);
			LoadCamos(1, cb_SideArm_LI.getIndex(), Item_SideArm.Index, cb_SideArm_CI, SavedLoadOuts[CurrentIndex].Camos[1]);
   		}
	}

	for(i=0;i<COI.GroupLength(2);i++)
	{
		if (GetItemInfo(2, i, IC, IMat, ICN, ICrds))
		{
			Item_Primary.AddItem(IC, IMat, ICN, ICrds);
			Item_Primary.SetItem(SavedLoadOuts[CurrentIndex].Weapons[2]);
			LoadLayouts(2, Item_Primary.Index, cb_Primary_LI, SavedLoadOuts[CurrentIndex].Layouts[2]);
			LoadCamos(2, cb_Primary_LI.getIndex(), Item_Primary.Index, cb_Primary_CI, SavedLoadOuts[CurrentIndex].Camos[2]);
	   	}
	}

	for(i=0;i<COI.GroupLength(3);i++)
	{
		if (GetItemInfo(3, i, IC, IMat, ICN, ICrds))
		{
			Item_Secondary.AddItem(IC, IMat, ICN, ICrds);
			Item_Secondary.SetItem(SavedLoadOuts[CurrentIndex].Weapons[3]);
			LoadLayouts(3, Item_Secondary.Index, cb_Secondary_LI, SavedLoadOuts[CurrentIndex].Layouts[3]);
			LoadCamos(3, cb_Secondary_LI.getIndex(), Item_Secondary.Index, cb_Secondary_CI, SavedLoadOuts[CurrentIndex].Camos[3]);
   		}
	}

	for(i=0;i<COI.GroupLength(4);i++)
	{
		if (GetItemInfo(4, i, IC, IMat, ICN, ICrds))
		{
			Item_Grenade.AddItem(IC, IMat, ICN, ICrds);
			Item_Grenade.SetItem(SavedLoadOuts[CurrentIndex].Weapons[4]);
			LoadLayouts(4, Item_Grenade.Index, cb_Grenade_LI, SavedLoadOuts[CurrentIndex].Layouts[4]);
			LoadCamos(4, cb_Grenade_LI.getIndex(), Item_Grenade.Index, cb_Grenade_CI, SavedLoadOuts[CurrentIndex].Camos[4]);
   		}
	}

	//Load presets
	for(i=0;i<5;i++) //fixme
	    cb_Presets.AddItem(SavedLoadouts[i].PresetName ,,string(i));
	
	cb_Presets.SetIndex(CurrentIndex);
	
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

// =========================================================================
// 						Data Load Functions
// =========================================================================
//give this function a gun, grab an array of layouts from cache, add each value to the combobox
function bool LoadLayouts(int GroupIndex, int Index, GUIComboBox LayoutComboBox, optional int LayoutIndex)
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
	
	if (LayoutIndex < LayoutComboBox.ItemCount())
		LayoutComboBox.setIndex(LayoutIndex);
	
	return true;
}

//give this function a gun, grab an array of layouts from cache, add each value to the combobox
//Unlike the load layouts function above, this one will try and read your last camo index to find which value to default
//This is required due to the allowed camos changing for various layouts
function bool LoadCamos(int GroupIndex, int LayoutIndex, int Index, GUIComboBox CamoComboBox, optional int CamoIndex)
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
		if (CamoIndex < CamoComboBox.ItemCount())
			CamoComboBox.setIndex(CamoIndex);
	}
	else
	{
		for (i = 0; i < AllowedCamos.Length; i++)
		{
			CamoComboBox.AddItem(BW.default.ParamsClasses[GameStyleIndex].default.Camos[AllowedCamos[i]].CamoName,, String(BW.default.ParamsClasses[GameStyleIndex].default.Camos[AllowedCamos[i]].Index));
			if (CamoIndex == BW.default.ParamsClasses[GameStyleIndex].default.Camos[AllowedCamos[i]].Index) //these damn boxes changing sizes
				CamoComboBox.setIndex(i);
		}
	}
	
	if (CamoComboBox.ItemCount() == 0)
		CamoComboBox.AddItem("None",, "255");
	
	if (CamoComboBox.ItemCount() > 1 && !class'BallisticReplicationInfo'.default.bNoRandomCamo)
	{
		CamoComboBox.AddItem("Random",, "255");
		if (CamoIndex == 255) //these damn boxes changing sizes
			CamoComboBox.setIndex(CamoComboBox.ItemCount()-1);
	}
	
	return true;
}

// =========================================================================
// 						Save Data
// =========================================================================
function SaveSettings()
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
			class'Mut_TeamOutfitting'.default.LoadOut[0] = Item_Melee.Items[Item_Melee.Index].Text;
			class'Mut_TeamOutfitting'.default.Layout[0] = cb_Melee_LI.getIndex();
			class'Mut_TeamOutfitting'.default.Camo[0] = int(cb_Melee_CI.getExtra());
		}
		if (Item_SideArm.Items.length > Item_SideArm.Index)
		{
			class'Mut_TeamOutfitting'.default.LoadOut[1] = Item_SideArm.Items[Item_SideArm.Index].Text;
			class'Mut_TeamOutfitting'.default.Layout[1] = cb_SideArm_LI.getIndex();
			class'Mut_TeamOutfitting'.default.Camo[1] = int(cb_SideArm_CI.getExtra());
		}
		if (Item_Primary.Items.length > Item_Primary.Index)
		{
			class'Mut_TeamOutfitting'.default.LoadOut[2] = Item_Primary.Items[Item_Primary.Index].Text;
			class'Mut_TeamOutfitting'.default.Layout[2] = cb_Primary_LI.getIndex();
			class'Mut_TeamOutfitting'.default.Camo[2] = int(cb_Primary_CI.getExtra());
		}
		if (Item_Secondary.Items.length > Item_Secondary.Index)
		{
			class'Mut_TeamOutfitting'.default.LoadOut[3] = Item_Secondary.Items[Item_Secondary.Index].Text;
			class'Mut_TeamOutfitting'.default.Layout[3] = cb_Secondary_LI.getIndex();
			class'Mut_TeamOutfitting'.default.Camo[3] = int(cb_Secondary_CI.getExtra());
		}
		if (Item_Grenade.Items.length > Item_Grenade.Index)
		{
			class'Mut_TeamOutfitting'.default.LoadOut[4] = Item_Grenade.Items[Item_Grenade.Index].Text;
			class'Mut_TeamOutfitting'.default.Layout[4] = cb_Grenade_LI.getIndex();
			class'Mut_TeamOutfitting'.default.Camo[4] = int(cb_Grenade_CI.getExtra());
		}
    
    if (cb_Presets.GetIndex() >= 0)
        CurrentIndex=cb_Presets.GetIndex();
    
    SaveConfig();
    class'Mut_TeamOutfitting'.static.StaticSaveConfig();
    
    //COI.LoadoutChanged(class'Mut_TeamOutfitting'.default.LoadOut);
}

function WeaponSelectClosed( optional bool bCancelled )
{
	local string str;
	local array<string> loadoutData;

	if ( bCancelled )
		return;

	str = Controller.ActivePage.GetDataString();
	Split(str, "|", loadoutData);

    switch (ActiveIndex)
    {
        case 0:
            Item_Melee.SetItem(loadoutData[0]);
			LoadLayouts(0, Item_Melee.Index, cb_Melee_LI, int(loadoutData[1]));
			LoadCamos(0, cb_Melee_LI.getIndex(), Item_Melee.Index, cb_Melee_CI, int(loadoutData[2]));
            break;
        case 1:
            Item_SideArm.SetItem(loadoutData[0]);
			LoadLayouts(1, Item_SideArm.Index, cb_SideArm_LI, int(loadoutData[1]));
			LoadCamos(1, cb_SideArm_LI.getIndex(), Item_SideArm.Index, cb_SideArm_CI, int(loadoutData[2]));
            break;
        case 2:
            Item_Primary.SetItem(loadoutData[0]);
			LoadLayouts(2, Item_Primary.Index, cb_Primary_LI, int(loadoutData[1]));
			LoadCamos(2, cb_Primary_LI.getIndex(), Item_Primary.Index, cb_Primary_CI, int(loadoutData[2]));
            break;
        case 3:
            Item_Secondary.SetItem(loadoutData[0]);
			LoadLayouts(3, Item_Secondary.Index, cb_Secondary_LI, int(loadoutData[1]));
			LoadCamos(3, cb_Secondary_LI.getIndex(), Item_Secondary.Index, cb_Secondary_CI, int(loadoutData[2]));
            break;
        case 4:
            Item_Grenade.SetItem(loadoutData[0]);
			LoadLayouts(4, Item_Grenade.Index, cb_Grenade_LI, int(loadoutData[1]));
			LoadCamos(4, cb_Grenade_LI.getIndex(), Item_Grenade.Index, cb_Grenade_CI, int(loadoutData[2]));
            break;
    }
}

function InternalOnChange(GUIComponent Sender)
{
	if (COI == None || !COI.bWeaponsReady)
		return;
		
    if (Sender == cb_Presets && cb_Presets.GetExtra() != "") //Grab the preset data
	{
		Item_Melee.SetItem(SavedLoadOuts[cb_Presets.GetIndex()].Weapons[0]);
		LoadLayouts(0, Item_Melee.Index, cb_Melee_LI, SavedLoadOuts[cb_Presets.GetIndex()].Layouts[0]);
		LoadCamos(0, cb_Melee_LI.getIndex(), Item_Melee.Index, cb_Melee_CI, SavedLoadOuts[cb_Presets.GetIndex()].Camos[0]);
		
		Item_SideArm.SetItem(SavedLoadOuts[cb_Presets.GetIndex()].Weapons[1]);
		LoadLayouts(1, Item_SideArm.Index, cb_SideArm_LI, SavedLoadOuts[cb_Presets.GetIndex()].Layouts[1]);
		LoadCamos(1, cb_SideArm_LI.getIndex(), Item_SideArm.Index, cb_SideArm_CI, SavedLoadOuts[cb_Presets.GetIndex()].Camos[1]);
		
		Item_Primary.SetItem(SavedLoadOuts[cb_Presets.GetIndex()].Weapons[2]);
		LoadLayouts(2, Item_Primary.Index, cb_Primary_LI, SavedLoadOuts[cb_Presets.GetIndex()].Layouts[2]);
		LoadCamos(2, cb_Primary_LI.getIndex(), Item_Primary.Index, cb_Primary_CI, SavedLoadOuts[cb_Presets.GetIndex()].Camos[2]);
		
		Item_Secondary.SetItem(SavedLoadOuts[cb_Presets.GetIndex()].Weapons[3]);
		LoadLayouts(3, Item_Secondary.Index, cb_Secondary_LI, SavedLoadOuts[cb_Presets.GetIndex()].Layouts[3]);
		LoadCamos(3, cb_Secondary_LI.getIndex(), Item_Secondary.Index, cb_Secondary_CI, SavedLoadOuts[cb_Presets.GetIndex()].Camos[3]);
		
		Item_Grenade.SetItem(SavedLoadOuts[cb_Presets.GetIndex()].Weapons[4]);
		LoadLayouts(4, Item_Grenade.Index, cb_Grenade_LI, SavedLoadOuts[cb_Presets.GetIndex()].Layouts[4]);
		LoadCamos(4, cb_Grenade_LI.getIndex(), Item_Grenade.Index, cb_Grenade_CI, SavedLoadOuts[cb_Presets.GetIndex()].Camos[4]);
	}
	else if (Sender == cb_Melee_LI )
	{
		LoadCamos(0, cb_Melee_LI.getIndex(), Item_Melee.Index, cb_Melee_CI);
	}
	else if (Sender == cb_SideArm_LI )
	{
		LoadCamos(1, cb_SideArm_LI.getIndex(), Item_SideArm.Index, cb_SideArm_CI);
	}
	else if (Sender == cb_Primary_LI )
	{
		LoadCamos(2, cb_Primary_LI.getIndex(), Item_Primary.Index, cb_Primary_CI);
	}
	else if (Sender == cb_Secondary_LI )
	{
		LoadCamos(3, cb_Secondary_LI.getIndex(), Item_Secondary.Index, cb_Secondary_CI);
	}
	else if (Sender == cb_Grenade_LI )
	{
		LoadCamos(4, cb_Grenade_LI.getIndex(), Item_Grenade.Index, cb_Grenade_CI);
	}	
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
	if (Key == 0x0D && State == 3)	// Enter
		return InternalOnClick(BDone);
	else if (Key == 0x1B && State == 3)	// Escape
		return InternalOnClick(BCancel);

	return false;
}

function bool InternalOnClick(GUIComponent Sender)
{
    if (Sender == Item_Melee)
    {        
        Controller.OpenMenu("BallisticProV55.BallisticTeamOutfittingWeaponSelect");
	    
        if (BallisticTeamOutfittingWeaponSelect(Controller.ActivePage) != None)
        {
		    BallisticTeamOutfittingWeaponSelect(Controller.ActivePage).LoadWeapons(COI, 0);
            ActiveIndex = 0;
            Controller.ActivePage.OnClose = WeaponSelectClosed;
        }

        return true;
    }

    if (Sender == Item_SideArm)
    {        
        Controller.OpenMenu("BallisticProV55.BallisticTeamOutfittingWeaponSelect");
	    
        if (BallisticTeamOutfittingWeaponSelect(Controller.ActivePage) != None)
        {
		    BallisticTeamOutfittingWeaponSelect(Controller.ActivePage).LoadWeapons(COI, 1);
            ActiveIndex = 1;
            Controller.ActivePage.OnClose = WeaponSelectClosed;
        }

        return true;
    }

    if (Sender == Item_Primary)
    {        
        Controller.OpenMenu("BallisticProV55.BallisticTeamOutfittingWeaponSelect");
	    
        if (BallisticTeamOutfittingWeaponSelect(Controller.ActivePage) != None)
        {
		    BallisticTeamOutfittingWeaponSelect(Controller.ActivePage).LoadWeapons(COI, 2);
            ActiveIndex = 2;
            Controller.ActivePage.OnClose = WeaponSelectClosed;
        }

        return true;
    }

    if (Sender == Item_Secondary)
    {        
        Controller.OpenMenu("BallisticProV55.BallisticTeamOutfittingWeaponSelect");
	    
        if (BallisticTeamOutfittingWeaponSelect(Controller.ActivePage) != None)
        {
		    BallisticTeamOutfittingWeaponSelect(Controller.ActivePage).LoadWeapons(COI, 3);
            ActiveIndex = 3;
            Controller.ActivePage.OnClose = WeaponSelectClosed;
        }

        return true;
    }

    if (Sender == Item_Grenade)
    {        
        Controller.OpenMenu("BallisticProV55.BallisticTeamOutfittingWeaponSelect");
	    
        if (BallisticTeamOutfittingWeaponSelect(Controller.ActivePage) != None)
        {
		    BallisticTeamOutfittingWeaponSelect(Controller.ActivePage).LoadWeapons(COI, 4);
            ActiveIndex = 4;
            Controller.ActivePage.OnClose = WeaponSelectClosed;
        }
        return true;
    }

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
        return true;
	}
	if (Sender==BCancel) // CANCEL
    {
		Controller.CloseMenu();
        return true;
    }

	if (Sender==BDone) // DONE
	{
		SaveSettings();
		COI.LoadoutChanged(class'Mut_TeamOutfitting'.default.LoadOut);
		Controller.CloseMenu();
        return true;
	}
	return true;
}

defaultproperties
{
     Begin Object Class=GUIImage Name=BackImage
         Image=Texture'2K4Menus.NewControls.Display95'
         ImageStyle=ISTY_Stretched
         WinTop=0.125000
         WinLeft=0.050000
         WinWidth=0.900000
         WinHeight=0.675000
         RenderWeight=0.001000
     End Object
     MyBack=GUIImage'BallisticProV55.BallisticTeamOutfittingMenu.BackImage'

 Begin Object Class=GUILoadOutItem Name=MeleeImage
         NAImage=Texture'BW_Core_WeaponTex.Icons.BigIcon_NA'
         Caption="Melee Weapon"
         WinTop=0.209
         WinLeft=0.100000
         WinWidth=0.200000
         WinHeight=0.133333
         OnRendered=MeleeImage.InternalOnDraw
         OnClick=InternalOnClick
         OnRightClick=InternalOnClick
     End Object
     Item_Melee=GUILoadOutItem'BallisticProV55.BallisticTeamOutfittingMenu.MeleeImage'

     Begin Object Class=GUILoadOutItem Name=SideArmImage
         NAImage=Texture'BW_Core_WeaponTex.Icons.BigIcon_NA'
         Caption="SideArm"
         WinTop=0.209
         WinLeft=0.400000
         WinWidth=0.200000
         WinHeight=0.133333
         OnRendered=SideArmImage.InternalOnDraw
         OnClick=InternalOnClick
         OnRightClick=InternalOnClick
     End Object
     Item_SideArm=GUILoadOutItem'BallisticProV55.BallisticTeamOutfittingMenu.SideArmImage'

     Begin Object Class=GUILoadOutItem Name=PrimaryImage
         NAImage=Texture'BW_Core_WeaponTex.Icons.BigIcon_NA'
         Caption="Primary Weapon"
         WinTop=0.453
         WinLeft=0.250000
         WinWidth=0.200000
         WinHeight=0.133333
         OnRendered=PrimaryImage.InternalOnDraw
         OnClick=InternalOnClick
         OnRightClick=InternalOnClick
     End Object
     Item_Primary=GUILoadOutItem'BallisticProV55.BallisticTeamOutfittingMenu.PrimaryImage'

     Begin Object Class=GUILoadOutItem Name=SecondaryImage
         NAImage=Texture'BW_Core_WeaponTex.Icons.BigIcon_NA'
         Caption="Secondary Weapon"
         WinTop=0.453
         WinLeft=0.550000
         WinWidth=0.200000
         WinHeight=0.133333
         OnRendered=SecondaryImage.InternalOnDraw
         OnClick=InternalOnClick
         OnRightClick=InternalOnClick
     End Object
     Item_Secondary=GUILoadOutItem'BallisticProV55.BallisticTeamOutfittingMenu.SecondaryImage'

     Begin Object Class=GUILoadOutItem Name=GrenadeImage
         NAImage=Texture'BW_Core_WeaponTex.Icons.BigIcon_NA'
         Caption="Grenades"
         WinTop=0.209
         WinLeft=0.700000
         WinWidth=0.200000
         WinHeight=0.133333
         OnRendered=GrenadeImage.InternalOnDraw
         OnClick=InternalOnClick
         OnRightClick=InternalOnClick
     End Object
     Item_Grenade=GUILoadOutItem'BallisticProV55.BallisticTeamOutfittingMenu.GrenadeImage'

     Begin Object Class=GUIImage Name=ImageBoxMelee
         Image=Texture'2K4Menus.NewControls.ScrollGripWatched'
         ImageStyle=ISTY_Stretched
         WinTop=0.205
         WinLeft=0.11
         WinHeight=0.14
         WinWidth=0.18
         RenderWeight=0.002000
     End Object
     Box_Melee=GUIImage'BallisticProV55.BallisticTeamOutfittingMenu.ImageBoxMelee'

     Begin Object Class=GUIImage Name=ImageBoxSideArm
         Image=Texture'2K4Menus.NewControls.ScrollGripWatched'
         ImageStyle=ISTY_Stretched
         WinTop=0.205
         WinLeft=0.41
         WinHeight=0.14
         WinWidth=0.18
         RenderWeight=0.002000
     End Object
     Box_SideArm=GUIImage'BallisticProV55.BallisticTeamOutfittingMenu.ImageBoxSideArm'

     Begin Object Class=GUIImage Name=ImageBoxPrimary
         Image=Texture'2K4Menus.NewControls.ScrollGripWatched'
         ImageStyle=ISTY_Stretched
         WinTop=0.45
         WinLeft=0.26
         WinHeight=0.14
         WinWidth=0.18
         RenderWeight=0.002000
     End Object
     Box_Primary=GUIImage'BallisticProV55.BallisticTeamOutfittingMenu.ImageBoxPrimary'

     Begin Object Class=GUIImage Name=ImageBoxSecondary
         Image=Texture'2K4Menus.NewControls.ScrollGripWatched'
         ImageStyle=ISTY_Stretched
         WinTop=0.45
         WinLeft=0.56
         WinHeight=0.14
         WinWidth=0.18
         RenderWeight=0.002000
     End Object
     Box_Secondary=GUIImage'BallisticProV55.BallisticTeamOutfittingMenu.ImageBoxSecondary'

     Begin Object Class=GUIImage Name=ImageBoxGrenade
         Image=Texture'2K4Menus.NewControls.ScrollGripWatched'
         ImageStyle=ISTY_Stretched
         WinTop=0.205
         WinLeft=0.71
         WinHeight=0.14
         WinWidth=0.18
         RenderWeight=0.002000
     End Object
     Box_Grenade=GUIImage'BallisticProV55.BallisticTeamOutfittingMenu.ImageBoxGrenade'

	Begin Object Class=GUIComboBox Name=cb_MeleeComBox_LI
         MaxVisibleItems=16
         Hint="Gear layouts."
         WinTop=0.390000
         WinLeft=0.092148
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticTeamOutfittingMenu.InternalOnChange
         OnKeyEvent=cb_MeleeComBox_LI.InternalOnKeyEvent
     End Object
     cb_Melee_LI=GUIComboBox'BallisticProV55.BallisticTeamOutfittingMenu.cb_MeleeComBox_LI'

	Begin Object Class=GUIComboBox Name=cb_MeleeComBox_CI
         MaxVisibleItems=16
         Hint="Gear camos."
         WinTop=0.390000
         WinLeft=0.212148
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticTeamOutfittingMenu.InternalOnChange
         OnKeyEvent=cb_MeleeComBox_CI.InternalOnKeyEvent
     End Object
     cb_Melee_CI=GUIComboBox'BallisticProV55.BallisticTeamOutfittingMenu.cb_MeleeComBox_CI'
	 
     Begin Object Class=GUIComboBox Name=cb_SideArmBox_LI
         MaxVisibleItems=16
         Hint="Sidearm layouts."
         WinTop=0.390000
         WinLeft=0.392930
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticTeamOutfittingMenu.InternalOnChange
         OnKeyEvent=cb_SideArmBox_LI.InternalOnKeyEvent
     End Object
     cb_SideArm_LI=GUIComboBox'BallisticProV55.BallisticTeamOutfittingMenu.cb_SideArmBox_LI'
	 
     Begin Object Class=GUIComboBox Name=cb_SideArmBox_CI
         MaxVisibleItems=16
         Hint="Sidearm camos."
         WinTop=0.390000
         WinLeft=0.512930
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticTeamOutfittingMenu.InternalOnChange
         OnKeyEvent=cb_SideArmBox_CI.InternalOnKeyEvent
     End Object
     cb_SideArm_CI=GUIComboBox'BallisticProV55.BallisticTeamOutfittingMenu.cb_SideArmBox_CI'

     Begin Object Class=GUIComboBox Name=cb_PrimaryComBox_LI
         MaxVisibleItems=16
         Hint="Primary Weapon layouts."
         WinTop=0.630000
         WinLeft=0.241563
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticTeamOutfittingMenu.InternalOnChange
         OnKeyEvent=cb_PrimaryComBox_LI.InternalOnKeyEvent
     End Object
     cb_Primary_LI=GUIComboBox'BallisticProV55.BallisticTeamOutfittingMenu.cb_PrimaryComBox_LI'

     Begin Object Class=GUIComboBox Name=cb_PrimaryComBox_CI
         MaxVisibleItems=16
         Hint="Primary Weapon camos."
         WinTop=0.630000
         WinLeft=0.361563
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticTeamOutfittingMenu.InternalOnChange
         OnKeyEvent=cb_PrimaryComBox_CI.InternalOnKeyEvent
     End Object
     cb_Primary_CI=GUIComboBox'BallisticProV55.BallisticTeamOutfittingMenu.cb_PrimaryComBox_CI'

     Begin Object Class=GUIComboBox Name=cb_SecondaryComBox_LI
         MaxVisibleItems=16
         Hint="Secondary weapon layouts."
         WinTop=0.630000
         WinLeft=0.540977
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticTeamOutfittingMenu.InternalOnChange
         OnKeyEvent=cb_SecondaryComBox_LI.InternalOnKeyEvent
     End Object
     cb_Secondary_LI=GUIComboBox'BallisticProV55.BallisticTeamOutfittingMenu.cb_SecondaryComBox_LI'

     Begin Object Class=GUIComboBox Name=cb_SecondaryComBox_CI
         MaxVisibleItems=16
         Hint="Secondary weapon camos."
         WinTop=0.630000
         WinLeft=0.660977
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticTeamOutfittingMenu.InternalOnChange
         OnKeyEvent=cb_SecondaryComBox_CI.InternalOnKeyEvent
     End Object
     cb_Secondary_CI=GUIComboBox'BallisticProV55.BallisticTeamOutfittingMenu.cb_SecondaryComBox_CI'

     Begin Object Class=GUIComboBox Name=cb_GrenadeComBox_LI
         MaxVisibleItems=16
         Hint="Grenade layouts."
         WinTop=0.390000
         WinLeft=0.692148
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticTeamOutfittingMenu.InternalOnChange
         OnKeyEvent=cb_GrenadeComBox_LI.InternalOnKeyEvent
     End Object
     cb_Grenade_LI=GUIComboBox'BallisticProV55.BallisticTeamOutfittingMenu.cb_GrenadeComBox_LI'

     Begin Object Class=GUIComboBox Name=cb_GrenadeComBox_CI
         MaxVisibleItems=16
         Hint="Grenade layouts."
         WinTop=0.390000
         WinLeft=0.812148
         WinWidth=0.116094
         WinHeight=0.035000
         TabOrder=0
         OnChange=BallisticTeamOutfittingMenu.InternalOnChange
         OnKeyEvent=cb_GrenadeComBox_CI.InternalOnKeyEvent
     End Object
     cb_Grenade_CI=GUIComboBox'BallisticProV55.BallisticTeamOutfittingMenu.cb_GrenadeComBox_CI'

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
     MeleeBack=GUIImage'BallisticProV55.BallisticTeamOutfittingMenu.MeleeBackImage'

     Begin Object Class=GUIImage Name=SideArmBackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.050000
         WinLeft=0.400000
         WinWidth=0.200000
         WinHeight=0.200000
         RenderWeight=0.003000
     End Object
     SideArmBack=GUIImage'BallisticProV55.BallisticTeamOutfittingMenu.SideArmBackImage'

     Begin Object Class=GUIImage Name=PrimaryBackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.350000
         WinLeft=0.250000
         WinWidth=0.200000
         WinHeight=0.200000
         RenderWeight=0.003000
     End Object
     PrimaryBack=GUIImage'BallisticProV55.BallisticTeamOutfittingMenu.PrimaryBackImage'

     Begin Object Class=GUIImage Name=SecondaryBackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.350000
         WinLeft=0.550000
         WinWidth=0.200000
         WinHeight=0.200000
         RenderWeight=0.003000
     End Object
     SecondaryBack=GUIImage'BallisticProV55.BallisticTeamOutfittingMenu.SecondaryBackImage'

     Begin Object Class=GUIImage Name=GrenadeBackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.050000
         WinLeft=0.700000
         WinWidth=0.200000
         WinHeight=0.200000
         RenderWeight=0.003000
     End Object
     GrenadeBack=GUIImage'BallisticProV55.BallisticTeamOutfittingMenu.GrenadeBackImage'
    */

    Begin Object Class=GUILabel Name=l_Receivinglabel
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         FontScale=FNS_Large
         WinTop=0.087000
         WinLeft=0.050000
         WinWidth=0.900000
         WinHeight=0.040000
    End Object
    l_Receiving=GUILabel'BallisticProV55.BallisticTeamOutfittingMenu.l_Receivinglabel'

    Begin Object Class=GUIButton Name=BSavePresetButton
         Caption="SAVE"
         Hint="Saves the current configuration as a new preset."
         WinTop=0.66500
         WinLeft=0.200000
         WinWidth=0.2
         WinHeight=0.04000
         TabOrder=0
         OnClick=BallisticTeamOutfittingMenu.InternalOnClick
         OnKeyEvent=BSavePresetButton.InternalOnKeyEvent
    End Object
    BSavePreset=GUIButton'BallisticProV55.BallisticTeamOutfittingMenu.BSavePresetButton'

     Begin Object Class=moComboBox Name=co_PresetsCB
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Presets"
         OnCreateComponent=co_PresetsCB.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Choose a preset replacements configuration, or type a new preset name here and click 'Save' to make the current configuration a new preset."
         WinTop=0.66500
         WinLeft=0.600000
         WinWidth=0.200000
         OnChange=BallisticTeamOutfittingMenu.InternalOnChange
     End Object
     cb_Presets=moComboBox'BallisticProV55.BallisticTeamOutfittingMenu.co_PresetsCB'

    Begin Object Class=GUIButton Name=DoneButton
         Caption="DONE"
         WinTop=0.720000
         WinLeft=0.200000
         WinWidth=0.200000
         TabOrder=0
         OnClick=BallisticTeamOutfittingMenu.InternalOnClick
         OnKeyEvent=DoneButton.InternalOnKeyEvent
    End Object
    bDone=GUIButton'BallisticProV55.BallisticTeamOutfittingMenu.DoneButton'

    Begin Object Class=GUIButton Name=CancelButton
         Caption="CANCEL"
         WinTop=0.720000
         WinLeft=0.600000
         WinWidth=0.200000
         TabOrder=1
         OnClick=BallisticTeamOutfittingMenu.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
    End Object
    bCancel=GUIButton'BallisticProV55.BallisticTeamOutfittingMenu.CancelButton'

    Begin Object Class=GUIHeader Name=DaBeegHeader
         bUseTextHeight=True
         Caption="Select your equipment"
         WinTop=0.125000
         WinLeft=0.050000
         WinWidth=0.900000
         WinHeight=0.700000
    End Object
    MyHeader=GUIHeader'BallisticProV55.BallisticTeamOutfittingMenu.DaBeegHeader'

    bRenderWorld=True
    bAllowedAsLast=True
    OnKeyEvent=BallisticTeamOutfittingMenu.InternalOnKeyEvent

    SavedLoadouts(0)=(PresetName="Terran",Weapons[0]="BallisticProV55.X3Knife",Weapons[1]="BallisticProV55.M806Pistol",Weapons[2]="BallisticProV55.M50AssaultRifle",Weapons[3]="BallisticProV55.M763Shotgun",Weapons[4]="BallisticProV55.NRP57Grenade")
    SavedLoadouts(1)=(PresetName="Skrith",Weapons[0]="BallisticProV55.A909SkrithBlades",Weapons[1]="BallisticProV55.A42SkrithPistol",Weapons[2]="BallisticProV55.A73SkrithRifle",Weapons[3]="BWBP_SKC_Pro.AY90SkrithBoltcaster",Weapons[4]="BWBP_SWC_Pro.A51Grenade")
    SavedLoadouts(2)=(PresetName="Insurgent",Weapons[0]="BWBP_SKC_Pro.X8Knife",Weapons[1]="BallisticProV55.MRT6Shotgun",Weapons[2]="BallisticProV55.G5Bazooka",Weapons[3]="BWBP_SKC_Pro.AK490BattleRifle",Weapons[4]="BallisticProV55.BX5Mine")
    SavedLoadouts(3)=(PresetName="Support",Weapons[0]="BWBP_OP_Pro.BallisticShieldWeapon",Weapons[1]="BallisticProV55.D49Revolver",Weapons[2]="BallisticProV55.M353Machinegun",Weapons[3]="BallisticProV55.BOGPPistol",Weapons[4]="BWBP_OP_Pro.L8GIAmmoPack")
    SavedLoadouts(4)=(PresetName="Assassin",Weapons[0]="BWBP_SKC_Pro.DragonsToothSword",Weapons[1]="BallisticProV55.RS8Pistol",Weapons[2]="BWBP_SKC_Pro.X82Rifle",Weapons[3]="BallisticProV55.XK2SubMachinegun",Weapons[4]="BWBP_SKC_Pro.XM84Flashbang")
    QuickListText="QuickList"
    ReceivingText(0)="Receiving..."
    ReceivingText(1)="Loading..."
}
