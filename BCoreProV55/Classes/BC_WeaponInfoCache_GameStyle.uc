//=============================================================================
// BC_WeaponInfoCache.
//
// To solve to problem of taking ridiculous amounts of time to load all the
// weapon classes just to get a few menu related properties, we can use this
// which holds a list of weapons and their properties which might be needed by
// BW menus and such.
//
// Menus can use FindWeaponInfo() to get the WeaponInfo for the desired weapon.
// If FindWeaponInfo returns false because the weapon isn't listed, the menu
// system can use AddWeaponInfo() with the weapon class to list it for use with
// FindWeaponInfo() in the future.
// EndSession() can be called after the menu has done all its AddWeaponInfo(),
// This is a very easy way make sure all new additions are saved if there were
// any changes.
//
// AutoWeaponInfo() is a very simple shortcut to get WeaponInfo and add the new
// classname to the list if needed.
//
// AddWeaponInfoName() is a shotcut to AddWeaponInfo() that requires only a
// classname and will load the class itself
//
//
// Most menus systems will be able to take advantage of the Weapon Info Cache
// with a call to AutoWeaponInfo() for each weapon classname and a single call
// to EndSession() once its finished the loop.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class BC_WeaponInfoCache_GameStyle extends Object 
	abstract
	exportstructs
	DependsOn(BC_WeaponInfoCache)
	config(BWCache);

var() config array<BC_WeaponInfoCache.WeaponInfo>	Weapons;
var() config array<string>							NotBallistic;	// Classes that were loaded once and are no BallisticWeapons, so that asking again loads nothing
var   bool											bChanged;

// Invalidation
var	config int		SavedRevision;
var int				Revision;

// Invalidates cache if the revisions don't match.
static final function CheckRevision()
{
	if (default.SavedRevision == default.Revision)
		return;

	default.Weapons.Length = 0;
	default.NotBallistic.Length = 0;

	default.SavedRevision = default.Revision;

	StaticSaveConfig();
}

// Find a specific weapon in the list, output the WI and return success or failure to find the weapon
static function bool FindWeaponInfo(string CN, out BC_WeaponInfoCache.WeaponInfo WI, optional out int Index)
{
	local int i;
	
	CheckRevision();

	for (i = 0; i < default.Weapons.length; i++)
	{
		if (default.Weapons[i].ClassName ~= CN)
		{
			Index = i;
			WI = default.Weapons[i];
			return true;
		}
	}

	Index = -1;
	return false;
}

// Fast shotcut to use FindWeaponInfo() and automatically AddWeaponInfoName() if needed
static function BC_WeaponInfoCache.WeaponInfo AutoWeaponInfo(string WeapClassName, optional out int i)
{
	local BC_WeaponInfoCache.WeaponInfo WI;

	CheckRevision();

	// Tap into the BW weapon cache system to identify BallisticWeapons without loading them
	if (WeapClassName == "")
	{
		i = -1;
		return WI;
	}

	if (FindWeaponInfo(WeapClassName, WI, i))
		return WI;

	// Not one of ours, as loading it once has shown: the same answer without loading it again
	if (IsNotBallistic(WeapClassName))
	{
		i = -1;
		return WI;
	}

	return AddWeaponInfoName(WeapClassName, i);
}

static function bool IsNotBallistic(string WeapClassName)
{
	local int i;

	for (i = 0; i < default.NotBallistic.length; i++)
		if (default.NotBallistic[i] ~= WeapClassName)
			return true;
	return false;
}

// Shorcut to AddWeaponInfo() using only classname
static function BC_WeaponInfoCache.WeaponInfo AddWeaponInfoName(string WeapClassName, optional out int i)
{
	local class<BallisticWeapon> Weap;
	local BC_WeaponInfoCache.WeaponInfo WI;
	local Object Loaded;
	if (WeapClassName == "")
	{
		i = -1;
		return WI;
	}

	Loaded = DynamicLoadObject(WeapClassName, class'Class');
	Weap = class<BallisticWeapon>(Loaded);

	if (Weap != None)
		WI = AddWeaponInfo(Weap, i);
	else
	{
		i = -1;
		// A class that loads and is no BallisticWeapon stays that. One that does not load may be installed later.
		if (Loaded != None && !IsNotBallistic(WeapClassName))
		{
			default.NotBallistic[default.NotBallistic.length] = WeapClassName;
			default.bChanged = true;
		}
	}

	return WI;
}

// List the right properties of the input class. Returns the new WI and index of WI in the list
static function BC_WeaponInfoCache.WeaponInfo AddWeaponInfo(class<BallisticWeapon> BW, optional out int i)
{
	local BC_WeaponInfoCache.WeaponInfo WI;

	i=-1;

	if (BW == None)
		return WI;

	WI.ClassName 		 	= string(BW);
	WI.ItemName			 	= BW.default.ItemName;
	WI.SmallIconMaterial 	= BW.default.IconMaterial;
	WI.SmallIconCoords	 	= BW.default.IconCoords;
	WI.InventoryGroup	 	= BW.default.InventoryGroup;
	WI.BigIconMaterial		= BW.default.BigIconMaterial;
	WI.InventorySize		= BW.static.GetInventorySize();
	WI.bIsBW				= true;

	i = default.Weapons.length;
	default.Weapons[default.Weapons.length] = WI;

	default.bChanged = true;
	return WI;
}

static function GetBWWeps(out array<BC_WeaponInfoCache.WeaponInfo> BWeps)
{
	local int i;
	
	for (i=0;i<default.Weapons.Length;i++)
	{
		if (default.Weapons[i].bIsBW)
			BWeps[BWeps.Length] = default.Weapons[i];
	}
}

// If the list was changed, save it.
static function EndSession()
{
	if (default.bChanged)
		StaticSaveConfig();

	default.bChanged = false;
}

defaultproperties
{
    // never specify any defaults here. this is a bcore class and it prevents correct regeneration of the cache when deleting BWCache.ini.
}
