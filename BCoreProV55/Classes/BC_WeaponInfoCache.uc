//=============================================================================
// BC_WeaponInfoCache.
//
// To solve to problem of taking rediculous amounts of time to load all the
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
class BC_WeaponInfoCache extends Object 
	config(BWCache) 
	exportstructs;

struct WeaponInfo
{
	var() config string			ClassName;
	var() config string			ItemName;
	var() config Material		SmallIconMaterial;
	var() config IntBox			SmallIconCoords;
	var() config int			InventoryGroup;
	var() config Material		BigIconMaterial;
	var() config byte			InventorySize;
	var() config bool			bIsBW;
};

var() config array<WeaponInfo>	Weapons;
var   bool						bChanged;

// Find a specific weapon in the list, output the WI and return success or failure to find the weapon
static function bool FindWeaponInfo(string CN, out WeaponInfo WI, optional out int Index)
{
	local int i;

	for (i=0;i<default.Weapons.length;i++)
		if (default.Weapons[i].ClassName ~= CN)
		{
			Index = i;
			WI = default.Weapons[i];
			return true;
		}
	Index = -1;
	return false;
}

// Fast shotcut to use FindWeaponInfo() and automatically AddWeaponInfoName() if needed
static function WeaponInfo AutoWeaponInfo(string WeapClassName, optional out int i)
{
	local WeaponInfo WI;

	// Tap into the BW weapon cache system to identify BallisticWeapons without loading them
	if (FindWeaponInfo(WeapClassName, WI, i))
		return WI;
	return AddWeaponInfoName(WeapClassName, i);
}

// Shorcut to AddWeaponInfo() using only classname
static function WeaponInfo AddWeaponInfoName(string WeapClassName, optional out int i)
{
	local class<Weapon> Weap;
	local WeaponInfo WI;

	Weap = class<Weapon>(DynamicLoadObject(WeapClassName, class'Class'));
	if (Weap != None)
		WI = AddWeaponInfo(Weap, i);
	else
	{
		i = -1;
		return WI;
	}
	return WI;
}

// List the right properties of the input class. Returns the new WI and index of WI in the list
static function WeaponInfo AddWeaponInfo(class<Weapon> Weap, optional out int i)
{
	local WeaponInfo WI;
	local Class<BallisticWeapon> BW;

	i=-1;
	if (Weap == None)
		return WI;

	WI.ClassName 		 = string(Weap);
	WI.ItemName			 = Weap.default.ItemName;
	WI.SmallIconMaterial = Weap.default.IconMaterial;
	WI.SmallIconCoords	 = Weap.default.IconCoords;
	WI.InventoryGroup	 = Weap.default.InventoryGroup;

	BW = Class<BallisticWeapon>(Weap);

	if (BW != None)
	{
		WI.BigIconMaterial		= BW.default.BigIconMaterial;
		WI.InventorySize		= BW.static.GetInventorySize();
		WI.bIsBW				= true;
	}

	i = default.Weapons.length;
	default.Weapons[default.Weapons.length] = WI;

	default.bChanged = true;
	return WI;
}

static function bool IsValid(coerce string S)
{
	if (InStr(s, "Recolors") != -1 || InStr(s, "Prototypes") != -1 || InStr(s, "WeaponPack") != -1 || InStr(s, "V2") != -1 || InStr(s, "KabPack") != -1 || InStr(s, "Extreme") != -1 || InStr(s, "Fix") != -1 ||  InStr(s, "OtherPack") != -1)
		return false;
	return true;
}

static function GetBWWeps(out array<WeaponInfo> BWeps)
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
