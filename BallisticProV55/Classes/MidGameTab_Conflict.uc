//=============================================================================
// MidGameTab_Conflict.
//
// Page where players choose their inventory for Conflict
//
// by Nolan "Dark Carnivour" Richert, Azarael and Sergeant Kelly
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class MidGameTab_Conflict extends MidGamePanel;

const MAIN_SECTION_INDEX = 0;
const SUB_SECTION_INDEX = 1;

var bool							bInitialized; // showpanel
var bool							bLoadInitialized;
var bool							bCamosInstalled;

var int                     		SectionSizes[2];
var int								MaxInventorySize;

var int                     		SpaceUsed[2];

var automated GUIListBox			lb_Weapons;
var GUIList                 		li_Weapons;
var Automated GUIImage				Box_WeapList, Box_Inventory, Pic_Weapon, Box_WeapIcon;
var automated GUILabel   			l_WeapTitle;
var automated GUIComboBox	 		cb_WeapLayoutIndex, cb_WeapCamoIndex;
var automated GUIScrollTextBox		tb_Desc;
var Automated GUIButton BStats, 	BClear;
var automated GUILabel				l_StatTime, l_StatFrags, l_StatEfficiency, l_StatDamageRate, l_StatSniperEff, l_StatShotgunEff, l_StatHazardEff, l_StatHeading, l_Loading;

var() localized string 				StatTimeCaption;
var() localized string 				StatFragsCaption;
var() localized string 				StatEffCaption;
var() localized string 				StatDmgRtCaption;
var() localized string				StatSnprEffCaption;
var() localized string				StatStgnEffCaption;
var() localized string 				StatHzrdEffCaption;

var() localized string 				HealthText;
var() localized string 				ArmorText;
var() localized string 				AmmoText;

var() Texture						HealthIcon;
var() Texture						ArmorIcon;
var() Texture						AmmoIcon;

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
    var() int       SectionIndex;
	var() int		ListIndex;
};

var() array<Item> 					Inventory;

var() array<int> 					LayoutIndexList;
var() array<int> 					CamoIndexList;
var() bool 							bUpdatingWeapon; //dont change layout unless we click the box
	
var() Material 						BoxTex;

var ConflictLoadoutLRI 				CLRI;

var bool 							bWaitingWeaps, bWaitingSkill;

var GUIStyles 						ConflictListStyle;

// Check for PRI update
function InitPanel()
{   
	super.InitPanel();
	
	Initialize();
}

function ShowPanel(bool bShow)	
{
	super.ShowPanel(bShow);
	
	if (li_Weapons != None && li_Weapons.IsSection())
	{
		cb_WeapLayoutIndex.SetVisibility(false); //begone boxes!
		cb_WeapCamoIndex.SetVisibility(false); //begone from me!
	}
}

function Initialize()
{
	local class<BC_GameStyle> style;
    local eFontScale FS;
	//local Material M;

	if (bInitialized)
		return;


	style = class'BallisticGameStyles'.static.GetReplicatedStyle();

	SectionSizes[0] = style.default.ConflictWeaponSlots;
	SectionSizes[1] = style.default.ConflictEquipmentSlots;

	MaxInventorySize = SectionSizes[0] + SectionSizes[1];
	
    Controller.RegisterStyle(class'STY2ConflictList', true);

    ConflictListStyle = Controller.GetStyle("ConflictList", FS);

    li_Weapons = lb_Weapons.List;

    li_Weapons.OnDrawItem = OnDrawConflictItem;
	li_Weapons.OnChange = InternalOnChange;
	li_Weapons.OnDblClick = InternalOnDblClick;
	
	CLRI = ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(PlayerOwner().PlayerReplicationInfo));
	
	if (CLRI == None)
		SetTimer(0.05, true);
	else
		OnLRIAcquired();

	/*M = Material(DynamicLoadObject("BWBP_Camos_Tex.SARCamos.AAS-Circle", class'Material')); //Todo, replace with a canary
	if (M != None)
	{
		bCamosInstalled=True;
	}*/

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
	local int i, j, lastIndex;
	//local BC_WeaponInfoCache.WeaponInfo WI;
	
	Log("MidGameTab_Conflict: InitWeaponLists");

	l_Loading.Caption = "";
	l_Loading.Hide();

	li_Weapons.Clear();
	cb_WeapLayoutIndex.Clear();
	cb_WeapCamoIndex.Clear();

	//Only explicitly load saved inventory.	
	Inventory.length = 0;

	SpaceUsed[MAIN_SECTION_INDEX] = 0;
    SpaceUsed[SUB_SECTION_INDEX] = 0;

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
		
        // handle conflict items
		if (InStr(CLRI.FullInventoryList[i].ClassName, "CItem") != -1)
		{ 
			if (lastIndex != -1)
			{
				lastIndex = -1;
				li_Weapons.Add("Misc",,"Mc",true);
				LayoutIndexList.Insert(LayoutIndexList.Length, 1);
				CamoIndexList.Insert(CamoIndexList.Length, 1);
			}
			
			CI = class<ConflictItem>(DynamicLoadObject(CLRI.FullInventoryList[i].ClassName, class'Class'));
			
			if (CI != None)
			{
				li_Weapons.Add(CI.default.ItemName, , string(i));
				LayoutIndexList.Insert(LayoutIndexList.Length, 1);
				CamoIndexList.Insert(CamoIndexList.Length, 1);
			}
		}
		
        // handle weapons
		else 
		{
            if (CLRI.FullInventoryList[i].InventoryGroup != lastIndex)
            {
                lastIndex = CLRI.FullInventoryList[i].InventoryGroup;
                li_Weapons.Add(class'BallisticWeaponClassInfo'.static.GetHeading(lastIndex),, "Weapon Category", true);
				LayoutIndexList.Insert(LayoutIndexList.Length, 1);
				CamoIndexList.Insert(CamoIndexList.Length, 1);
            }
            
            li_Weapons.Add(CLRI.FullInventoryList[i].ItemName, , string(i));
			LayoutIndexList.Insert(LayoutIndexList.Length, 1);
			CamoIndexList.Insert(CamoIndexList.Length, 1);
			for (j=0; j < Inventory.length; j++)
			{
				//if (Inventory[j].ListIndex != 0)
				//	continue;
				//log("INV: "$CLRI.FullInventoryList[i].ItemName$" Inv: " $Inventory[j].ClassName);
				if (CLRI.FullInventoryList[i].ClassName == Inventory[j].ClassName)
					Inventory[j].ListIndex=li_Weapons.ItemCount-1; //Tie our inventory to the list if possible
			}
		}
	}
}

