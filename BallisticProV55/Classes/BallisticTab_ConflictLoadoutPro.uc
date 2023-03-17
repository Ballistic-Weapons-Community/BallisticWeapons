//=============================================================================
// BallisticTab_ConflictLoadoutPro.
//
// Page where players choose their inventory for Conflict
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticTab_ConflictLoadoutPro extends MidGamePanel;

const INVENTORY_SIZE_MAX = 35;

var bool					bInitialized; // showpanel
var bool					bLoadInitialized;

var automated GUIListBox	lb_Weapons;
var Automated GUIImage		Box_WeapList, Box_Inventory, Pic_Weapon, Box_WeapIcon;
var automated GUILabel   	l_WeapTitle;
var automated GUIComboBox	 cb_WeapLayoutIndex, cb_WeapCamoIndex;
var automated GUIScrollTextBox	tb_Desc;
var Automated GUIButton BStats, BClear;
var automated GUILabel	l_StatTime, l_StatFrags, l_StatEfficiency, l_StatDamageRate, l_StatSniperEff, l_StatShotgunEff, l_StatHazardEff, l_StatHeading, l_Loading;

var() localized string StatTimeCaption;
var() localized string StatFragsCaption;
var() localized string StatEffCaption;
var() localized string StatDmgRtCaption;
var() localized string StatSnprEffCaption;
var() localized string StatStgnEffCaption;
var() localized string StatHzrdEffCaption;

var() localized string HealthText;
var() localized string ArmorText;
var() localized string AmmoText;

var() Texture	HealthIcon;
var() Texture	ArmorIcon;
var() Texture	AmmoIcon;

struct Item
{
	var() String	Title;
	var() Material	Icon;
	var() string	ClassName;
	var() int		Size;
	var() string	Ammo;
	var() int		InventoryGroup;
	var() int		LayoutIndex;
	var() int		CamoIndex;
	var() bool		bBad;
};

var() array<Item> Inventory;
var() int SpaceUsed;

var() array<int> LayoutIndexList;
var() array<int> CamoIndexList;
var() bool bUpdatingWeapon; //dont change layout unless we click the box
	
var() Material BoxTex;

var ConflictLoadoutLRI CLRI;

var bool bWaitingWeaps, bWaitingSkill;

// Check for PRI update
function InitPanel()
{
	super.InitPanel();
	
	Initialize();
}

function Initialize()
{
	if (bInitialized)
		return;

	lb_Weapons.List.OnChange = InternalOnChange;
	lb_Weapons.List.OnDblClick = InternalOnDblClick;
	
	CLRI = ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(PlayerOwner().PlayerReplicationInfo));
	
	if (CLRI == None)
		SetTimer(0.05, true);
	else
		OnLRIAcquired();

	bInitialized = true;
}

//========================================================================
// Timer
//
// Waits for reception of weapons and skill requirements then initialises both
//========================================================================
event Timer()
{
	if (CLRI != None)
	{
		if (bWaitingWeaps && CLRI.bHasList && (CLRI.LoadoutOption != 1 || CLRI.bHasSkillInfo))
		{
			bWaitingWeaps=false;
			InitWeaponLists();
		}
		if (bWaitingSkill && CLRI.bHasSkillInfo)
		{
			bWaitingSkill=false;
			DisplaySkills();
		}
		if (!bWaitingWeaps && !bWaitingSkill)
		{
			KillTimer();
		}
	}
	else if (PlayerOwner() != None && ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(PlayerOwner().PlayerReplicationInfo)) !=None)
	{
		KillTimer();
		CLRI = ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(PlayerOwner().PlayerReplicationInfo));
		OnLRIAcquired();
		return;
	}
}

function OnLRIAcquired()
{
	if (CLRI.LoadoutOption == 1)
	{
		CLRI.bHasSkillInfo = false;
		CLRI.RequestSkillInfo();
		if (!CLRI.bHasSkillInfo)
		{
			bWaitingSkill=true;
			SetTimer(0.1, true);
		}
		else
			DisplaySkills();
		tb_Desc.WinHeight = 0.23;
	}
	else
	{
		l_StatHeading.Caption =		"";
		l_StatTime.Caption =		"";
		l_StatFrags.Caption =		"";
		l_StatEfficiency.Caption =	"";
		l_StatSniperEff.Caption =	"";
		l_StatShotgunEff.Caption =	"";
		l_StatHazardEff.Caption =	"";
		l_StatDamageRate.Caption =	"";
		BStats.Hide();
	}

	if (CLRI.bHasList)
	{
		if (CLRI.LoadoutOption == 1 && !CLRI.bHasSkillInfo)
		{
			bWaitingWeaps=true;
			SetTimer(0.1, true);
		}
		else
		{
			InitWeaponLists();
		}
	}
	else
	{
		bWaitingWeaps=true;
		CLRI.FullInventoryList.length = 0;
		CLRI.RequirementsList.length = 0;
		CLRI.RequestFullList();
		SetTimer(0.1, true);
	}
}

