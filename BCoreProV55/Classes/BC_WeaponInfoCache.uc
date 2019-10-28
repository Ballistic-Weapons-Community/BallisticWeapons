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
class BC_WeaponInfoCache extends Object config(BWCache) exportstructs;

struct WeaponInfo
{
	var() config string		ClassName;
	var() config string		ItemName;
	var() config Material	SmallIconMaterial;
	var() config IntBox		SmallIconCoords;
	var() config int			InventoryGroup;
	var() config Material	BigIconMaterial;
	var()	config byte		InventorySize;
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
		WI.BigIconMaterial	= BW.default.BigIconMaterial;
		WI.InventorySize		= BW.default.InventorySize;
		WI.bIsBW				= true;
	}

	i = default.Weapons.length;
	default.Weapons[default.Weapons.length] = WI;

	default.bChanged = true;
	return WI;
}

static function bool IsValid(coerce string S)
{
	if (InStr(s, "Recolors4") != -1 || InStr(s, "Prototypes") != -1 || InStr(s, "WeaponPack2") != -1)
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
     Weapons(0)=(ClassName="BallisticProV55.X3Knife",ItemName="X3 Knife",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_X3',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=1,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_X3',InventorySize=2,bIsBW=True)
     Weapons(1)=(ClassName="BallisticProV55.A909SkrithBlades",ItemName="A909 Skrith Blades",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_A909',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=1,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_A909',InventorySize=2,bIsBW=True)
     Weapons(2)=(ClassName="BallisticProV55.EKS43Katana",ItemName="EKS43 Katana",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_EKS43',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=1,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_EKS43',InventorySize=2,bIsBW=True)
     Weapons(3)=(ClassName="BallisticProV55.M806Pistol",ItemName="M806A2 Pistol",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M806',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M806',bIsBW=True)
     Weapons(4)=(ClassName="BallisticProV55.A42SkrithPistol",ItemName="A42 Skrith Sidearm",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_A42',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_A42',bIsBW=True)
     Weapons(5)=(ClassName="BallisticProV55.MRT6Shotgun",ItemName="MRT6 Shotgun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_MRT6',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=7,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_MRT6',bIsBW=True)
     Weapons(6)=(ClassName="BallisticProV55.XK2SubMachinegun",ItemName="XK2 SubMachinegun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_XK2',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=3,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_XK2',bIsBW=True)
     Weapons(7)=(ClassName="BallisticProV55.D49Revolver",ItemName="D49 Revolver",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_D49',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_D49',bIsBW=True)
     Weapons(8)=(ClassName="BallisticProV55.RS8Pistol",ItemName="RS8 10mm Pistol",SmallIconMaterial=Texture'BWAddPack-RS-Skins.RS8.SmallIcon_RS8',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_RS8',bIsBW=True)
     Weapons(9)=(ClassName="BallisticProV55.XRS10SubMachinegun",ItemName="XRS-10 Machine-Pistol",SmallIconMaterial=Texture'BWAddPack-RS-Skins.XRS10.SmallIcon_XRS10',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=3,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_XRS10',bIsBW=True)
     Weapons(10)=(ClassName="BallisticProV55.Fifty9MachinePistol",ItemName="Fifty-9 Machine-Pistol",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_Fifty9',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=3,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_Fifty9',bIsBW=True)
     Weapons(11)=(ClassName="BallisticProV55.AM67Pistol",ItemName="AM67 Assault Pistol",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_AM67',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_AM67',bIsBW=True)
     Weapons(12)=(ClassName="BallisticProV55.M50AssaultRifle",ItemName="M50 Assault Rifle",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M50',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M50',bIsBW=True)
     Weapons(13)=(ClassName="BallisticProV55.M763Shotgun",ItemName="M763 Shotgun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M763',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=7,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M763',bIsBW=True)
     Weapons(14)=(ClassName="BallisticProV55.A73SkrithRifle",ItemName="A73 Skrith Rifle",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_A73',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=5,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_A73',bIsBW=True)
     Weapons(15)=(ClassName="BallisticProV55.M353Machinegun",ItemName="M353 Machinegun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M353',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=6,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M353',bIsBW=True)
     Weapons(16)=(ClassName="BallisticProV55.M925Machinegun",ItemName="M925 Machinegun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M925',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=6,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M925',bIsBW=True)
     Weapons(17)=(ClassName="BallisticProV55.G5Bazooka",ItemName="G5 RPG Launcher",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_G5',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=8,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_G5',bIsBW=True)
     Weapons(18)=(ClassName="BallisticProV55.R78Rifle",ItemName="R78A1 Sniper Rifle",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_R78',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_R78',bIsBW=True)
     Weapons(19)=(ClassName="BallisticProV55.M75Railgun",ItemName="M75-TIC Railgun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M75',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M75',bIsBW=True)
     Weapons(20)=(ClassName="BallisticProV55.M290Shotgun",ItemName="M290 Shotgun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M290',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=7,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M290',InventorySize=18,bIsBW=True)
     Weapons(21)=(ClassName="BallisticProV55.MRS138Shotgun",ItemName="MRS138 Tactical Shotgun",SmallIconMaterial=Texture'BWAddPack-RS-Skins.MRS138.SmallIcon_MRS138',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=7,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_MRS138',bIsBW=True)
     Weapons(22)=(ClassName="BallisticProV55.SRS900Rifle",ItemName="SRS-900 Battle Rifle",SmallIconMaterial=Texture'BWBP3-Tex.SRS900.SmallIcon_SRS900',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_SRS900',bIsBW=True)
     Weapons(23)=(ClassName="BallisticProV55.HVCMk9LightningGun",ItemName="HVC-Mk9 Lightning Gun",SmallIconMaterial=Texture'BWBP2-Tex.Lighter.SmallIcon_LG',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=5,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_HVCMk9',InventorySize=18,bIsBW=True)
     Weapons(24)=(ClassName="BallisticProV55.RX22AFlamer",ItemName="RX22A Flame Thrower",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_RX22A',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=8,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_RX22A',InventorySize=10,bIsBW=True)
     Weapons(25)=(ClassName="BallisticProV55.XMV850Minigun",ItemName="XMV-850 Minigun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_XMV850',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=6,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_XMV850',InventorySize=8,bIsBW=True)
     Weapons(26)=(ClassName="BallisticProV55.NRP57Grenade",ItemName="NRP57 Pineapple",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_NRP57',SmallIconCoords=(X2=127,Y2=31),BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_NRP57',bIsBW=True)
     Weapons(27)=(ClassName="BallisticProV55.FP7Grenade",ItemName="FP7 Grenade",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_FP7',SmallIconCoords=(X2=127,Y2=31),BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_FP7',bIsBW=True)
     Weapons(28)=(ClassName="BallisticProV55.FP9Explosive",ItemName="FP9A5 Explosive Device",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_FP9Explosive',SmallIconCoords=(X2=127,Y2=31),BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_FP9A5',bIsBW=True)
     Weapons(29)=(ClassName="BallisticProV55.BX5Mine",ItemName="BX5-SM Land Mine",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_BX5',SmallIconCoords=(X2=127,Y2=31),BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_BX5',bIsBW=True)
     Weapons(30)=(ClassName="BallisticProV55.T10Grenade",ItemName="T10 Toxic Grenade",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_T10',SmallIconCoords=(X2=127,Y2=31),BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_T10',bIsBW=True)
}
