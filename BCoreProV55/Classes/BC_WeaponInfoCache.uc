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
class BC_WeaponInfoCache extends Object 
	abstract
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

var array< class<BC_WeaponInfoCache_GameStyle> >	CacheClasses;

static final function class<BC_WeaponInfoCache_GameStyle> CurrentCache()
{
	return default.CacheClasses[class'BallisticReplicationInfo'.default.GameStyle];
}

// Find a specific weapon in the list, output the WI and return success or failure to find the weapon
static function bool FindWeaponInfo(string CN, out WeaponInfo WI, optional out int Index)
{
	return CurrentCache().static.FindWeaponInfo(CN, WI, Index);
}

// Fast shotcut to use FindWeaponInfo() and automatically AddWeaponInfoName() if needed
static function WeaponInfo AutoWeaponInfo(string WeapClassName, optional out int i)
{
	return CurrentCache().static.AutoWeaponInfo(WeapClassName, i);
}

// Shorcut to AddWeaponInfo() using only classname
static function WeaponInfo AddWeaponInfoName(string WeapClassName, optional out int i)
{
	return CurrentCache().static.AddWeaponInfoName(WeapClassName, i);
}

// List the right properties of the input class. Returns the new WI and index of WI in the list
static function WeaponInfo AddWeaponInfo(class<Weapon> Weap, optional out int i)
{
	return CurrentCache().static.AddWeaponInfo(Weap, i);
}

static function bool IsValid(coerce string S)
{
	if (InStr(s, "Recolors") != -1 || InStr(s, "Prototypes") != -1 || InStr(s, "WeaponPack") != -1 || InStr(s, "V2") != -1 || InStr(s, "KabPack") != -1 || InStr(s, "Extreme") != -1 || InStr(s, "Fix") != -1 ||  InStr(s, "OtherPack") != -1)
		return false;
	return true;
}

static function GetBWWeps(out array<WeaponInfo> BWeps)
{
	CurrentCache().static.GetBWWeps(BWeps);
}

// If the list was changed, save it.
static function EndSession()
{
	CurrentCache().static.EndSession();
}

defaultproperties
{
	CacheClasses(0)=class'WeaponInfoCache_Pro'
	CacheClasses(1)=class'WeaponInfoCache_Classic'
	CacheClasses(2)=class'WeaponInfoCache_Realism'
	CacheClasses(3)=class'WeaponInfoCache_Tactical'
}