simulated function DisplaySkills ()
{
	l_StatTime.Caption =		StatTimeCaption		$ CLRI.MySkillInfo.ElapsedTime;
	l_StatFrags.Caption =		StatFragsCaption	$ int(PlayerOwner().PlayerReplicationInfo.Score);
	if (PlayerOwner().PlayerReplicationInfo.Deaths == 0)
		l_StatEfficiency.Caption =	StatEffCaption		$ PlayerOwner().PlayerReplicationInfo.Score / 0.1;
	else
		l_StatEfficiency.Caption =	StatEffCaption		$ PlayerOwner().PlayerReplicationInfo.Score / PlayerOwner().PlayerReplicationInfo.Deaths;
	l_StatSniperEff.Caption =	StatSnprEffCaption	$ CLRI.MySkillInfo.SniperEff;
	l_StatShotgunEff.Caption =	StatStgnEffCaption	$ CLRI.MySkillInfo.ShotgunEff;
	l_StatHazardEff.Caption =	StatHzrdEffCaption	$ CLRI.MySkillInfo.HazardEff;
	l_StatDamageRate.Caption =	StatDmgRtCaption	$ CLRI.MySkillInfo.DamageRate;
}

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
	
	Log("BallisticTab_ConflictLoadoutPro: InitWeaponLists");

	l_Loading.Caption = "";
	l_Loading.Hide();

	lb_Weapons.List.Clear();
	cb_WeapLayoutIndex.Clear();
	cb_WeapCamoIndex.Clear();

	//Only explicitly load saved inventory.	
	Inventory.length = 0;
	SpaceUsed = 0;
	
	for (i = 0; i < class'ConflictLoadoutConfig'.default.SavedInventory.length; i++)
	{
		a = class<Actor>(DynamicLoadObject(class'ConflictLoadoutConfig'.default.SavedInventory[i], class'Class'));
		
		if (class<BallisticWeapon>(a) != None)
		{
			Weap = class<BallisticWeapon>(a);
			AddInventory(string(Weap), Weap, Weap.default.ItemName, class'ConflictLoadoutConfig'.default.SavedLayout[i], class'ConflictLoadoutConfig'.default.SavedCamo[i]);
		}
		
		else if (class<ConflictItem>(a) != None)
		{
			CI = class<ConflictItem>(a);
			AddInventory(string(CI), CI, CI.default.ItemName, 0, 0);
		}
	}

	lastIndex = -1;
	
	//Use cache for the rest.
	//Weapons here will be loaded explicitly if they're selected in the list, via the Extra string data.
	// The Full Inventory List is already sorted by inventory group and Conflict item status.
	for (i=0; i < CLRI.FullInventoryList.length; i++)
	{
		if (!CLRI.WeaponRequirementsOk(CLRI.RequirementsList[i]))
			continue;
		
		if (InStr(CLRI.FullInventoryList[i], "CItem") != -1)
		{ 
			if (lastIndex != -1)
			{
				lastIndex = -1;
				lb_Weapons.List.Add("Misc",,"Mc",true);
				LayoutIndexList.Insert(LayoutIndexList.Length, 0);
				LayoutIndexList.Insert(CamoIndexList.Length, 0);
			}
			
			CI = class<ConflictItem>(DynamicLoadObject(CLRI.FullInventoryList[i], class'Class'));
			
			if (CI != None)
			{
				lb_Weapons.List.Add(CI.default.ItemName, , CLRI.FullInventoryList[i]);
				LayoutIndexList.Insert(LayoutIndexList.Length, 0);
				LayoutIndexList.Insert(CamoIndexList.Length, 0);
			}
		}
		
		else 
		{
			if (LoadWIFromCache(CLRI.FullInventoryList[i], WI))
			{
				if (WI.InventoryGroup != lastIndex)
				{
					lastIndex = WI.InventoryGroup;
					lb_Weapons.List.Add(class'BallisticWeaponClassInfo'.static.GetHeading(lastIndex),, "Weapon Category", true);
					LayoutIndexList.Insert(LayoutIndexList.Length, 0);
					LayoutIndexList.Insert(CamoIndexList.Length, 0);
				}
				
				lb_Weapons.List.Add(WI.ItemName, , CLRI.FullInventoryList[i]);
				LayoutIndexList.Insert(LayoutIndexList.Length, 0);
				LayoutIndexList.Insert(CamoIndexList.Length, 0);
			}
		}
	}
}

