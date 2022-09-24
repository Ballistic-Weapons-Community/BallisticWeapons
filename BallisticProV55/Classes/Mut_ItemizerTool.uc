//=============================================================================
// Mut_ItemizerTool.
//
// The Itemizer is a system for manually adding items to maps. it is made up
// of the following components:
//
// ItemizerDB: The item database
// The info required to spawn the items is stored in big arrays of ItemEntrys
// in the subclasses of ItemizerDB. An ItemEntry stores the class, location,
// rotation and map of an item placement operation.
//
// ItemizerDB Interface: The spawning interface
// The static function, SpawnItems() can be run from anywhere, e.g. a mutator,
// to spawn all the items that were added with the Itemizer. This make for a
// VERY simple interface for such a powerful tool. The static functions take
// care of all database selection operations.
//
// Mut_ItemizerTool: The item placement/editing tool
// This mutator should run with any gametype and is used to manually place
// each item in the maps.
//
//
// Item Placement Instructions:
// Use number keys to select the options on the menu.
// Add or change items on the menu by editing Itemizer.ini
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Mut_ItemizerTool extends Mutator config(ItemizerV21) DependsOn(ItemizerDB)
	transient
	HideDropDown
	CacheExempt;

// Stuff for the menu system --------------------------------------------------
struct ClassGroup	// Holds an array of pickup classes
{
	var() config Array<string> PickupClasses;
};
//var() config array<ClassGroup>	ClassGroups;		// All groups containing all potentiol pickups

var() config array<string>		ClassGroup0;		// All groups containing all potentiol pickups
var() config array<string>		ClassGroup1;		// Comes in the form of 7 arrays instead of a multi dimensional one
var() config array<string>		ClassGroup2;		// Works better for config reasons
var() config array<string>		ClassGroup3;
var() config array<string>		ClassGroup4;
var() config array<string>		ClassGroup5;
var() config array<string>		ClassGroup6;

var   int						SelectedGroup;		// Group the menu is currently showing. -1 = main page
var   int						SelectedScroll;		// Index of the first item of a group to show
var   class<actor>				SelectedClass;		// Currently selected item and last added class
var() string					NumberText[10];		// Al the numbers along the left margin of the menu
var() string					MainPageText[10];	// What text to put in each line of the main page of the menu
var() string					UtilPageText[10];	// What text to put in each line of the main page of the menu
var() string					BackText;			// Text for Back option
var() string					MoreText;			// Text for More option
var   bool						bMore;				// Do we need a more option for the current group
var   string					MenuText[10];		// Text sent to drawing function. The final result for each line
var   int 						SelectedItem;		// Index of the currently selected item on the current menu page
var() string					SwapOnText;			// Text for swap mode on
var() string					SwapOffText;		// Text for swap mode off
var   bool						bSwapMode;			// Is swap mode on?
var() string					ControlPlayerText;	// Text for player position control mode
var() string					ControlTraceText;	// Text for trace control mode
// End menu system ------------------------------------------------------------

// Genreal vars ---------------------------------------------------------------
var   bool						bPlayerPosMode;		// Is control mode player position or trace?
var   bool						bUprightWeapons;	// Place weapons upright or on their side
var   string					CurrentMapName;		// Name of map. GetMap() sets this first time and returns it from then on
var   actor						RotatingItem;		// Item currently being rotated
var   actor						HeldItem;			// Item currently being repositioned
var   vector					HeldOldLocation;	// Where repositioned item used to be
var   ItemizerDB				IDB;				// The Itemizer Database that is currently being used
var() config string 			ItemGroup;
var() string 		GroupDisplayText, GroupDescText;
// ----------------------------------------------------------------------------