//give this function a gun, grab an array of layouts from cache, add each value to the combobox
// Azarael note: it's very unusual to pass a GUI component that is a member variable of a class to an instance function of that class
// leaving the signature as it is because I'm not sure of your future intent
function bool LoadLIFromBW(class<BallisticWeapon> BW)
{
	local byte GameStyleIndex;
	local int i;
		
	//clear old layouts
	cb_WeapLayoutIndex.Clear();
	
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
				cb_WeapLayoutIndex.AddItem("Default");
			else
				cb_WeapLayoutIndex.AddItem("Layout: "$string(i));
		}
		else
			cb_WeapLayoutIndex.AddItem(BW.default.ParamsClasses[GameStyleIndex].default.Layouts[i].LayoutName);
	}
	
	return true;
}

//give this function a gun, grab an array of layouts from cache, add each value to the combobox

function bool LoadCIFromBW(class<BallisticWeapon> BW, int LayoutIndex)
{
	local byte GameStyleIndex;
	local int i;
	local array<int> AllowedCamos;
	//clear old layouts
	cb_WeapCamoIndex.Clear();
	
	if (LayoutIndex == -1) //layout box isn't even loaded yet
		return false;
		
	/*if (!bCamosInstalled)
	{
		cb_WeapCamoIndex.AddItem("Not Installed",, "0");
		return true;
	}*/
	
	GameStyleIndex = class'BallisticReplicationInfo'.default.GameStyle;

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
					cb_WeapCamoIndex.AddItem("None",, "0");
				else
					cb_WeapCamoIndex.AddItem("Layout: "$string(i),, String(BW.default.ParamsClasses[GameStyleIndex].default.Camos[i].Index));
			}
			cb_WeapCamoIndex.AddItem(BW.default.ParamsClasses[GameStyleIndex].default.Camos[i].CamoName,, String(BW.default.ParamsClasses[GameStyleIndex].default.Camos[i].Index));
		}
		cb_WeapCamoIndex.setIndex(CamoIndexList[lb_Weapons.List.Index]);
	}
	else
	{
		for (i = 0; i < AllowedCamos.Length; i++)
		{
			cb_WeapCamoIndex.AddItem(BW.default.ParamsClasses[GameStyleIndex].default.Camos[AllowedCamos[i]].CamoName,, String(BW.default.ParamsClasses[GameStyleIndex].default.Camos[AllowedCamos[i]].Index));
			if (CamoIndexList[lb_Weapons.List.Index] == BW.default.ParamsClasses[GameStyleIndex].default.Camos[AllowedCamos[i]].Index) //these damn boxes changing sizes
				cb_WeapCamoIndex.setIndex(i);
		}
	}
	
	if (cb_WeapCamoIndex.ItemCount() == 0)
		cb_WeapCamoIndex.AddItem("None",, "255");
	
	if (cb_WeapCamoIndex.ItemCount() > 1 && !class'BallisticReplicationInfo'.default.bNoRandomCamo)
	{
		cb_WeapCamoIndex.AddItem("Random",, "255");
		if (CamoIndexList[lb_Weapons.List.Index] == 255) //these damn boxes changing sizes
			cb_WeapCamoIndex.setIndex(cb_WeapCamoIndex.ItemCount()-1);
	}
	
	return true;
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