// Get Name, BigIconMaterial and classname of weapon at index? in group?
function bool LoadWIFromCache(string ClassStr, out BC_WeaponInfoCache.WeaponInfo WepInfo)
{
	local int i;

	WepInfo = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(ClassStr, i);
	if (i==-1)
	{
		log("Error loading item for Conflict: "$ClassStr, 'Warning');
		return false;
	}
	return true;
}

//give this function a gun, grab an array of layouts from cache, add each value to the combobox
function bool LoadLIFromCache(string ClassStr, GUIComboBox LayoutComboBox)
{
 	local BC_WeaponInfoCache.LayoutInfo LI;
	local BC_WeaponInfoCache.WeaponInfo WI;
	local int i, j;
		
	//clear old layouts
	LayoutComboBox.Clear();
		
	class'BC_WeaponInfoCache'.static.FindWeaponInfo(ClassStr, WI, i);
	
	if (i==-1)
	{
		log("Error loading item for outfitting: "$ClassStr, 'Warning');
		return false;
	}
	
	for (j = 0; j < WI.TotalLayouts; j++)
	{
		if (class'BC_WeaponInfoCache'.static.FindLayoutInfo(WI, class'BCReplicationInfo'.default.GameStyle, j, LI, i))
			LayoutComboBox.AddItem(LI.LayoutName);
	}

	return true;
}

//give this function a gun, grab an array of camos from cache, add each value to the combobox
function bool LoadCIFromCache(string ClassStr, int LayoutIndex, GUIComboBox CamoComboBox)
{
 	local BC_WeaponInfoCache.CamoInfo CI;
	local BC_WeaponInfoCache.WeaponInfo WI;
	local int i, j;
		
	//clear old layouts
	CamoComboBox.Clear();
		
	class'BC_WeaponInfoCache'.static.FindWeaponInfo(ClassStr, WI, i);
	
	if (i==-1)
	{
		log("Error loading item for outfitting: "$ClassStr, 'Warning');
		return false;
	}
	
	for (j = 0; j < WI.TotalCamos; j++)
	{
		if (class'BC_WeaponInfoCache'.static.FindCamoInfo(WI, class'BCReplicationInfo'.default.GameStyle, LayoutIndex, j, CI, i))
			CamoComboBox.AddItem(CI.CamoName,, String(CI.CamoIndex));
	}
	
	if (WI.TotalCamos > 1)
		CamoComboBox.AddItem("Random",, "255");

	return true;
}


function int GetItemSize(class<Weapon> Item)
{
	if (class<BallisticWeapon>(Item) != None)
		return class<BallisticWeapon>(Item).default.ParamsClasses[class'BCReplicationInfo'.default.GameStyle].default.Layouts[0].InventorySize;
	return 5;
}

function int CountExisting(string weapon_name)
{
	local int i, count;

	for (i = 0; i < Inventory.Length; ++i)
	{
		if (Inventory[i].ClassName ~= weapon_name)
			++count;
	}

	return count;
}

function int GetMaxCount(class<Weapon> weapon)
{
	local int base_ammo, max_ammo;

	if (class<BallisticHandgun>(weapon) != None && class<BallisticHandgun>(weapon).default.bShouldDualInLoadout)
		return 2;

	base_ammo = Max(1, weapon.default.FireModeClass[0].default.AmmoClass.default.InitialAmount);
	max_ammo = weapon.default.FireModeClass[0].default.AmmoClass.default.MaxAmmo;

	if (max_ammo % base_ammo == 0)
		return Max(1, max_ammo / base_ammo);

	return Max(1, Ceil(float(max_ammo) / float(base_ammo)));
}

function bool MaxReached(class<Weapon> weapon, string class_name)
{
	return CountExisting(class_name) >= GetMaxCount(weapon);
}

function bool GroupPriorityOver(int inserting_group, int target_group)
{
    switch(inserting_group)
	{
		case 1: // melee
        case 2: // sidearm
			return inserting_group < target_group;
        case 11:
            return false;
		default:
			return target_group == 11;
	}

    // old code which puts primaries first
    /*
	switch(inserting_group)
	{
		case 11: // grenade last
			return false;
		case 1: // melee next
			return target_group == 11;
		case 2: // sidearm next
			return target_group == 1 || target_group == 2;
		default: // primary weapons always come last so we spawn with them online, it seems
			return target_group == 1 || target_group == 2 || target_group == 11;
	}
    */
}

