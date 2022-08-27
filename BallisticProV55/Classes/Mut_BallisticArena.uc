//=============================================================================
// Mut_BallisticArena.
//
// Like normal arena, but this implements the Ballistic Mod with all standard
// Mutator features and allows multi-weapon arena games. Multi weapons can be
// given to players in several ways:
// Default: 	All chosen weapons are given to all players
// One Random:	The same 1 random weapon out of the chosen is given to all players for the whole match
// Per Spawn:	A different random weapon of the chosen is given to players each time they spawn
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Mut_BallisticArena extends Mut_Ballistic
	transient
	HideDropDown
	CacheExempt
	config(BallisticProV55);
	
var() config array<string>	WeaponClassNames;	// List of weapons given to players
var() config bool			bRandomPickOne;		// Randomly picks one weapon per match from the list for all players instead of giving players all of them
var() config bool			bRandomPerSpawn;	// Randomly selects a new weapon from the list each time the player spawns
var   array<class<weapon> >	WeaponClasses;

function PreBeginPlay ()
{
	local int i;
	local class<weapon> W;

	super.PreBeginPlay();

	if (bRandomPickOne)
		DefaultWeaponName = WeaponClassNames[Rand(WeaponClassNames.length)];

	for (i=0;i<WeaponClassNames.length;i++)
	{
		W = class<weapon>(DynamicLoadObject(WeaponClassNames[i],class'Class'));
		if (W != None)
			WeaponClasses[WeaponClasses.length] = W;
	}
}
function ModifyPlayer(Pawn Other)
{
	local int i;
	local byte LP;
	local class<weapon> W;

	Super.ModifyPlayer(Other);

	if (bRandomPerSpawn)
	{
		W = WeaponClasses[Rand(WeaponClasses.length)];
		SpawnWeapon(W, Other);
		SpawnAmmo(W.default.FireModeClass[0].default.AmmoClass, Other);
		if (W.default.FireModeClass[1].default.AmmoClass != None && W.default.FireModeClass[0].default.AmmoClass != W.default.FireModeClass[1].default.AmmoClass)
			SpawnAmmo(W.default.FireModeClass[1].default.AmmoClass, Other);
		Other.Controller.ClientSwitchToBestWeapon();
		xPawn(Other).RequiredEquipment[0] = string(W);
		return;
	}
	if (bRandomPickOne)
		return;

	for (i=0;i<WeaponClasses.length;i++)
	{
		SpawnWeapon(WeaponClasses[i], Other);
		if (WeaponClasses[i].default.Priority > LP)
		{
			LP = WeaponClasses[i].default.Priority;
			xPawn(Other).RequiredEquipment[0] = string(WeaponClasses[i]);
		}
		if (xPawn(Other) != None && class<BallisticHandGrenade>(WeaponClasses[i]) == None)
		{
			SpawnAmmo(WeaponClasses[i].default.FireModeClass[0].default.AmmoClass, Other);
			if (WeaponClasses[i].default.FireModeClass[0].default.AmmoClass != WeaponClasses[i].default.FireModeClass[1].default.AmmoClass)
				SpawnAmmo(WeaponClasses[i].default.FireModeClass[1].default.AmmoClass, Other);
		}
	}
	Other.Controller.ClientSwitchToBestWeapon();
}
function class<Weapon> MyDefaultWeapon()
{
	if (!bRandomPickOne || bRandomPerSpawn)
		return None;
	return super.MyDefaultWeapon();
}
function string GetInventoryClassOverride(string InventoryClassName)
{
	return Super(Mutator).GetInventoryClassOverride(InventoryClassName);
}

function ItemPickedUp(Pickup Other);
function ItemChange(Pickup Other);

function bool CheckReplacement( Actor Other, out byte bSuperRelevant )
{
	local int i;

	bSuperRelevant = 0;
	if (Weapon(Other) != None && (!Weapon(Other).bNoInstagibReplace) && Translauncher(Other)==None)
	{
		for (i=0;i<WeaponClasses.length;i++)
			if (WeaponClasses[i] == Other.class)
				return true;
		return false;
	}
	else if (xPawn(Other) != None)
	{
		xPawn(Other).RequiredEquipment[0] = "";
		xPawn(Other).RequiredEquipment[1] = "";
		return true;
	}
	else if (WeaponPickup(Other) != None && Other.Owner == None)
	{
		return false;
	}
/*	else if (WeaponPickup(Other) != None && Other.Owner == None && (WeaponClasses.length > 1 ||
			(WeaponClasses[1].default.FireModeClass[0].default.AmmoClass.default.PickupClass != Other.class &&
			 WeaponClasses[1].default.FireModeClass[1].default.AmmoClass.default.PickupClass != Other.class)))
		return false;
*/	else if (xWeaponBase(Other) != None)
	{
		Other.bHidden = true;
//		if (WeaponClasses.length != 1)
			SpawnNewItem(-1, Other, class'IP_AmmoPack');
		return false;
	}
	else if (xPickupBase(Other) != None)
		Other.bHidden = true;
	else if (Ammo(Other) != None)
	{
		if (IP_AmmoPack(Other)!=None)
			return true;
/*		if (WeaponClasses.length == 1)
		{
			if (WeaponClasses[i].default.FireModeClass[0].default.AmmoClass.default.PickupClass == Other.class
			SpawnNewItem(-1, Other, WeaponClasses[0].default.FireModeClass[0].default.AmmoClass.default.PickupClass);
		}
		else if (bRandomPickOne && !bRandomPerSpawn)
		{
			for (i=0;i<WeaponClasses.length;i++)
				if (WeaponClasses[i] == DefaultWeapon)
				{
					SpawnNewItem(-1, Other, WeaponClasses[0].default.FireModeClass[0].default.AmmoClass.default.PickupClass);
					break;
				}

				if ( IP_AmmoPack(Other)!=None || WeaponClasses[i].default.FireModeClass[0].default.AmmoClass.default.PickupClass == Other.class ||
					(WeaponClasses[i].default.FireModeClass[1].default.AmmoClass != None && WeaponClasses[i].default.FireModeClass[1].default.AmmoClass.default.PickupClass == Other.class) )
					return true;
		}
		if (WeaponClasses.length == 1)
			SpawnNewItem(-1, Other, WeaponClasses[0].default.FireModeClass[0].default.AmmoClass.default.PickupClass);
*/		return false;
	}
	else if ( Other.IsA('WeaponLocker') )
	{
		if (!SpawnNewItem(-1, Other, class'IP_AmmoPack'))
		{
			Other.GotoState('Disabled');
			return false;
		}
	}
	return Super.CheckReplacement( Other, bSuperRelevant );
}

defaultproperties
{
     WeaponClassNames(0)="BallisticProV55.D49Revolver"
     bRandomPickOne=True
     bRandomPerSpawn=True
     bHideLockers=True
     ConfigMenuClassName="BallisticProV55.BallisticConfigMenuPro"
     FriendlyName="BallisticPro: Arena"
     Description="Like arena, but with all Ballistic items and modifications and the option of multiple/random weapons.||http://www.runestorm.com"
}
