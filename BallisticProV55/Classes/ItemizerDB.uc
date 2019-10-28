//=============================================================================
// ItemizerDB.
//
// This class is used to store the crapload of info needed for manual placement
// of items in maps.
// The Itemizer system Spawing Interface functions are also located here.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ItemizerDB extends Info config(Itemizer) exportstructs;

struct ItemEntry	// ItemEntry holds the info for a single item add operation
{
	var() config string			MapName;	// The map this is in
	var() config class<actor>	ItemClass;	// Class of item concerned
	var() config vector			Spot;		// Location of the item
	var() config rotator		Angle;		// Rotation of the item
	var() config string			Group;		// Group tag for this item entry
};

var() config array<ItemEntry> 		Items;		// The big fat list of ItemEntrys

// Control functions ----------------------------------------------------------
// These are for Adding/Removing/Replacing items in the DB

// Returns an array of all the items for a map
function Array<ItemEntry> GetItems(string Mapname, string ItemGroup)
{
	local int i;
	local Array<ItemEntry> IEs;

	for (i=0;i<Items.length;i++)
		if (Items[i].MapName ~= MapName && (ItemGroup ~= "" || ItemGroup ~= Items[i].Group || Items[i].Group ~= ""))
			IEs[IEs.length] = Items[i];
	return IEs;
}
// Removes all items for a map
function RemoveAllFor(string Mapname)
{
	local int i;

	for (i=0;i<Items.length;i++)
		if (Items[i].MapName ~= MapName)
			Items.remove(i,1);
	SaveConfig();
}
// Adds an item for a map
function AddItem(ItemEntry IE)
{
	Items[Items.length] = IE;
	SaveConfig();
}
// Removes an item for a map
function bool RemoveItem(actor Item, string MapName)
{
	local int i;

	for (i=0;i<Items.length;i++)
		if (Items[i].MapName ~= MapName && Items[i].ItemClass == Item.class && Items[i].Spot == Item.Location)
		{
			Items.Remove(i, 1);
			SaveConfig();
			return true;
		}
	return false;
}
// Updates an ItemEntry. Uses map, class and location to recognize the old entry
function bool UpdateItem(string MapName, string ItemGroup, class<Actor> ItemClass, vector ItemLocation, ItemEntry IE)
{
	local int i;

	for (i=0;i<Items.length;i++)
		if (Items[i].MapName ~= MapName && Items[i].Group ~= ItemGroup && Items[i].ItemClass == ItemClass && Items[i].Spot == ItemLocation)
		{
			Items[i] = IE;
			SaveConfig();
			return true;
		}
	return false;
}
// Removes all items for a map and adds an array of new ones instead
function ReplaceItems(Array<ItemEntry> IEs, string MapName)
{
	local int i;

	for (i=0;i<Items.length;i++)
		if (Items[i].MapName ~= MapName)
			Items.Remove(i, 1);

	for (i=0;i<IEs.length;i++)
		Items[Items.length] = IEs[i];
	SaveConfig();
}
// End control stuff ----------------------------------------------------------

// Interface functions --------------------------------------------------------
// The Itemizer system will query each database through this function. This should
// return a number, depending on the input info to tell the Itemizer if it should
// use this database or not.
// If you want to use a different layout for your mod or something, you will need
// to make a new subclass and override this function return the right weight under
// the right conditions...
static function int DBWeight (string MapName, string ItemGroup, Actor Control)
{
	local int i;

//	Do ItemEntrys already exist in this class for the map concerned
	for (i=0;i<default.Items.length;i++)
		if (default.Items[i].MapName ~= MapName)
			return 2;
	return 0;
}
// This finds all the DBs using the ints and figures out which one to use
static function ItemizerDB GetItemDB (string MapName, string ItemGroup, Actor A)
{
	local array<string> DBClassNames;
	local array<class<ItemizerDB> > DBClasses;
	local class<ItemizerDB> DBClass;
	local ItemizerDB IDB;
	local int i, Best, j;

	if (A==None)
		return None;
    A.GetAllInt("BallisticProV55.ItemizerDB", DBClassNames);
    for (i=0;i<DBClassNames.length;i++)
    {
    	DBClass = class<ItemizerDB>(DynamicLoadObject(DBClassNames[i],class'Class'));
    	if (DBClass != None)
    		DBClasses[DBClasses.length] = DBClass;
    	else
	    	log("Itemizer: couldn't load bad database: "$DBClassNames[i]$" found in int file");
	}
	DBClass = None;
	log("Itemizer: "$DBClasses.length$" good databases found.");
	for (i=0;i<DBClasses.length;i++)
	{
		j = DBClasses[i].static.DBWeight(MapName, ItemGroup, A);
		if (j > Best)
		{
			Best = j;
			DBClass = DBClasses[i];
		}
	}
	if (DBClass == None)
	{
	   	log("Itemizer could not find Database for map "$MapName$" with group "$ItemGroup$" playing "$A.level.Game$"! Using default...");
		DBClass = class'ItemDB_Default';
	}
	IDB = A.Spawn(DBClass);
	return IDB;
}
// Run this from a mutator to spawn all the items for the map
static function ItemizerDB SpawnItems (string MapName, string ItemGroup, Actor Mut, optional bool bCleanUp)
{
	local Actor A;
	local int i, j;
	local array<ItemEntry> IEs;
	local ItemizerDB IDB;

	IDB = GetItemDB(MapName, ItemGroup, Mut);
	IEs = IDB.GetItems(MapName, ItemGroup);
	log("Itemizer Initialized: DataBase: "$IDB.class$", Items in DB: "$IDB.Items.length$", MapName: "$MapName$", Group: "$ItemGroup$", Map/Group Items: "$IEs.length);

	if (IEs.length > 0)
	{
		for(i=0;i<IEs.length;i++)
		{
			A = Mut.Spawn(IEs[i].ItemClass,,,IEs[i].Spot, IEs[i].Angle);
			if (A != None)
				j++;
//			if (A == None)
//				log("Itemizer: Could not spawn item: "$IEs[i].ItemClass, 'Warning');
		}
		log("Itemizer: Finished Spawning Items: "$j$" survived, "$IEs.length-j$" failed, destroyed or replaced");
	}
	else
		log("Itemizer: Finished: No items to spawn");
	if (bCleanUp)
	{
		IDB.Destroy();
		return None;
	}
	return IDB;
}
// Returns the name of the current map.
static function string GetMap(Actor A)
{
	local string s;
	local int i;

	// This seems to be the only reliable
	// way of getting the name of the map
	s = A.level.GetLocalURL();
	i = InStr(s, "/");
	if (i >= 0)
		s = Right(s, Len(s)-i-1);
	i = InStr(s, "?");
	if (i >= 0)
		s = Left(s, i);
	i = InStr(s, ".ut2");
	if (i >= 0)
		s = Left(s, i);
	return s;
}

// End Interface Stuff --------------------------------------------------------

defaultproperties
{
}