function int GetInsertionPoint(int inserting_item_grp)
{
	local int i, current_item_group;
	
	if (inserting_item_grp == 0)
		inserting_item_grp = 11;
	
	for (i = 0; i < Inventory.Length; ++i)
	{
		current_item_group = Inventory[i].InventoryGroup;
		
		if (current_item_group == 0)
			current_item_group = 11;
			
		if (GroupPriorityOver(inserting_item_grp, current_item_group))
			break;
	}
	
	return i;
}

function bool AddInventory(string ClassName, class<actor> InvClass, string FriendlyName, optional int PassedLayoutIndex, optional int PassedCamoIndex)
{
	local int i, Size, A;
	local class<BallisticWeapon> 	Weap;
	local class<Weapon> 			WeaponClass;

	if (InvClass == None)
	{
		Log("BallisticTab_ConflictLoadoutPro::AddInventory: InvClass was None");
		return false;
	}
		
	if (class<ConflictItem>(InvClass) != None)
		return HandleConflictItem(InvClass, FriendlyName);
	
	if (class<Weapon>(InvClass) == None)
	{
		Log("BallisticTab_ConflictLoadoutPro::AddInventory: InvClass was not a Weapon");
		return false;
	}

	WeaponClass = class<Weapon>(InvClass);

	if (MaxReached(WeaponClass, ClassName))
	{
		Log("BallisticTab_ConflictLoadoutPro::AddInventory: Maximum count reached for "$ClassName);
		return false;
	}

	Weap = class<BallisticWeapon>(WeaponClass);

	Size = GetItemSize(WeaponClass);

	if (SpaceUsed + Size > INVENTORY_SIZE_MAX)
	{
		Log("BallisticTab_ConflictLoadoutPro::AddInventory: No room: Used "$SpaceUsed$"/"$INVENTORY_SIZE_MAX$", requesting "$Size);
		return false;
	}

	SpaceUsed += Size;
	
	i = GetInsertionPoint(Weap.default.InventoryGroup);
	
	Inventory.Insert(i, 1);
	
	Inventory[i].ClassName = string(WeaponClass);
	Inventory[i].Size = Size;
	Inventory[i].Title = FriendlyName;
	Inventory[i].InventoryGroup = Weap.default.InventoryGroup;
	Inventory[i].CamoIndex = PassedCamoIndex;
	Inventory[i].LayoutIndex = PassedLayoutIndex;
	
	
	A = WeaponClass.default.FireModeClass[0].default.AmmoClass.default.InitialAmount;

	if (Weap!=None)
	{
		if (!Weap.default.bNoMag)
			A += Weap.default.MagAmmo;
		Inventory[i].Icon = Weap.default.BigIconMaterial;
	}
	else
	{
		Inventory[i].Icon = None;
	}
	
	Inventory[i].Ammo = string(A);
	
	if (WeaponClass.default.FireModeClass[1].default.AmmoClass != None &&
		WeaponClass.default.FireModeClass[1].default.AmmoClass != WeaponClass.default.FireModeClass[0].default.AmmoClass &&
		WeaponClass.default.FireModeClass[1].default.AmmoClass.default.InitialAmount > 0)
		Inventory[i].Ammo = WeaponClass.default.FireModeClass[1].default.AmmoClass.default.InitialAmount $ " / " $ Inventory[i].Ammo;
	
	if (!CLRI.ValidateWeapon(ClassName))
		Inventory[i].bBad = true;
	
	return true;
}

function bool HandleConflictItem(class<actor> InvClass, string FriendlyName)
{
	local int i, Size;
	
	Size = class<ConflictItem>(InvClass).default.Size/5;
	
	if (SpaceUsed + Size > INVENTORY_SIZE_MAX)
		return false;

	SpaceUsed += Size;
	i = Inventory.length;
	Inventory.length = i + 1;
	Inventory[i].ClassName = string(InvClass);
	Inventory[i].Size = Size;
	Inventory[i].Title = FriendlyName;
	Inventory[i].Icon = class<ConflictItem>(InvClass).default.Icon;
	Inventory[i].Ammo = class<ConflictItem>(InvClass).default.ItemAmount;
	Inventory[i].InventoryGroup = 12;
	return true;
}

//Add inventory to the bottom bar
function bool InternalOnDblClick(GUIComponent Sender)
{
	local class<BallisticWeapon> BW;
	
	if (Sender==lb_Weapons.List)
	{
		if (lb_Weapons.List.GetObject() != None && class<BallisticWeapon>(lb_Weapons.List.GetObject()) != None)
		{
			BW =  class<BallisticWeapon>(lb_Weapons.List.GetObject());
			AddInventory(string(BW), BW, lb_Weapons.List.Get(), LayoutIndexList[lb_Weapons.List.Index], int(cb_WeapCamoIndex.getExtra())); /*CamoIndexList[lb_Weapons.List.Index]*/
		}
		else
			AddInventory(string(lb_Weapons.List.GetObject()), class<actor>(lb_Weapons.List.GetObject()), lb_Weapons.List.Get(), 0, 0);
	}

	return true;
}