function int GetGroupLength(int Group)
{
	switch (Group)
	{
		case 0: return ClassGroup0.length;
		case 1: return ClassGroup1.length;
		case 2: return ClassGroup2.length;
		case 3: return ClassGroup3.length;
		case 4: return ClassGroup4.length;
		case 5: return ClassGroup5.length;
		case 6: return ClassGroup6.length;
	}
	return -1;
}
function string GetGroupItem(int Group, int Item)
{
	switch (Group)
	{
		case 0: return ClassGroup0[Item];
		case 1: return ClassGroup1[Item];
		case 2: return ClassGroup2[Item];
		case 3: return ClassGroup3[Item];
		case 4: return ClassGroup4[Item];
		case 5: return ClassGroup5[Item];
		case 6: return ClassGroup6[Item];
	}
}
function int GetClassGroupCount()
{
	local int i;

	for (i=6;i>=0;i--)
		if (GetGroupLength(i) > 0)
			return i+1;
	return 0;
}

// Key pressed, do something
function KeyPress(byte Key)
{
	// Currently in a group
	if (SelectedGroup > -1)
	{
		// Go back
		if (Key == 0)
		{
			SelectedScroll=0;
			SelectedGroup = -1;
		}
		// More, scroll down
		else if (bMore && Key == 9)
		{
//			if (SelectedScroll >= ClassGroups[SelectedGroup].PickupClasses.length - 8)
			if (SelectedScroll >= GetGroupLength(SelectedGroup) - 8)
				SelectedScroll = 0;
			else
//				SelectedScroll = Max(0, Min(ClassGroups[SelectedGroup].PickupClasses.length - 8, SelectedScroll + 8));
				SelectedScroll = Max(0, Min(GetGroupLength(SelectedGroup) - 8, SelectedScroll + 8));
		}
		else if (SelectedGroup == 9)
		{
			if (HeldItem != None)
				FinishHolding(level.GetLocalPlayerController());
			else if (Key == 1)
				GrabItem(level.GetLocalPlayerController());
			else if (Key == 2)
			{
				bPlayerPosMode=!bPlayerPosMode;
				if (bPlayerPosMode) UtilPageText[1]=default.UtilPageText[1]$" Position"; else UtilPageText[1]=default.UtilPageText[1]$" Trace";
			}
			else if (Key == 3)
			{
				bUprightWeapons=!bUprightWeapons;
				if (bUprightWeapons) UtilPageText[2]=default.UtilPageText[2]$" On"; else UtilPageText[2]=default.UtilPageText[2]$" Off";
			}
		}
		// One of the items...
		else
		{
			SelectedItem = Key-1;
//			if (ClassGroups.Length > SelectedGroup)
			if (GetClassGroupCount() > SelectedGroup)
//				SelectedClass = class<Actor>(DynamicLoadObject(ClassGroups[SelectedGroup].PickupClasses[SelectedScroll+Key-1],class'Class'));
				SelectedClass = class<Actor>(DynamicLoadObject(GetGroupItem(SelectedGroup, SelectedScroll+Key-1),class'Class'));
			if (SelectedClass != None)
				AddItem(SelectedClass, level.GetLocalPlayerController());
			else
//				level.GetLocalPlayerController().ClientMessage("Could not add item, bad class"$ClassGroups[SelectedGroup].PickupClasses[SelectedScroll+Key-1]);
				level.GetLocalPlayerController().ClientMessage("Could not add item, bad class"$GetGroupItem(SelectedGroup, SelectedScroll+Key-1));
		}
	}
	else if (RotatingItem != None)
		FinishRotating(level.GetLocalPlayerController());
	// Currently on main page
	else if (SelectedGroup == -1)
	{
		if (Key == 8)
			RemoveItem(level.GetLocalPlayerController());
		else if (Key == 9)
			RotateItem(level.GetLocalPlayerController());
		else if (Key == 0)
			SelectedGroup = 9;
		else if (Key > 0 && Key < 8)
		{
			SelectedGroup = Key - 1;
//			bMore = ClassGroups.Length > SelectedGroup && ClassGroups[SelectedGroup].PickupClasses.length > 8;
			bMore = GetClassGroupCount() > SelectedGroup && GetGroupLength(SelectedGroup) > 8;
		}
	}
	GetMenuText(MenuText);
}
// Assemble the MenuText array depending on situation
function GetMenuText(out string A[10])
{
	local int i;

	for (i=0;i<10;i++)
	{
		A[i] = NumberText[i];			// First add the numbers
		if (HeldItem != None)	{
			if (i == 0)					// Hold mode, only one option
				A[i] $= "Finish Holding";	}
		else if (RotatingItem != None)	{
			if (i == 0)					// Rotate mode, only one option
				A[i] $= "Finish Rotating";	}
		else if (SelectedGroup == -1)
			A[i] $= MainPageText[i];	// Main page, add main page text
		else if (i == 9)
			A[i] $= BackText;			// Add back option
		else if (SelectedGroup == 9)
			A[i] $= UtilPageText[i];	// Add util page text
		else if (i == 8 && bMore)
			A[i] $= MoreText;			// Add more option
		// Add all the items in the add groups
//		else if (SelectedGroup < ClassGroups.Length && SelectedScroll+i < ClassGroups[SelectedGroup].PickupClasses.Length)
		else if (SelectedGroup < GetClassGroupCount() && SelectedScroll+i < GetGroupLength(SelectedGroup))
//			A[i] $= ClassGroups[SelectedGroup].PickupClasses[SelectedScroll+i];
			A[i] $= GetGroupItem(SelectedGroup, SelectedScroll+i);
	}
}
// Finds the item that the input player is focused on
function Actor TraceItem(PlayerController Sender)
{
	local Actor T, A, BestItem;
	local Vector HLoc, HNorm, Start, End;
	local float BestDist, Radius;

	if (bPlayerPosMode)
	{
		HLoc = Sender.pawn.Location;
		Radius = 200;
	}
	else
	{
		Start = Sender.Pawn.Location + Sender.Pawn.EyePosition();
		End = Start + Vector(Sender.GetViewRotation()) * 5000;
		T = Sender.Trace(HLoc, HNorm, End, Start, true);
		if (T==None)
		{
			Sender.ClientMessage("TraceItem Failed: Trace hit nothing");
			return None;
		}
		if (Pickup(T)!=None)
			return T;
		Radius = 100;
	}
	BestDist = 9999;
	foreach VisibleCollidingActors(class'Actor', A, Radius, HLoc)
	{
		if (VSize(A.Location - HLoc) < BestDist && Pickup(A) != None)
		{
			BestDist = VSize(A.Location - HLoc);
			BestItem = A;
		}
	}
	if (BestItem == None)
	{
		Sender.ClientMessage("TraceItem Failed: Could not find pickup");
		return None;
	}
	return BestItem;

}
// Traces a location for an item using a player's view
function vector TraceNewSpot(PlayerController Sender, class<Actor> NewItem, optional bool bMustHit)
{
	local Actor T;
	local Vector HLoc, HNorm, Start, End, Extent;

	if (bPlayerPosMode)
		return Sender.Pawn.Location;
	Start = Sender.Pawn.Location + Sender.Pawn.EyePosition();
	End = Start + Vector(Sender.GetViewRotation()) * 5000;

	Extent.X = NewItem.default.CollisionRadius;
	Extent.Y = NewItem.default.CollisionRadius;
	Extent.Z = NewItem.default.CollisionHeight;

	T = Trace(HLoc, HNorm, End, Start, false, Extent);
	if (T==None)
	{
		if (bMustHit)
			return vect(0,0,0);
		HLoc = End;
	}
	return HLoc;
}
// Add new item
function AddItem(class<Actor> NewItem, PlayerController Sender)
{
	local Actor A;
	local Vector HitLoc;
	local Rotator R;
	local ItemizerDB.ItemEntry IE;

	HitLoc = TraceNewSpot(Sender, NewItem, true);
	if (HitLoc == vect(0,0,0))
	{
		Sender.ClientMessage("AddItem Failed: Could not find surface");
		return;
	}

	if (!bUprightWeapons && class<weaponpickup>(NewItem) != None)
		R.Roll += 16384;
	if (bPlayerPosMode)
		R.Yaw = Sender.Pawn.Rotation.Yaw;
	A = Spawn(Newitem,,,HitLoc, R);
	if (A == None)
	{
		Sender.ClientMessage("AddItem Failed: Could not spawn item: "$NewItem);
		return;
	}

	Sender.ClientMessage("AddItem successfully added "$NewItem$", in "$ItemGroup$" Group");
	IE.MapName = GetMap();
	IE.ItemClass = NewItem;
	IE.Spot = HitLoc;
	IE.Angle = R;
	IE.Group = ItemGroup;
	IDB.AddItem(IE);
}
// Remove and item
function RemoveItem(PlayerController Sender)
{
	local Actor KilledItem;

	KilledItem = TraceItem(Sender);
	if (KilledItem == None)
		return;

	if (IDB.RemoveItem(KilledItem, GetMap()))
	{
		Sender.ClientMessage("RemoveItem successfully removed "$KilledItem.class);
		KilledItem.Destroy();
	}
	else
		Sender.ClientMessage("RemoveItem failed to remove "$KilledItem.class);
}
// Save new rotation info for item
function FinishRotating(PlayerController Sender)
{
	local ItemizerDB.ItemEntry IE;

	IE.MapName = GetMap();
	IE.Group = ItemGroup;
	IE.ItemClass = RotatingItem.class;
	IE.Spot = RotatingItem.Location;
	IE.Angle = RotatingItem.Rotation;

	IDB.UpdateItem(GetMap(), ItemGroup, IE.ItemClass, IE.Spot, IE);

	RotatingItem = None;
	Sender.ClientMessage("FinishRotating updated "$IE.ItemClass);
}
// Finds an item to rotate and switches into rotating mode
function RotateItem(PlayerController Sender)
{
	RotatingItem = TraceItem(Sender);
	if (RotatingItem == None)
		return;

	Sender.ClientMessage("RotateItem locked on to "$RotatingItem.class);
}
// Release item and save its new position
function FinishHolding(PlayerController Sender)
{
	local ItemizerDB.ItemEntry IE;

	IE.MapName = GetMap();
	IE.Group = ItemGroup;
	IE.ItemClass = HeldItem.class;
	IE.Spot = HeldItem.Location;
	IE.Angle = HeldItem.Rotation;

	IDB.UpdateItem(GetMap(), ItemGroup, IE.ItemClass, HeldOldLocation, IE);

	HeldItem = None;
	Sender.ClientMessage("FinishHolding updated "$IE.ItemClass);
}
// Holds an item so that player can reposition it
function GrabItem(PlayerController Sender)
{
	HeldItem = TraceItem(Sender);
	if (HeldItem == None)
		return;
	HeldOldLocation = HeldItem.Location;
	Sender.ClientMessage("GrabItem locked on to "$HeldItem.class);
}
// Rotate or Reposition items
function Tick(float DT)
{
	local rotator R;
	if (RotatingItem != None)
	{
		R = level.GetLocalPlayerController().Rotation;
		R.Roll = RotatingItem.Rotation.Roll;
		R.Pitch = 0;
		RotatingItem.SetRotation(R);
	}
	else if (HeldItem != None)
		HeldItem.SetLocation( TraceNewSpot(level.GetLocalPlayerController(), HeldItem.class) );
}
// Console commands...
function Mutate(string MutateString, PlayerController Sender)
{
	if (MutateString ~= "PurgeMap")
		IDB.RemoveAllFor(GetMap());
	super.Mutate(MutateString, Sender);
}
// Returns the name of the current map.
function string GetMap()
{
	if (CurrentMapName != "")
		return CurrentMapName;
	CurrentMapName = class'ItemizerDB'.static.GetMap(self);
	return CurrentMapName;
}