function int GetMaxCount(class<BallisticWeapon> weapon)
{
	local int base_ammo, max_ammo;

	// may have 2 of any dual wieldable handgun
	if (class<BallisticHandgun>(weapon) != None && class<BallisticHandgun>(weapon).default.bShouldDualInLoadout)
		return 2;

	// allow game styles to limit the maximum count of some weapons (used for grenades)
	if (weapon.static.GetParams() != None && weapon.static.GetParams().default.Layouts[0].MaxInventoryCount > 0)
		return weapon.static.GetParams().default.Layouts[0].MaxInventoryCount;

	// otherwise, allow copies for extra ammo
	base_ammo = Max(1, weapon.default.FireModeClass[0].default.AmmoClass.default.InitialAmount);
	max_ammo = weapon.default.FireModeClass[0].default.AmmoClass.default.MaxAmmo;

	if (max_ammo % base_ammo == 0)
		return Max(1, max_ammo / base_ammo);

	return Max(1, Ceil(float(max_ammo) / float(base_ammo)));
}

function bool MaxReached(class<BallisticWeapon> weapon, string class_name)
{
	return CountExisting(class_name) >= GetMaxCount(weapon);
}

function bool GroupPriorityOver(int inserting_group, int target_group)
{
    switch(inserting_group)
	{
		case 1: // melee
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

function int GetInsertionPoint(class<BallisticWeapon> InsertWeapon)
{
	local int i, SectionIndex, ItemSize, InsertingGroup, CurrentItemGroup;

    SectionIndex = class'Mut_ConflictLoadout'.static.GetSectionIndex(InsertWeapon);
    ItemSize = class'Mut_ConflictLoadout'.static.GetItemSize(InsertWeapon);
    InsertingGroup = InsertWeapon.default.InventoryGroup;

	if (InsertingGroup == 0)
		InsertingGroup = 11;
	
	for (i = 0; i < Inventory.Length; ++i)
	{
        // if inserting main weapon, and comparing to sub, insert before it
        if (Inventory[i].SectionIndex > SectionIndex)
            break;

        // if inserting sub weapon, and comparing to main, insertion point is somewhere after
        if (Inventory[i].SectionIndex < SectionIndex)
            continue;

        // check to see if we always insert before this weapon, by inventory group
		CurrentItemGroup = Inventory[i].InventoryGroup;
		
		if (CurrentItemGroup == 0)
			CurrentItemGroup = 11;
			
		if (GroupPriorityOver(InsertingGroup, CurrentItemgroup))
			break;

        // otherwise, if bigger, insert here
        if (ItemSize > Inventory[i].Size)
            break;

	}
	
	return i;
}

function bool AddInventory(string ClassName, class<actor> InvClass, string FriendlyName, optional int PassedLayoutIndex, optional int PassedCamoIndex)
{
	local int i, Size, A;
    local int SectionIndex;
	local class<BallisticWeapon> WeaponClass;

	if (InvClass == None)
	{
		Log("MidGameTab_Conflict::AddInventory: InvClass was None");
		return false;
	}
		
	if (class<ConflictItem>(InvClass) != None)
		return HandleConflictItem(InvClass, FriendlyName);
	
	WeaponClass = class<BallisticWeapon>(InvClass);

	if (WeaponClass == None)
	{
		Log("MidGameTab_Conflict::AddInventory: InvClass was not a Ballistic weapon.");
		return false;
	}

	if (MaxReached(WeaponClass, ClassName))
	{
		Log("MidGameTab_Conflict::AddInventory: Maximum count reached for "$ClassName);
		return false;
	}

    SectionIndex = class'Mut_ConflictLoadout'.static.GetSectionIndex(WeaponClass);

	Size = class'Mut_ConflictLoadout'.static.GetItemSize(WeaponClass);

	if (SpaceUsed[SectionIndex] + Size > SectionSizes[SectionIndex])
	{
		Log("MidGameTab_Conflict::AddInventory: No room in section "$SectionIndex$": Used "$SpaceUsed[SectionIndex]$"/"$SectionSizes[SectionIndex]$", requesting "$Size);
		return false;
	}

	SpaceUsed[SectionIndex] += Size;
	
	i = GetInsertionPoint(WeaponClass);
	
	Inventory.Insert(i, 1);
	
	Inventory[i].ClassName = string(WeaponClass);
	Inventory[i].Size = Size;
	Inventory[i].Title = FriendlyName;
	Inventory[i].InventoryGroup = WeaponClass.default.InventoryGroup;
	Inventory[i].CamoIndex = PassedCamoIndex;
	Inventory[i].LayoutIndex = PassedLayoutIndex;
    Inventory[i].SectionIndex = SectionIndex;
	Inventory[i].ListIndex = li_Weapons.Index;
	
	A = WeaponClass.default.FireModeClass[0].default.AmmoClass.default.InitialAmount;

	if (!WeaponClass.default.bNoMag)
		A += WeaponClass.default.MagAmmo;
	
	Inventory[i].Icon = WeaponClass.default.BigIconMaterial;
	
	Inventory[i].Ammo = string(A);
	
	if (WeaponClass.default.FireModeClass[1].default.AmmoClass != None &&
		WeaponClass.default.FireModeClass[1].default.AmmoClass != WeaponClass.default.FireModeClass[0].default.AmmoClass &&
		WeaponClass.default.FireModeClass[1].default.AmmoClass.default.InitialAmount > 0)
	{
		Inventory[i].Ammo = WeaponClass.default.FireModeClass[1].default.AmmoClass.default.InitialAmount $ " / " $ Inventory[i].Ammo;
	}
	
	if (!CLRI.ValidateWeapon(ClassName))
		Inventory[i].bBad = true;
	
	return true;
}

// called when camo or layout index changes. presumably we're setting this for a weapon we already have
function UpdateExistingInventory(int weapon_list_index)
{
	local int i, clri_inv_offset;

	clri_inv_offset = int(li_Weapons.GetExtraAtIndex(weapon_list_index));

	for (i = 0; i < Inventory.Length; ++i)
	{
		if (Inventory[i].ClassName != CLRI.FullInventoryList[clri_inv_offset].ClassName)
			continue;

		Inventory[i].CamoIndex = CamoIndexList[weapon_list_index];
		Inventory[i].LayoutIndex = LayoutIndexList[weapon_list_index];

		// don't break after finding an instance of the class
		// might have other instances of the same weapon from dual wield - better to sync them all
	}
}

function bool HandleConflictItem(class<actor> InvClass, string FriendlyName)
{
	local int i, Size;
	
	Size = class<ConflictItem>(InvClass).default.Size/5;
	
	if (SpaceUsed[SUB_SECTION_INDEX] + Size > SectionSizes[SUB_SECTION_INDEX])
		return false;

	SpaceUsed[SUB_SECTION_INDEX] += Size;
	i = Inventory.length;
	Inventory.length = i + 1;
	Inventory[i].ClassName = string(InvClass);
	Inventory[i].Size = Size;
	Inventory[i].Title = FriendlyName;
	Inventory[i].Icon = class<ConflictItem>(InvClass).default.Icon;
	Inventory[i].Ammo = class<ConflictItem>(InvClass).default.ItemAmount;
	Inventory[i].InventoryGroup = 12;
    Inventory[i].SectionIndex = SUB_SECTION_INDEX;

	return true;
}

//Add inventory to the bottom bar
function bool InternalOnDblClick(GUIComponent Sender)
{
	if (Sender==li_Weapons)
	{
		AddInventory(string(li_Weapons.GetObject()), class<Actor>(li_Weapons.GetObject()), li_Weapons.Get(), LayoutIndexList[li_Weapons.Index], int(cb_WeapCamoIndex.getExtra()));
	}

	return true;
}

function int GetClickedInventoryIndex()
{
    local int i, X, ItemSize;

    X = Box_Inventory.Bounds[0];

    // main items
    for (i = 0; i < Inventory.length && Inventory[i].SectionIndex == MAIN_SECTION_INDEX; i++)
    {
        ItemSize = (Box_Inventory.ActualWidth()/MaxInventorySize) * Inventory[i].Size;

        if (Controller.MouseX > X && Controller.MouseX < X + ItemSize)
        {
            return i;
        }
        X += ItemSize;
    }

    X = Box_Inventory.Bounds[0] + (Box_Inventory.ActualWidth() / MaxInventorySize) * SectionSizes[MAIN_SECTION_INDEX];

    // sub items - use offset
    while (i < Inventory.Length) // unrealscript won't handle a for loop with an empty initializer, lol
    {
        ItemSize = (Box_Inventory.ActualWidth()/MaxInventorySize) * Inventory[i].Size;

        if (Controller.MouseX > X && Controller.MouseX < X + ItemSize)
            return i;

        X += ItemSize;
        ++i;
    }

    return Inventory.Length;
}

function bool InternalOnClick(GUIComponent Sender)
{
	local int i;

	//Figure out which currently existing item the player clicked on and then make it our primary gun, open it in list view.
	if (Sender == Box_Inventory)
	{
        i = GetClickedInventoryIndex();

        if (i < Inventory.Length)
		{
		    class'ConflictLoadoutConfig'.static.UpdateSavedInitialIndex(i);
			if (Inventory[i].ListIndex != 0) //Open this item in the list
			{
				LayoutIndexList[Inventory[i].ListIndex] = Inventory[i].LayoutIndex;
				CamoIndexList[Inventory[i].ListIndex] = Inventory[i].CamoIndex;
				li_Weapons.setIndex(Inventory[i].ListIndex); 
			}
		}
		return true;
	}
	
	if (Sender == BStats && CLRI != None)
	{
		Controller.OpenMenu("BallisticProV55.BallisticConflictInfoMenu");

		if (BallisticConflictInfoMenu(Controller.ActivePage) != None)
			BallisticConflictInfoMenu(Controller.ActivePage).LoadWeapons(self);

         return true;
	}
	
	if (Sender == BClear)
	{
		Inventory.Length = 0;

		SpaceUsed[MAIN_SECTION_INDEX] = 0;
        SpaceUsed[SUB_SECTION_INDEX] = 0;

        return true;
	}

	return true;
}

function bool InternalOnRightClick(GUIComponent Sender)
{
	local int i;

	//Figure out which currently existing item the player clicked on and then remove it.
	if (Sender == Box_Inventory)
	{
        i = GetClickedInventoryIndex();

        if (i < Inventory.Length)
        {
			SpaceUsed[Inventory[i].SectionIndex] -= Inventory[i].Size;
			Inventory.Remove(i, 1);
        }

        return true;
	}
	
	if (Sender==BStats && CLRI!=None)
	{
		Controller.OpenMenu("BallisticProV55.BallisticConflictInfoMenu");

		if (BallisticConflictInfoMenu(Controller.ActivePage) != None)
			BallisticConflictInfoMenu(Controller.ActivePage).LoadWeapons(self);

            return true;
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
    local int inv_offset;
	
	if (Sender==li_Weapons)
	{
		l_WeapTitle.Caption = li_Weapons.SelectedText();
		
		//Section header.
		if (li_Weapons.IsSection())
		{
			tb_Desc.SetContent(class'BallisticWeaponClassInfo'.static.GetClassDescription(li_Weapons.SelectedText()));
			Pic_Weapon.Image = None;
			cb_WeapLayoutIndex.SetVisibility(false);
			cb_WeapCamoIndex.SetVisibility(false);
			return;
		}

		//Check for items which have already been loaded.
		if (li_Weapons.GetObject() != None)
		{
			if (class<BallisticWeapon>(li_Weapons.GetObject()) != None)
			{
				bUpdatingWeapon=true;
				BW = class<BallisticWeapon>(li_Weapons.GetObject());
				Pic_Weapon.Image = BW.default.BigIconMaterial;
				tb_Desc.SetContent(BW.static.GetShortManual());
				log("Loading layout of gun at loc "$lb_Weapons.List.Index$" with "$LayoutIndexList[lb_Weapons.List.Index]); 
				LoadLIFromBW(BW);
				cb_WeapLayoutIndex.setIndex(LayoutIndexList[lb_Weapons.List.Index]);
				LoadCIFromBW(BW, LayoutIndexList[lb_Weapons.List.Index]);
				//cb_WeapCamoIndex.setIndex(CamoIndexList[lb_Weapons.List.Index]);
				cb_WeapLayoutIndex.SetVisibility(true);
				cb_WeapCamoIndex.SetVisibility(true);
				bUpdatingWeapon=false;
				return;
			}
			if (class<ConflictItem>(li_Weapons.GetObject()) != None)
			{
				Pic_Weapon.Image = class<ConflictItem>(li_Weapons.GetObject()).default.Icon;
				tb_Desc.SetContent(class<ConflictItem>(li_Weapons.GetObject()).default.Description);
				cb_WeapLayoutIndex.SetVisibility(false);
				cb_WeapCamoIndex.SetVisibility(false);
				return;
			}
			return;
		}

        if (li_Weapons.GetObject() == None) //Item not loaded. Load it and add it as the Object for the weapons list's current position.
        {
            inv_offset = int(li_Weapons.GetExtra());

            if (inv_offset != -1)
            {
                BW = class<BallisticWeapon>(DynamicLoadObject(CLRI.FullInventoryList[inv_offset].ClassName, class'Class'));
                if (BW != None)
                {
					bUpdatingWeapon=true;
					Pic_Weapon.Image = BW.default.BigIconMaterial;
					tb_Desc.SetContent(BW.static.GetShortManual());
					li_Weapons.SetObjectAtIndex(li_Weapons.Index, BW);
					if (LayoutIndexList[li_Weapons.Index] == 0 && CamoIndexList[li_Weapons.Index] == 0) //check if initial load came with set layout
					{
						LoadLIFromBW(BW);
						LayoutIndexList[li_Weapons.Index] = cb_WeapLayoutIndex.getIndex();
						LoadCIFromBW(BW, cb_WeapLayoutIndex.getIndex());
					}
					else
					{
						LoadLIFromBW(BW);
						cb_WeapLayoutIndex.setIndex(LayoutIndexList[li_Weapons.Index]);
						LoadCIFromBW(BW, LayoutIndexList[li_Weapons.Index]);
					}
					CamoIndexList[li_Weapons.Index] = cb_WeapCamoIndex.getIndex();
					cb_WeapLayoutIndex.SetVisibility(true);
					cb_WeapCamoIndex.SetVisibility(true);
					bUpdatingWeapon=false;
                }
            }
        }
	}	
	else if (Sender == cb_WeapLayoutIndex )
	{
		if (li_Weapons.GetObject() != None && class<BallisticWeapon>(li_Weapons.GetObject()) != None && !bUpdatingWeapon)
		{
			LayoutIndexList[li_Weapons.Index] = cb_WeapLayoutIndex.getIndex();
			if (class<BallisticWeapon>(li_Weapons.GetObject()) != None)
			{
				BW = class<BallisticWeapon>(li_Weapons.GetObject());
				LoadCIFromBW(BW, LayoutIndexList[li_Weapons.Index]);
			}
			log("Setting layout index of gun at loc "$li_Weapons.Index$" to "$cb_WeapLayoutIndex.getIndex()); 

			UpdateExistingInventory(li_Weapons.Index);
		}
	}	
	else if (Sender == cb_WeapCamoIndex )
	{
		if (li_Weapons.GetObject() != None && class<BallisticWeapon>(li_Weapons.GetObject()) != None && !bUpdatingWeapon)
		{
			CamoIndexList[li_Weapons.Index] = int(cb_WeapCamoIndex.getExtra());
			log("Setting camo index of gun at loc "$li_Weapons.Index$" to "$cb_WeapCamoIndex.getExtra()); 

			UpdateExistingInventory(li_Weapons.Index);
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
function OnDrawConflictItem(Canvas Canvas, int i, float X, float Y, float W, float H, bool bSelected, bool bPending)
{
    local eMenuState m;
    local eFontScale F;
    local float xl,yl;
    local GUIStyles style;
    local float mX, mY, BarW;
    local string s;
    local int inv_offset;
    local int inv_size;

    F = FNS_Medium;

    Y += H*0.1;
    H -= H*0.2;

    if ( bSelected )
    {
        m = MSAT_Focused;
    }
    else
    {
        m = MSAT_Blurry;
    }

    if (li_Weapons.Elements[i].bSection)
    {
        // C++ code to draw section
        style = li_Weapons.SectionStyle;
        style.TextSize(Canvas,m, li_Weapons.GetItemAtIndex(i),XL,YL,F);

		mX = X + (W/2);
		mY = Y + (H/2);

        style.DrawText( Canvas, m, mX-(XL/2), mY-(YL/2), XL, YL, TXTA_Center, li_Weapons.GetItemAtIndex(i), F);
        
        BarW = ((W - XL) /2) * 0.8;

        Canvas.SetPos(X + BarW * 0.1, mY - 2);
        Canvas.SetDrawColor(255,128,64,255);
		Canvas.DrawTile(Controller.DefaultPens[0], BarW, 5, 0, 0, 8, 8);
		
        Canvas.SetPos(mX + (XL/2) + BarW * 0.1, mY-2);
        Canvas.SetDrawColor(255,128,64,255);
        Canvas.DrawTile(Controller.DefaultPens[0], BarW, 5, 0, 0, 8, 8);

        return;
    }

    style = ConflictListStyle;

    if (bSelected)
    {
        Canvas.SetPos(X,Y);
        Canvas.SetDrawColor(32,32,128,255);		// FIXME: Add a var
        Canvas.DrawTile(Controller.DefaultPens[0], W, H, 0, 0, 2, 2);
    }

    inv_offset = int(li_Weapons.GetExtraAtIndex(i));

    inv_size = CLRI.FullInventoryList[inv_offset].InventorySize;

	// validation step
	if (CLRI.CanUseWeaponAtIndex(inv_offset))
	{
		style.TextSize(Canvas,m, li_Weapons.GetItemAtIndex(i),XL,YL,F);
		style.DrawText( Canvas, m, X, Y, W, YL, TXTA_Left, li_Weapons.GetItemAtIndex(i), F);

		if (inv_size > 1)
			s = inv_size $ " slots"; 
		else if (inv_size == 1)
			s = "1 slot";
		else 
			s = "Free";

		style.TextSize(Canvas, m, s, XL, YL, F);
		style.DrawText( Canvas, m, X + W - XL, Y, XL, YL, TXTA_Right, s, F);
	}

	else 
	{
		Canvas.SetDrawColor(64,64,64,255);		// FIXME: Add a var

		// can we force the style to be set?
		style.TextSize(Canvas,m, li_Weapons.GetItemAtIndex(i),XL,YL,F);
		Canvas.SetPos(X, Y);
		Canvas.DrawText(li_Weapons.GetItemAtIndex(i));

		Canvas.TextSize("Disabled", XL, YL);
		Canvas.SetPos(X + W - XL, Y);
		Canvas.DrawText("Disabled");
	}
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
    local int LastSectionIndex;
    local int SlotWidth;

    local string DisplayString;

    initial_wep_index = class'ConflictLoadoutConfig'.static.GetSavedInitialWeaponIndex();

	ScaleFactor = float(Controller.ResX)/1600;
	MyX = Box_Inventory.Bounds[0] + 24*ScaleFactor;
	MyY = Box_Inventory.Bounds[1] + 24*ScaleFactor;
	MyW = Box_Inventory.ActualWidth() - 48*ScaleFactor;
	MyH = Box_Inventory.ActualHeight() - 48*ScaleFactor;

    SlotWidth = MyW / MaxInventorySize;

	C.SetDrawColor(255,255,255,255);
	C.SetPos(MyX, Myy);
	C.DrawTile(Controller.DefaultPens[1], MyW, MyH, 0, 0, 1, 1);

    // draw free slot indicators for primary weapons
	C.SetDrawColor(128,64,0,255);

	X = MyX;

    X += SlotWidth * SpaceUsed[MAIN_SECTION_INDEX];

	for(i = SpaceUsed[MAIN_SECTION_INDEX]; i < SectionSizes[MAIN_SECTION_INDEX]; i++)
	{
		C.SetPos(X, Myy);
		C.DrawTile(BoxTex, SlotWidth, MyH, 0, 0, 128, 64);
		X += SlotWidth;
	}

    // draw free slot indicators for sub weapons
    C.SetDrawColor(0,64,128,255);

    X += SlotWidth * SpaceUsed[SUB_SECTION_INDEX];

    for(i = SpaceUsed[SUB_SECTION_INDEX]; i < SectionSizes[SUB_SECTION_INDEX]; i++)
	{
		C.SetPos(X, Myy);
		C.DrawTile(BoxTex, SlotWidth, MyH, 0, 0, 128, 64);
		X += SlotWidth;
	}

	X = MyX;
	C.Style = 6;

	for (i = 0; i < Inventory.length; i++)
	{
        // push the offset along when switching to the sub weapons
        if (Inventory[i].SectionIndex != LastSectionIndex)
        {
            LastSectionIndex = Inventory[i].SectionIndex;
            X = MyX + (SlotWidth) * SectionSizes[MAIN_SECTION_INDEX];
        }

		if (Inventory[i].bBad)
			C.SetDrawColor(255,64,64,255);      // weapon is bad - red tint
        else if (i == initial_wep_index)
            C.SetDrawColor(192,255,192,255);    // green tint for currently selected weapon
        else
			C.SetDrawColor(255,255,255,255);    // no tint

        //can't exceed twice the height - Azarael
        ItemSize = SlotWidth * Inventory[i].Size;
        IconX = FMin(ItemSize, MyH*2.3);
        IconY = IconX/2;

        if (Inventory[i].Icon != None)
        {	C.SetPos(X + (ItemSize - IconX)/2, MyY + (MyH-IconY)/2);
            C.DrawTile(Inventory[i].Icon, IconX, IconY, 0, 0, Inventory[i].Icon.MaterialUSize(), Inventory[i].Icon.MaterialVSize());	
        }

		if (Inventory[i].bBad)
			C.SetDrawColor(255,0,0,255);    // weapon is bad - red surround
        //else if (i == initial_wep_index)
        //    C.SetDrawColor(32,255,0,255);   // green surround for starter
		else if (Inventory[i].SectionIndex == MAIN_SECTION_INDEX)
			C.SetDrawColor(255,128,0,255); // orange frame for primary
        else
			C.SetDrawColor(0,128,255,255);  // blue frame for secondary

		C.SetPos(X, MyY);
		C.DrawTileStretched(BoxTex, ItemSize, MyH);

        // draw weapon name
        DisplayString = Inventory[i].Title;

        if (i == initial_wep_index)
        {
            C.SetDrawColor(32,255,0,255);
            DisplayString $= " - Initial";
        }
		else if (Inventory[i].SectionIndex == MAIN_SECTION_INDEX)
			C.SetDrawColor(255,128,0,255); // orange text for primary
        else
			C.SetDrawColor(0,128,255,255);  // blue text for secondary

		C.Font = Controller.GetMenuFont("UT2SmallFont").GetFont(C.ClipX*0.8);
		C.StrLen(DisplayString, XL, YL);
		if (XL > ItemSize)
		{
			j = InStr(DisplayString, " ");
			s = Left(DisplayString, j);
			C.SetPos(X+4*ScaleFactor, MyY + MyH - YL*2 - 4*ScaleFactor);
			C.DrawText(s, false);

			s = Right(DisplayString, Len(DisplayString)-j-1);
			C.SetPos(X+4*ScaleFactor, MyY + MyH - YL - 4*ScaleFactor);
			C.DrawText(s, false);
		}
		else
		{
			C.SetPos(X+4*ScaleFactor, MyY + MyH - YL - 4*ScaleFactor);
			C.DrawText(DisplayString, false);
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
    SectionSizes(0)=10
    SectionSizes(1)=2

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
         StyleName="Page"
		 SelectedStyleName="Page"
         FontScale=FNS_Medium
         TabOrder=1
     End Object
     lb_Weapons=GUIListBox'BallisticProV55.MidGameTab_Conflict.lb_WeaponsList'

     Begin Object Class=GUIImage Name=Box_WeapListImg
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.02000
         WinWidth=0.430000
         WinHeight=0.675000
         RenderWeight=0.002000
     End Object
     Box_WeapList=GUIImage'BallisticProV55.MidGameTab_Conflict.Box_WeapListImg'

     Begin Object Class=GUIImage Name=Box_InventoryImg
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.700000
         WinHeight=0.200000
         RenderWeight=0.002000
         bAcceptsInput=True
         OnRendered=MidGameTab_Conflict.DrawInventory
         OnClick=MidGameTab_Conflict.InternalOnClick
         OnRightClick=MidGameTab_Conflict.InternalOnRightClick
     End Object
     Box_Inventory=GUIImage'BallisticProV55.MidGameTab_Conflict.Box_InventoryImg'

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
     Pic_Weapon=GUIImage'BallisticProV55.MidGameTab_Conflict.Pic_WeaponImg'

     Begin Object Class=GUIImage Name=Box_WeapIconImg
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.020000
         WinLeft=0.450000
         WinWidth=0.540000
         WinHeight=0.675000
         RenderWeight=0.002000
     End Object
     Box_WeapIcon=GUIImage'BallisticProV55.MidGameTab_Conflict.Box_WeapIconImg'

     Begin Object Class=GUILabel Name=l_WeapTitlelabel
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255,R=255)
         WinTop=0.020000
         WinLeft=0.51000
         WinWidth=0.430000
         WinHeight=0.050000
     End Object
     l_WeapTitle=GUILabel'BallisticProV55.MidGameTab_Conflict.l_WeapTitlelabel'

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
     tb_Desc=GUIScrollTextBox'BallisticProV55.MidGameTab_Conflict.WeaponDescription'
	 
     Begin Object Class=GUIComboBox Name=cb_WeapLayoutIndexComBox
         MaxVisibleItems=16
         Hint="Weapon layouts."
         WinTop=0.280000
         WinLeft=0.48
         WinWidth=0.196094
         WinHeight=0.040000
         TabOrder=0
         OnChange=MidGameTab_Conflict.InternalOnChange
         OnKeyEvent=cb_WeapLayoutIndexComBox.InternalOnKeyEvent
     End Object
     cb_WeapLayoutIndex=GUIComboBox'BallisticProV55.MidGameTab_Conflict.cb_WeapLayoutIndexComBox'
	 
     Begin Object Class=GUIComboBox Name=cb_WeapCamoIndexComBox
         MaxVisibleItems=16
         Hint="Weapon camos."
         WinTop=0.280000
         WinLeft=0.74
         WinWidth=0.196094
         WinHeight=0.040000
         TabOrder=0
         OnChange=MidGameTab_Conflict.InternalOnChange
         OnKeyEvent=cb_WeapCamoIndexComBox.InternalOnKeyEvent
     End Object
     cb_WeapCamoIndex=GUIComboBox'BallisticProV55.MidGameTab_Conflict.cb_WeapCamoIndexComBox'
	 
     Begin Object Class=GUIButton Name=BClearButton
         Caption="Clear Loadout"
         WinTop=0.92000
         WinLeft=0.20000
         WinWidth=0.200000
         TabOrder=1
         OnClick=MidGameTab_Conflict.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bClear=GUIButton'BallisticProV55.MidGameTab_Conflict.BClearButton'
	 
	 Begin Object Class=GUIButton Name=BStatButton
         Caption="Stats"
         WinTop=0.920000
         WinLeft=0.600000
         WinWidth=0.200000
         TabOrder=1
         OnClick=MidGameTab_Conflict.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     bStats=GUIButton'BallisticProV55.MidGameTab_Conflict.BStatButton'

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
     l_StatTime=GUILabel'BallisticProV55.MidGameTab_Conflict.l_StatTimeLabel'

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
     l_StatFrags=GUILabel'BallisticProV55.MidGameTab_Conflict.l_StatFragsLabel'

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
     l_StatEfficiency=GUILabel'BallisticProV55.MidGameTab_Conflict.l_StatEfficiencyLabel'

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
     l_StatDamageRate=GUILabel'BallisticProV55.MidGameTab_Conflict.l_StatDamageRateLabel'

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
     l_StatSniperEff=GUILabel'BallisticProV55.MidGameTab_Conflict.l_StatSniperEffLabel'

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
     l_StatShotgunEff=GUILabel'BallisticProV55.MidGameTab_Conflict.l_StatShotgunEffLabel'

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
     l_StatHazardEff=GUILabel'BallisticProV55.MidGameTab_Conflict.l_StatHazardEffLabel'

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
     l_StatHeading=GUILabel'BallisticProV55.MidGameTab_Conflict.l_StatHeadingLabel'

     Begin Object Class=GUILabel Name=l_LoadingLabel
         Caption="Receiving List..."
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         WinTop=0.400000
         WinLeft=0.550000
         WinWidth=0.400000
         WinHeight=0.030000
     End Object
     l_Loading=GUILabel'BallisticProV55.MidGameTab_Conflict.l_LoadingLabel'

     StatTimeCaption="Time: "
     StatFragsCaption="Frags: "
     StatEffCaption="Efficiency: "
     StatDmgRtCaption="DamageRate: "
     StatSnprEffCaption="Sniper Efficiency: "
     StatStgnEffCaption="Shotgun Efficiency: "
     StatHzrdEffCaption="Hazard Efficiency: "
     BoxTex=Texture'BW_Core_WeaponTex.ui.SelectionBox'
}