function bool InternalOnClick(GUIComponent Sender)
{
	local int i;
	local float X, ItemSize;

	//Figure out which currently existing item the player clicked on and then remove it.
	if (Sender == Box_Inventory)
	{
		X = Box_Inventory.Bounds[0];

		for (i=0;i<Inventory.length;i++)
		{
			ItemSize = (Box_Inventory.ActualWidth()/INVENTORY_SIZE_MAX) * Inventory[i].Size;
			if (Controller.MouseX > X && Controller.MouseX < X + ItemSize)
			{
				class'ConflictLoadoutConfig'.static.UpdateSavedInitialIndex(i);
				return true;
			}
			X += ItemSize;
		}
	}
	
	else if (Sender==BStats && CLRI!=None)
	{
		Controller.OpenMenu("BallisticProV55.BallisticConflictInfoMenu");
		if (BallisticConflictInfoMenu(Controller.ActivePage) != None)
			BallisticConflictInfoMenu(Controller.ActivePage).LoadWeapons(self);
	}
	
	else if (Sender==BClear)
	{
		Inventory.Length = 0;
		SpaceUsed = 0;
	}

	return true;
}

function bool InternalOnRightClick(GUIComponent Sender)
{
	local int i;
	local float X, ItemSize;

	//Figure out which currently existing item the player clicked on and then remove it.
	if (Sender == Box_Inventory)
	{
		X = Box_Inventory.Bounds[0];

		for (i=0;i<Inventory.length;i++)
		{
			ItemSize = (Box_Inventory.ActualWidth()/INVENTORY_SIZE_MAX) * Inventory[i].Size;
			if (Controller.MouseX > X && Controller.MouseX < X + ItemSize)
			{
				SpaceUsed -= Inventory[i].Size;
				Inventory.Remove(i, 1);
				return true;
			}
			X += ItemSize;
		}
	}
	
	else if (Sender==BStats && CLRI!=None)
	{
		Controller.OpenMenu("BallisticProV55.BallisticConflictInfoMenu");
		if (BallisticConflictInfoMenu(Controller.ActivePage) != None)
			BallisticConflictInfoMenu(Controller.ActivePage).LoadWeapons(self);
	}

	return true;
}

//===========================================================================
// Update the boxes when the weapon list changes
//
// Azarael: Uses Cache.
//===========================================================================
function InternalOnChange(GUIComponent Sender)
{
	local class<BallisticWeapon> BW;
	
	if (Sender==lb_Weapons.List)
	{
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
				bUpdatingWeapon=true;
				BW = class<BallisticWeapon>(lb_Weapons.List.GetObject());
				Pic_Weapon.Image = BW.default.BigIconMaterial;
				tb_Desc.SetContent(BW.static.GetShortManual());
				log("Loading layout of gun at loc "$lb_Weapons.List.Index$" with "$LayoutIndexList[lb_Weapons.List.Index]); 
				LoadLIFromCache(lb_Weapons.List.GetExtra(), cb_WeapLayoutIndex);
				cb_WeapLayoutIndex.setIndex(LayoutIndexList[lb_Weapons.List.Index]);
				LoadCIFromCache(lb_Weapons.List.GetExtra(), LayoutIndexList[lb_Weapons.List.Index], cb_WeapCamoIndex);
				cb_WeapCamoIndex.setIndex(CamoIndexList[lb_Weapons.List.Index]);
				bUpdatingWeapon=false;
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
				bUpdatingWeapon=true;
				Pic_Weapon.Image = BW.default.BigIconMaterial;
				tb_Desc.SetContent(BW.static.GetShortManual());
				lb_Weapons.List.SetObjectAtIndex(lb_Weapons.List.Index, BW);
				LoadLIFromCache(lb_Weapons.List.GetExtra(), cb_WeapLayoutIndex);
				LoadCIFromCache(lb_Weapons.List.GetExtra(), 0, cb_WeapCamoIndex);
				bUpdatingWeapon=false;
			}
		}
	}	
	else if (Sender == cb_WeapLayoutIndex ) //todo
	{
		if (lb_Weapons.List.GetObject() != None && class<BallisticWeapon>(lb_Weapons.List.GetObject()) != None && !bUpdatingWeapon)
		{
			LayoutIndexList[lb_Weapons.List.Index] = cb_WeapLayoutIndex.getIndex();
			LoadCIFromCache(lb_Weapons.List.GetExtra(), LayoutIndexList[lb_Weapons.List.Index], cb_WeapCamoIndex);
			log("Setting layout index of gun at loc "$lb_Weapons.List.Index$" to "$cb_WeapLayoutIndex.getIndex()); 
		}
	}	
	else if (Sender == cb_WeapCamoIndex )
	{
		if (lb_Weapons.List.GetObject() != None && class<BallisticWeapon>(lb_Weapons.List.GetObject()) != None && !bUpdatingWeapon)
		{
			CamoIndexList[lb_Weapons.List.Index] = cb_WeapCamoIndex.getIndex();
			log("Setting camo index of gun at loc "$lb_Weapons.List.Index$" to "$cb_WeapCamoIndex.getIndex()); 
		}
	}
}