function PostBeginPlay()
{
	local GameRules G;

	Super.PostBeginPlay();

	IDB = class'ItemizerDB'.static.SpawnItems(GetMap(), ItemGroup, self);

	UtilPageText[1] = default.UtilPageText[1]@"Trace";
	UtilPageText[2] = default.UtilPageText[2]@"Off";
	GetMenuText(MenuText);

	G = spawn(class'ItemGameRules');
	if ( Level.Game.GameRulesModifiers == None )
		Level.Game.GameRulesModifiers = G;
	else
		Level.Game.GameRulesModifiers.AddGameRules(G);
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	bSuperRelevant = 0;
	if (Weapon(Other) != None && Weapon(Other).Class != DefaultWeapon)
		return false;
	return true;
}

static function FillPlayInfo(PlayInfo PlayInfo)
{
	Super.FillPlayInfo(PlayInfo);
	PlayInfo.AddSetting(default.RulesGroup, "ItemGroup", default.GroupDisplayText, 0, 1, "Text", "20");
}

static event string GetDescriptionText(string PropName)
{
	if (PropName == "ItemGroup")
		return default.GroupDescText;

	return Super.GetDescriptionText(PropName);
}

defaultproperties
{
     ClassGroup0(0)="BallisticProV55.X3Pickup"
     ClassGroup0(1)="BallisticProV55.A909Pickup"
     ClassGroup0(2)="BallisticProV55.EKS43Pickup"
     ClassGroup0(3)="BallisticProV55.M806Pickup"
     ClassGroup0(4)="BallisticProV55.A42Pickup"
     ClassGroup0(5)="BallisticProV55.MRT6Pickup"
     ClassGroup0(6)="BallisticProV55.XK2Pickup"
     ClassGroup0(7)="BallisticProV55.M763Pickup"
     ClassGroup0(8)="BallisticProV55.M290Pickup"
     ClassGroup0(9)="BallisticProV55.A73Pickup"
     ClassGroup0(10)="BallisticProV55.M50Pickup"
     ClassGroup0(11)="BallisticProV55.M353Pickup"
     ClassGroup0(12)="BallisticProV55.M925Pickup"
     ClassGroup0(13)="BallisticProV55.R78Pickup"
     ClassGroup0(14)="BallisticProV55.M75Pickup"
     ClassGroup0(15)="BallisticProV55.G5Pickup"
     ClassGroup0(16)="BallisticProV55.NRP57Pickup"
     ClassGroup0(17)="BallisticProV55.FP7Pickup"
     ClassGroup0(18)="BallisticProV55.FP9Pickup"
     ClassGroup0(19)="BallisticProV55.BX5Pickup"
     ClassGroup0(20)="BallisticProV55.Fifty9Pickup"
     ClassGroup0(21)="BallisticProV55.AM67Pickup"
     ClassGroup0(22)="BallisticProV55.SARPickup"
     ClassGroup0(23)="BallisticProV55.R9Pickup"
     ClassGroup0(24)="BallisticProV55.D49Pickup"
     ClassGroup0(25)="BallisticProV55.T10Pickup"
     ClassGroup0(26)="BallisticProV55.RX22APickup"
     ClassGroup0(27)="BallisticProV55.XMV850Pickup"
     ClassGroup0(28)="BWBPOne.RS8Pickup"
     ClassGroup0(29)="BWBPOne.XRS10Pickup"
     ClassGroup0(30)="BWBPOne.MRS138Pickup"
     ClassGroup0(31)="BWBPTwo.HVCMk9Pickup"
     ClassGroup0(32)="BWBPThree.SRS900Pickup"
     ClassGroup1(0)="BallisticProV55.AP_M806Clip"
     ClassGroup1(1)="BallisticProV55.AP_XK2Clip"
     ClassGroup1(2)="BallisticProV55.AP_12GaugeClips"
     ClassGroup1(3)="BallisticProV55.AP_12GaugeBox"
     ClassGroup1(4)="BallisticProV55.AP_A73Clip"
     ClassGroup1(5)="BallisticProV55.AP_556mmClip"
     ClassGroup1(6)="BallisticProV55.AP_M353Belt"
     ClassGroup1(7)="BallisticProV55.AP_M925Belt"
     ClassGroup1(8)="BallisticProV55.AP_R78Clip"
     ClassGroup1(9)="BallisticProV55.AP_M75Clip"
     ClassGroup1(10)="BallisticProV55.AP_G5Ammo"
     ClassGroup1(11)="BallisticProV55.AP_Fifty9Clip"
     ClassGroup1(12)="BallisticProV55.AP_AM67Clip"
     ClassGroup1(13)="BallisticProV55.AP_SARClip"
     ClassGroup1(14)="BallisticProV55.AP_R9Clip"
     ClassGroup1(15)="BallisticProV55.AP_6Magnum"
     ClassGroup1(16)="BallisticProV55.AP_FlamerGas"
     ClassGroup1(17)="BallisticProV55.AP_XMV850Ammo"
     ClassGroup1(18)="BWBPOne.AP_RS8Clip"
     ClassGroup1(19)="BWBPOne.AP_XRS10Clip"
     ClassGroup1(20)="BWBPOne.AP_MRS138Box"
     ClassGroup1(21)="BWBPTwo.AP_HVCMk9Cell"
     ClassGroup1(22)="BWBPThree.AP_SRS900Clip"
     ClassGroup2(0)="BallisticProV55.IP_HealthKit"
     ClassGroup2(1)="BallisticProV55.IP_Bandage"
     ClassGroup2(2)="BallisticProV55.IP_SuperHealthKit"
     ClassGroup3(0)="BallisticProV55.IP_BigArmor"
     ClassGroup3(1)="BallisticProV55.IP_SmallArmor"
     ClassGroup4(0)="BallisticProV55.IP_Adrenaline"
     ClassGroup4(1)="BallisticProV55.IP_UDamage"
     ClassGroup4(2)="BallisticProV55.IP_AmmoPack"
     SelectedGroup=-1
     NumberText(0)="1: "
     NumberText(1)="2: "
     NumberText(2)="3: "
     NumberText(3)="4: "
     NumberText(4)="5: "
     NumberText(5)="6: "
     NumberText(6)="7: "
     NumberText(7)="8: "
     NumberText(8)="9: "
     NumberText(9)="0: "
     MainPageText(0)="Add Weapons"
     MainPageText(1)="Add Ammo"
     MainPageText(2)="Add Health"
     MainPageText(3)="Add Armor"
     MainPageText(4)="Add Other"
     MainPageText(5)="Add Extra"
     MainPageText(6)="Add Vehicles"
     MainPageText(7)="Remove Item"
     MainPageText(8)="Rotate Item"
     MainPageText(9)="Utils"
     UtilPageText(0)="Grab Item"
     UtilPageText(1)="Control Mode:"
     UtilPageText(2)="Upright Weapons:"
     BackText="Back"
     MoreText="More"
     GroupDisplayText="Itemizer Group"
     GroupDescText="The name of the item layout you want to edit."
     DefaultWeaponName="BallisticProV55.ItemGun"
     GroupName="Itemizer"
     FriendlyName="Itemizer Tool (Pro)"
     Description="Warning: This is not a toy! The Itemizer is a tool to use for manually placing items in maps of any gametype. If you are adding items for a new gametype, you should have prepared an item database before using this tool. In order to play with the items placed by this tool, you will need to use a mutator that uses the Itemizer system, such as Itemizer or Ballistic Weapons."
}