event Closed( GUIComponent Sender, bool bCancelled )
{
	Super.Closed(Sender, bCancelled);
	
	UpdateInventory();
}

function UpdateInventory()
{
	if (bWaitingWeaps || bWaitingSkill)
		return;

	class'ConflictLoadoutConfig'.static.UpdateSavedInventory(Inventory);

	CLRI.OnInventoryUpdated();
}

//=========================================================
// DrawInventory
//=========================================================
function DrawInventory(Canvas C)
{
	local int i, j;
	local float X, ItemSize, IconX, IconY, XL, YL;
	local float MyX, MyY, MyW, MyH, ScaleFactor;
	local string s;

    local int initial_wep_index;

    initial_wep_index = class'ConflictLoadoutConfig'.static.GetSavedInitialWeaponIndex();

	ScaleFactor = float(Controller.ResX)/1600;
	MyX = Box_Inventory.Bounds[0] + 24*ScaleFactor;
	MyY = Box_Inventory.Bounds[1] + 24*ScaleFactor;
	MyW = Box_Inventory.ActualWidth() - 48*ScaleFactor;
	MyH = Box_Inventory.ActualHeight() - 48*ScaleFactor;

	C.SetDrawColor(255,255,255,255);
	C.SetPos(MyX, Myy);
	C.DrawTile(Controller.DefaultPens[1], MyW, MyH, 0, 0, 1, 1);

	C.SetDrawColor(64,64,64,255);
	X = MyX;
	for(i=0;i<INVENTORY_SIZE_MAX;i++)
	{
		C.SetPos(X, Myy);
		C.DrawTile(BoxTex, MyW/INVENTORY_SIZE_MAX, MyH, 0, 0, 128, 64);
		X += MyW/INVENTORY_SIZE_MAX;
	}

	X = MyX;
	C.Style = 6;

	for (i=0;i<Inventory.length;i++)
	{
		if (Inventory[i].bBad)
			C.SetDrawColor(255,64,64,255);
        else if (i == initial_wep_index)
            C.SetDrawColor(192,255,192,255);
        else 
			C.SetDrawColor(255,255,255,255);

        //can't exceed twice the height - Azarael
        ItemSize = (MyW/INVENTORY_SIZE_MAX) * Inventory[i].Size;
        IconX = FMin(ItemSize, MyH*2.3);
        IconY = IconX/2;

        if (Inventory[i].Icon != None)
        {	C.SetPos(X + (ItemSize - IconX)/2, MyY + (MyH-IconY)/2);
            C.DrawTile(Inventory[i].Icon, IconX, IconY, 0, 0, Inventory[i].Icon.MaterialUSize(), Inventory[i].Icon.MaterialVSize());	
        }

		if (Inventory[i].bBad)
			C.SetDrawColor(255,0,0,255);
        else if (i == initial_wep_index)
            C.SetDrawColor(32,255,0,255);
		else
			C.SetDrawColor(255,128,0,255);

		C.SetPos(X, MyY);
		C.DrawTileStretched(BoxTex, ItemSize, MyH);

        if (i == initial_wep_index)
            C.SetDrawColor(32,255,0,255);
		else 
            C.SetDrawColor(255,128,0,255);

		C.Font = Controller.GetMenuFont("UT2SmallFont").GetFont(C.ClipX*0.8);
		C.StrLen(Inventory[i].Title, XL, YL);
		if (XL > ItemSize)
		{
			j = InStr(Inventory[i].Title, " ");
			s = Left(Inventory[i].Title, j);
			C.SetPos(X+4*ScaleFactor, MyY + MyH - YL*2 - 4*ScaleFactor);
			C.DrawText(s, false);

			s = Right(Inventory[i].Title, Len(Inventory[i].Title)-j-1);
			C.SetPos(X+4*ScaleFactor, MyY + MyH - YL - 4*ScaleFactor);
			C.DrawText(s, false);
		}
		else
		{
			C.SetPos(X+4*ScaleFactor, MyY + MyH - YL - 4*ScaleFactor);
			C.DrawText(Inventory[i].Title, false);
		}

		C.SetDrawColor(255,64,64,255);
		C.StrLen(Inventory[i].Ammo, XL, YL);
		C.SetPos(X + ItemSize - 6*ScaleFactor - XL, MyY + 4*ScaleFactor);
		C.DrawText(Inventory[i].Ammo, false);
		X += ItemSize;
	}
}

//========================
// defprops
//========================

defaultproperties
{
     Begin Object Class=GUIListBox Name=lb_WeaponsList
         bVisibleWhenEmpty=True
         OnCreateComponent=lb_WeaponsList.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Available items. Double-click to add them to your inventory."
         WinTop=0.070000
         WinLeft=0.0150000
         WinWidth=0.400000
         WinHeight=0.580000
         RenderWeight=0.520000
         TabOrder=1
     End Object
     lb_Weapons=GUIListBox'BallisticProV55.BallisticTab_ConflictLoadoutPro.lb_WeaponsList'

     Begin Object Class=GUIImage Name=Box_WeapListImg
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.02000
         WinWidth=0.430000
         WinHeight=0.675000
         RenderWeight=0.002000
     End Object
     Box_WeapList=GUIImage'BallisticProV55.BallisticTab_ConflictLoadoutPro.Box_WeapListImg'

     Begin Object Class=GUIImage Name=Box_InventoryImg
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.700000
         WinHeight=0.200000
         RenderWeight=0.002000
         bAcceptsInput=True
         OnRendered=BallisticTab_ConflictLoadoutPro.DrawInventory
         OnClick=BallisticTab_ConflictLoadoutPro.InternalOnClick
         OnRightClick=BallisticTab_ConflictLoadoutPro.InternalOnRightClick
     End Object
     Box_Inventory=GUIImage'BallisticProV55.BallisticTab_ConflictLoadoutPro.Box_InventoryImg'

     Begin Object Class=GUIImage Name=Pic_WeaponImg
         //Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Justified
         ImageAlign=IMGA_Center
         WinTop=0.040000
         WinLeft=0.515000
         WinWidth=0.40000
         WinHeight=0.226000
         RenderWeight=0.004000
     End Object
     Pic_Weapon=GUIImage'BallisticProV55.BallisticTab_ConflictLoadoutPro.Pic_WeaponImg'

     Begin Object Class=GUIImage Name=Box_WeapIconImg
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.020000
         WinLeft=0.450000
         WinWidth=0.540000
         WinHeight=0.675000
         RenderWeight=0.002000
     End Object
     Box_WeapIcon=GUIImage'BallisticProV55.BallisticTab_ConflictLoadoutPro.Box_WeapIconImg'

     Begin Object Class=GUILabel Name=l_WeapTitlelabel
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255,R=255)
         WinTop=0.020000
         WinLeft=0.51000
         WinWidth=0.430000
         WinHeight=0.050000
     End Object
     l_WeapTitle=GUILabel'BallisticProV55.BallisticTab_ConflictLoadoutPro.l_WeapTitlelabel'

     Begin Object Class=GUIScrollTextBox Name=WeaponDescription
         CharDelay=0.001500
         EOLDelay=0.250000
         bVisibleWhenEmpty=True
         OnCreateComponent=WeaponDescription.InternalOnCreateComponent
         FontScale=FNS_Small
         WinTop=0.320000
         WinLeft=0.480000
         WinWidth=0.500000
         WinHeight=0.3750000
         RenderWeight=0.510000
         TabOrder=0
         bAcceptsInput=False
         bNeverFocus=True
     End Object
     tb_Desc=GUIScrollTextBox'BallisticProV55.BallisticTab_ConflictLoadoutPro.WeaponDescription'
	 
     Begin Object Class=GUIComboBox Name=cb_WeapLayoutIndexComBox
         MaxVisibleItems=16
         Hint="Weapon layouts."
         WinTop=0.280000
         WinLeft=0.48
         WinWidth=0.196094
         WinHeight=0.040000
         TabOrder=0
         OnChange=BallisticTab_ConflictLoadoutPro.InternalOnChange
         OnKeyEvent=cb_WeapLayoutIndexComBox.InternalOnKeyEvent
     End Object
     cb_WeapLayoutIndex=GUIComboBox'BallisticProV55.BallisticTab_ConflictLoadoutPro.cb_WeapLayoutIndexComBox'
	 
     Begin Object Class=GUIComboBox Name=cb_WeapCamoIndexComBox
         MaxVisibleItems=16
         Hint="Weapon camos."
         WinTop=0.280000
         WinLeft=0.74
         WinWidth=0.196094
         WinHeight=0.040000
         TabOrder=0
         OnChange=BallisticTab_ConflictLoadoutPro.InternalOnChange
         OnKeyEvent=cb_WeapCamoIndexComBox.InternalOnKeyEvent
     End Object
     cb_WeapCamoIndex=GUIComboBox'BallisticProV55.BallisticTab_ConflictLoadoutPro.cb_WeapCamoIndexComBox'
	 
     Begin Object Class=GUIButton Name=BClearButton
         Caption="Clear Loadout"
         WinTop=0.92000
         WinLeft=0.20000
         WinWidth=0.200000
         TabOrder=1
         OnClick=BallisticTab_ConflictLoadoutPro.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bClear=GUIButton'BallisticProV55.BallisticTab_ConflictLoadoutPro.BClearButton'
	 
	 Begin Object Class=GUIButton Name=BStatButton
         Caption="Stats"
         WinTop=0.920000
         WinLeft=0.600000
         WinWidth=0.200000
         TabOrder=1
         OnClick=BallisticTab_ConflictLoadoutPro.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bStats=GUIButton'BallisticProV55.BallisticTab_ConflictLoadoutPro.BStatButton'

     Begin Object Class=GUILabel Name=l_StatTimeLabel
         Caption="Time"
         TextColor=(B=0,G=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinTop=0.540000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_StatTime=GUILabel'BallisticProV55.BallisticTab_ConflictLoadoutPro.l_StatTimeLabel'

     Begin Object Class=GUILabel Name=l_StatFragsLabel
         Caption="Frags"
         TextColor=(B=0,G=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinTop=0.560000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_StatFrags=GUILabel'BallisticProV55.BallisticTab_ConflictLoadoutPro.l_StatFragsLabel'

     Begin Object Class=GUILabel Name=l_StatEfficiencyLabel
         Caption="Efficiency"
         TextColor=(B=0,G=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinTop=0.580000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_StatEfficiency=GUILabel'BallisticProV55.BallisticTab_ConflictLoadoutPro.l_StatEfficiencyLabel'

     Begin Object Class=GUILabel Name=l_StatDamageRateLabel
         Caption="DamageRate"
         TextColor=(B=0,G=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinTop=0.600000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_StatDamageRate=GUILabel'BallisticProV55.BallisticTab_ConflictLoadoutPro.l_StatDamageRateLabel'

     Begin Object Class=GUILabel Name=l_StatSniperEffLabel
         Caption="Sniper Efficiency"
         TextColor=(B=0,G=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinTop=0.620000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_StatSniperEff=GUILabel'BallisticProV55.BallisticTab_ConflictLoadoutPro.l_StatSniperEffLabel'

     Begin Object Class=GUILabel Name=l_StatShotgunEffLabel
         Caption="Shotgun Efficiency"
         TextColor=(B=0,G=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinTop=0.640000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_StatShotgunEff=GUILabel'BallisticProV55.BallisticTab_ConflictLoadoutPro.l_StatShotgunEffLabel'

     Begin Object Class=GUILabel Name=l_StatHazardEffLabel
         Caption="Hazard Efficiency"
         TextColor=(B=0,G=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinTop=0.660000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_StatHazardEff=GUILabel'BallisticProV55.BallisticTab_ConflictLoadoutPro.l_StatHazardEffLabel'

     Begin Object Class=GUILabel Name=l_StatHeadingLabel
         Caption="Your Stats"
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         TextFont="UT2SmallFont"
         FontScale=FNS_Small
         WinTop=0.510000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_StatHeading=GUILabel'BallisticProV55.BallisticTab_ConflictLoadoutPro.l_StatHeadingLabel'

     Begin Object Class=GUILabel Name=l_LoadingLabel
         Caption="Receiving List..."
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         WinTop=0.400000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_Loading=GUILabel'BallisticProV55.BallisticTab_ConflictLoadoutPro.l_LoadingLabel'

     StatTimeCaption="Time: "
     StatFragsCaption="Frags: "
     StatEffCaption="Efficiency: "
     StatDmgRtCaption="DamageRate: "
     StatSnprEffCaption="Sniper Efficiency: "
     StatStgnEffCaption="Shotgun Efficiency: "
     StatHzrdEffCaption="Hazard Efficiency: "
     BoxTex=Texture'BW_Core_WeaponTex.ui.SelectionBox'
}
