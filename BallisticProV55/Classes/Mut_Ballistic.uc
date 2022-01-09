//=============================================================================
// Mut_Ballistic.
//
// Replaces normal weapons with Ballistic ones
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Mut_Ballistic extends Mutator 
	transient
	HideDropDown
	CacheExempt
	config(BallisticProV55);

#exec OBJ LOAD File=BW_Core_WeaponSound.uax

var globalconfig bool bLogCheckReplacement;

struct ItemSwitch
{
	var() string			OldItemName;	// Names of Old item to replace (can be Inventory, Weapon, WeaponPickup, Pickup, etc)
	var   class<Actor>		OldItem;		// Old item class. This is set using OldItemName
	var() bool				bUseBase;		// Leave base and merely change the item
	var() bool				bSuper;			// Old item is a super weapon
	var() array<string>		NewItemNames;	// Names of New items to replace it with (can be Inventory, Weapon, WeaponPickup, Pickup, etc)
	var   Array<class<Actor> > NewItems;	// New Item classes. These are set using NewItemNames
};

var() array<ItemSwitch> Replacements;			// List of items and what to replace them with
var() Sound				UDamageSnd;				// Different sound UDamage firing
struct DoomedItem
{
	var() Actor OldItem;
	var() class<Actor> NewClass;
	var() Pawn Instigator;
};
var   array<DoomedItem>	DoomedItems;				// Items that will be replaced after some time has passed

struct PickupSwap
{
	var() Pickup Old;
	var() int	 NewIndex;
};
var   array<PickupSwap> PickupSwaps;				// Pickups waiting to be swapped

var   globalconfig bool		bUseItemizer;			// Should extra items be spawned using the Itemizer system
var   globalconfig string	ItemGroup;				// Group to use for Itemizer. Only items of this group will spawned by Itemizer.
var   globalconfig bool		bLeaveSuper;			// Don't replace super weapons
var   globalconfig bool		bBrightPickups;			// Pickups have ambient glow
var   globalconfig bool		bSpawnUniqueItems;		// Game will try to spawn items that are the least common at the time
var   globalconfig bool		bPickupsChange;			// Pickups can change into another random type after they are picked up
var   globalconfig bool		bRandomDefaultWeapons;	// Random initial weapons instead of standard "NewItems[0]"
var   globalconfig string	CamUpdateRate;			// Rate level at which the M50 camera's scripted texture should update
var   globalconfig bool		bKillRogueWeaponPickups;// Get rid of non-standard weapon pickups that are not listed and not replaced
var   globalconfig bool		bForceBallisticPawn;	// Force use of BallisticPawn, even when old pawn was not xPawn (Will cause bugs in some gametypes)
var   localized string		LeaveSuperDisplayText,LeaveSuperDescText,
							BrightPickDisplayText,BrightPickDescText,
							DarkSkinsDisplayText,DarkSkinsDescText,
							PChangeDisplayText,PChangeDescText,
							UniqueDisplayText,UniqueDescText,
							RandDefDisplayText,RandDefDescText,
							ItemizerDescText,ItemizerDisplayText,
							GroupDisplayText,GroupDescText;
var() bool					DMMode;				// Disables stuff to work with Ballistic Game types
var() bool					bHideLockers;		// Does this mutator hide lockers?
var   bool					bLWsInitialized;	// Locker weapons have been changed
var() localized Array<string> CamRateOptions;	// List of camera update rate options

var   bool 					bSpawnedIA;		//Interaction has been spawnd for local player.
var   bool					bDoItemize;		//Spawn itemizer items next tick

//PlayerChangedClass
var   globalconfig float    FootstepAmplifier;

// Sprint
var   Array<BCSprintControl> 	Sprinters;
var   globalconfig bool     	bUseSprint;
var   globalconfig float    	InitStamina;
var   globalconfig float    	InitMaxStamina;
var   globalconfig float    	InitStaminaDrainRate;
var   globalconfig float    	InitStaminaChargeRate;
var   globalconfig float    	InitSpeedFactor;
var   globalconfig float    	JumpDrainFactor;

var   BCReplicationInfo	BallisticReplicationInfo;

var	int						CRCount;

replication
{
	reliable if (Role == ROLE_Authority)
		ClientModifyPlayer;
}

//return Ballistic PRI (Izumo)
static function BallisticPlayerReplicationInfo GetBPRI(PlayerReplicationInfo PRI)
{
	local LinkedReplicationInfo lPRI;
	
	if(PRI.CustomReplicationInfo==None)
	{
		log("No Custom PRI");
		return None;  //shouldn't happen
	}

	
	if(BallisticPlayerReplicationInfo(PRI.CustomReplicationInfo) !=None)
		return BallisticPlayerReplicationInfo(PRI.CustomReplicationInfo);
	
	for(lPRI = PRI.CustomReplicationInfo.NextReplicationInfo; lPRI != None; lPRI=lPRI.NextReplicationInfo)
	{
		if(BallisticPlayerReplicationInfo(lPRI)!=None)
			return BallisticPlayerReplicationInfo(lPRI);
		if (lPRI == lPRI.NextReplicationInfo)
		{
			log("A LinkedReplicationInfo links to itself, aborting");
			break;
		}
	}
	
	log("Couldn't find a BPRI");
	return None;
}

// Returns the inventory class for input pickup or inventory
static function class<inventory> GetInventoryFor(class<Actor> A)
{
	if (A == None)
		return None;
	else if (class<Inventory>(A) != None)
		return class<Inventory>(A);
	else if (class<Pickup>(A) != None && class<Pickup>(A).default.InventoryType != None)
		return class<Pickup>(A).default.InventoryType;
	return None;
}

// Returns the pickup class for the input pickup or inventory
static function class<pickup> GetPickupFor(class<Actor> A)
{
	if (A == None)
		return None;
	else if (class<pickup>(A) != None)
		return class<pickup>(A);
	else if (class<inventory>(A) != None && class<inventory>(A).default.PickupClass != None)
		return class<inventory>(A).default.PickupClass;
	return None;
}
// This picks one of the new items from one of the possible replacements
function class<Actor> GetNewItem(int Index, optional bool bNoUnique, optional class<actor> OldItem)
{
	local Array<int> Ranks;
	local Pickup P;
	local Inventory Inv;
	local int i;
	local Array<class<actor> > LowestItems;

	if (Replacements.length <= Index || Replacements[Index].NewItems.length < 1)
		return None;

	// Set the new item to be whatever is least common at the moment...
	if (!bNoUnique && bSpawnUniqueItems && Replacements[Index].NewItems.length > 1)
	{
		// Find out how many of of each potential new item are in the game
		foreach DynamicActors(class'Pickup', P)
			for (i=0;i<Replacements[Index].NewItems.length;i++)
				if (GetPickupFor(Replacements[Index].NewItems[i]) == P.class)
					Ranks[i] = Ranks[i] + 1;
		foreach DynamicActors(class'Inventory', Inv)
			for (i=0;i<Replacements[Index].NewItems.length;i++)
				if (GetInventoryFor(Replacements[Index].NewItems[i]) == Inv.class)
					Ranks[i] = Ranks[i] + 1;
		if (OldItem != None)
			for (i=0;i<Replacements[Index].NewItems.length;i++)
				if (GetPickupFor(Replacements[Index].NewItems[i]) == GetPickupFor(OldItem))
					Ranks[i] = Ranks[i] + 1;

		// Found no pickups or weapons. Pick any random one...
		if (Ranks.length < 1)
			return Replacements[Index].NewItems[Rand(Replacements[Index].NewItems.length)];
		// Some were not found, there are 0 occurences of at least 1 new item
		if (Ranks.length < Replacements[Index].NewItems.length)
			Ranks.length = Replacements[Index].NewItems.length;
		else
		{
			// Find the smallest number. It will be the last in the ranks
			Ranks.length = Replacements[Index].NewItems.length;
			i=0;
			while (i < Ranks.length)
			{
				if (Ranks[Ranks.Length-1] > Ranks[i])
					Ranks.Remove(Ranks.Length-1, 1);
				else
					i++;
			}
		}
		// Make new list of all items that occur the same number of times as the lowest
		for(i=0;i<Ranks.length;i++)
			if (Ranks[i] == Ranks[Ranks.length-1])
				LowestItems[LowestItems.length] = Replacements[Index].NewItems[i];
		return LowestItems[Rand(LowestItems.length)];
	}
	return Replacements[Index].NewItems[Rand(Replacements[Index].NewItems.length)];
}

// Modify players and bots a bit
function ModifyPlayer(Pawn Other)
{
	local class<Weapon> FW;
	local int i;
	local BCSprintControl SC;

	if (!DMMode && BallisticPawn(Other) == None)
	{
		ClientModifyPlayer(Other);
		// Make players a bit crap
		Other.GroundSpeed=360;
		Other.default.GroundSpeed=360; //required as Ballistic keeps resetting it
		Other.WalkingPct=class'BallisticReplicationInfo'.default.WalkingPercentage;
		Other.CrouchedPct=class'BallisticReplicationInfo'.default.CrouchingPercentage;
		// Me can hide better
		Other.Visibility = 16;
		Other.default.Visibility = 16;

		Other.bCanWalkOffLedges=true;
	}
	else if(xPawn(Other) != None)
    {
        // Player
        Other.Health = class'BallisticReplicationInfo'.default.playerHealth;  // health the player starts with
        Other.HealthMax = class'BallisticReplicationInfo'.default.playerHealthCap; // maximum health a player can have
        Other.SuperHealthMax = class'BallisticReplicationInfo'.default.playerSuperHealthCap; // maximum superhealth a player can have
        xPawn(Other).ShieldStrengthMax = class'BallisticReplicationInfo'.default.iArmorCap;
        Other.AddShieldStrength(class'BallisticReplicationInfo'.default.iArmor);
        Other.MaxFallSpeed = class'BallisticReplicationInfo'.default.MaxFallSpeed;
        xPawn(Other).FootstepVolume *= FootstepAmplifier;

        Other.Controller.AdrenalineMax = class'BallisticReplicationInfo'.default.iAdrenalineCap;
        if(Other.Controller.Adrenaline < class'BallisticReplicationInfo'.default.iAdrenaline)
        {
            Other.Controller.Adrenaline = class'BallisticReplicationInfo'.default.iAdrenaline;
        }

        if(BallisticPawn(Other) != none)
        {
            BallisticPawn(Other).BPRI = class'Mut_Ballistic'.static.GetBPRI(Other.Controller.PlayerReplicationInfo);
        }

        if (bUseSprint && GetSprintControl(PlayerController(Other.Controller)) == None)
        {
            SC = Spawn(class'BCSprintControl',Other);
            SC.Stamina = InitStamina;
            SC.MaxStamina = InitMaxStamina;
            SC.StaminaDrainRate = InitStaminaDrainRate;
            SC.StaminaChargeRate = InitStaminaChargeRate;
            SC.SpeedFactor = InitSpeedFactor;
            SC.JumpDrainFactor = JumpDrainFactor;

            if(BallisticPawn(Other) == none)

            SC.GiveTo(Other);
            Sprinters[Sprinters.length] = SC;
        }
    }
	
	// A hack to prevent continued walking after respawning.
	if(Other.Controller != None)
		Other.Controller.bRun = 0;

	// No lights please
	xPlayerReplicationInfo(Other.PlayerReplicationInfo).bForceNoPlayerLights = true;

	if (Other.Controller != None && Bot(Other.Controller) != None)
	{	
		// Change favorite weapons for bots
		if (Bot(Other.Controller).FavoriteWeapon != None)
		{
			FW = Bot(Other.Controller).FavoriteWeapon;
			for (i=0;i<Replacements.Length;i++)
				if (GetInventoryFor(Replacements[i].OldItem) == FW)
					Bot(Other.Controller).FavoriteWeapon = class<Weapon>(GetInventoryFor(GetNewItem(i, true)));
		}
	}

	// Add ammo for default weapon
	AddStartingAmmo(Other);

	Super.ModifyPlayer(Other);
}

function AddStartingAmmo (Pawn Other)
{
	local int i;
	local Ammunition Ammo;
	local Inventory Inv;

	for (Inv=Other.Inventory;Inv!=None;Inv=Inv.Inventory)
	{
		for (i=0;i<Replacements[1].NewItems.length;i++)
			if (Weapon(Inv)!=None && Inv.class == GetInventoryFor(Replacements[1].NewItems[i]))
			{
				Ammo = Ammunition(Other.FindInventoryType(class<Weapon>(GetInventoryFor(Replacements[1].NewItems[i])).default.FireModeClass[0].default.AmmoClass));
				if(Ammo == None)
		    	{
					Ammo = Spawn(class<Weapon>(GetInventoryFor(Replacements[1].NewItems[i])).default.FireModeClass[0].default.AmmoClass);
					Other.AddInventory(Ammo);
			   	}
				Ammo.AddAmmo(Ammo.InitialAmount);
				Ammo.GotoState('');
			}
	}
}

simulated function ClientModifyPlayer(Pawn Other)
{
	local Pawn P;

	if (Other == None)
		return;
	// A hack to prevent continued walking after respawning.
	if(Other.Controller != None)
		Other.Controller.bRun = 0;
	foreach DynamicActors (class'Pawn', P)
	{
		if (xPawn(P) != none && BallisticPawn(P) == None)
		{
			xPawn(P).FootstepVolume = 0.5;
			xPawn(P).UDamageSound = UDamageSnd;
			xPawn(P).TransientSoundVolume=0.200000;
		}
	}
}

/* GetInventoryClassOverride()
return the string passed in, or a replacement class name string.
*/
function string GetInventoryClassOverride(string InventoryClassName)
{
	local int i;

	for (i=0;i<Replacements.Length;i++)
	{
		if (string(GetInventoryFor(Replacements[i].OldItem)) ~= InventoryClassName)
		{
			if (bRandomDefaultWeapons || i == 0)
				InventoryClassName = string(GetInventoryFor(GetNewItem(i)));
			else
				InventoryClassName = string(GetInventoryFor(Replacements[i].NewItems[0]));
		}
	}
	return Super.GetInventoryClassOverride(InventoryClassName);
}
/*
function class<Weapon> MyDefaultWeapon()
{
	if (DefaultWeapon == None)
	{
		if (bRandomDefaultWeapons)
			DefaultWeapon = class<Weapon>(DynamicLoadObject(string(GetInventoryFor(GetNewItem(1))), class'Class'));
		else
			DefaultWeapon = class<Weapon>(DynamicLoadObject(string(GetInventoryFor(Replacements[1].NewItems[0])), class'Class'));
	}
	return DefaultWeapon;
}
*/
// Figure out alignment of an item
function rotator PickupAlign (Actor Old, out vector HitLoc, optional class<Actor> Replacement)
{
	local actor T;
	local Rotator R, Dir;
	local Vector HitNorm, X, Y, Z, Extent;

	if (Replacement != None)
	{
		Extent.X = Replacement.default.CollisionRadius;
		Extent.Y = Replacement.default.CollisionRadius;
		Extent.Z = Replacement.default.CollisionHeight;
	}
	T = Trace(HitLoc, HitNorm, Old.Location - vect(0,0,200), Old.Location + vect(0,0,40), false, Extent);
	if (T == None)
	{
		HitLoc = Old.Location;
//		HitLoc.Z += Extent.Z - Old.CollisionHeight;
		return Old.Rotation;
	}
	if (StaticMeshActor(T) != None)
		HitLoc.Z += 3;
	else if (TerrainInfo(T) != None)
		HitLoc.Z += 5;

	Dir = Rotator(HitNorm);
	Dir.Pitch -= 16384;
	R = Old.Rotation;
	R.Pitch = 0;
	R.Roll = 0;
	GetAxes (R,X,Y,Z);
	X = X >> Dir;
	Y = Y >> Dir;
	Z = Z >> Dir;
	Dir = OrthoRotation (X,Y,Z);

	return Dir;
}

static function Weapon SpawnWeapon(class<weapon> newClass, Pawn P)
{
	local Weapon newWeapon;

    if( (newClass!=None) && P != None && (P.FindInventoryType(newClass)==None) )
    {
        newWeapon = P.Spawn(newClass,,,P.Location);
        if( newWeapon != None )
            newWeapon.GiveTo(P);
		return newWeapon;
    }
	
	return None;
}

static function SpawnAmmo(class<Ammunition> newClass, Pawn P, optional float Multiplier)
{
	local Ammunition Ammo;

	if (P==None || newClass == None)
		return;
	Ammo = Ammunition(P.FindInventoryType(newClass));
	if(Ammo == None)
    {
		Ammo = P.Spawn(newClass);
		P.AddInventory(Ammo);
    }
	if(Ammo == None)
		return;
    if (Multiplier > 0)
		Ammo.AddAmmo(Ammo.InitialAmount*Multiplier);
    else
		Ammo.AddAmmo(Ammo.InitialAmount);
	Ammo.GotoState('');
}

function ItemPickedUp(Pickup Other)
{
	local float ChangeTime;

	if (!bPickupsChange)
		return;

	if (level.Game.bWeaponStay && BallisticWeaponPickup(Other) != None)
		ChangeTime = 10;
	else
		ChangeTime = 0.1;
	if (BallisticWeaponPickup(Other) != None && BallisticWeaponPickup(Other).ReplacementsIndex > -1 && Replacements[BallisticWeaponPickup(Other).ReplacementsIndex].NewItems.length > 1)
		BallisticWeaponPickup(Other).ChangeTime = level.TimeSeconds + ChangeTime;
	if (BallisticAmmoPickup(Other) != None && BallisticAmmoPickup(Other).ReplacementsIndex > -1 && Replacements[BallisticAmmoPickup(Other).ReplacementsIndex].NewItems.length > 1)
		BallisticAmmoPickup(Other).ChangeTime = level.TimeSeconds + ChangeTime;
}

function ItemChange(Pickup Other)
{
	local Pickup NewPickup;

	if (BallisticWeaponPickup(Other) != None)
	{
		BallisticWeaponPickup(Other).ChangeTime = 0;
		SpawnNewItem(BallisticWeaponPickup(Other).ReplacementsIndex, Other, , NewPickup);
		if (!level.Game.bWeaponStay && NewPickup != None)
			NewPickup.StartSleeping();
	}
    else if (BallisticAmmoPickup(Other) != None)
	{
		BallisticAmmoPickup(Other).ChangeTime = 0;
		SpawnNewItem(BallisticAmmoPickup(Other).ReplacementsIndex, Other, , NewPickup);
		if (!level.Game.bWeaponStay && NewPickup != None)
			NewPickup.StartSleeping();
	}
	else
		return;
	Other.Destroy();
}

simulated event Timer()
{
	local int i;
	if (!bLWsInitialized)
		AdjustLockerWeapons();
 	if (Role < ROLE_Authority)
 		return;
	while (DoomedItems.Length > 0)
	{
		if (/*DoomedItems[0].OldItem != None && */DoomedItems[0].NewClass != None && DoomedItems[0].Instigator != None)
		{
			SpawnWeapon(class<Weapon>(GetInventoryFor(DoomedItems[0].NewClass)), DoomedItems[0].Instigator);
			if (DoomedItems[0].OldItem != None)
				DoomedItems[0].OldItem.Destroy();
		}
		DoomedItems.Remove(0,1);
	}
	for (i=0;i<PickupSwaps.Length;i++)
	{
		if (PickupSwaps[i].Old != None)
			if (!SpawnNewItem(PickupSwaps[i].NewIndex, PickupSwaps[i].Old))
				PickupSwaps[i].Old.Destroy();
	}
	PickupSwaps.Length = 0;
}

function SwapWeapon(Actor OldItem, class<Actor> NewItem)
{
	DoomedItems.Length=DoomedItems.Length+1;
	DoomedItems[DoomedItems.Length-1].OldItem = OldItem;
	DoomedItems[DoomedItems.Length-1].NewClass = NewItem;
	DoomedItems[DoomedItems.Length-1].Instigator = OldItem.Instigator;
	SetTimer(0.05, false);
}

function AddPickupSwap (Pickup Old, int NewIndex)
{
	if (Old == None || NewIndex < 0 || NewIndex >= Replacements.length)
		return;
	PickupSwaps.Length = PickupSwaps.Length + 1;
	PickupSwaps[PickupSwaps.Length-1].Old = Old;
	PickupSwaps[PickupSwaps.Length-1].NewIndex = NewIndex;
	SetTimer(0.05, false);
}

function PlayerChangedClass(Controller C)
{
	super.PlayerChangedClass (C);
	if (Bot(C) != None && (C.PawnClass	== None || C.PawnClass == class'xPawn' || bForceBallisticPawn) )
		Bot(C).PawnClass = class'BallisticPawn';
}

// Check for item replacement.
function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local int i, j;
	local float OMA, NMA;
	local class<actor> NewItem;

	local BallisticPlayerReplicationInfo BPRI;
	local LinkedReplicationInfo LPRI;
	
	bSuperRelevant = 0;

	if(Controller(Other) != None && InStr(Caps(Level.Game.GameName),"FREON") == -1 && InStr(Caps(Level.Game.GameName),"ARENAMASTER") == -1) //bypass this in 3SPN, handled differently
	{
		if (PlayerController(Other) != None && (Controller(Other).PawnClass == None || Controller(Other).PawnClass == class'xPawn' || bForceBallisticPawn))
			PlayerController(Other).PawnClass = class'BallisticPawn';
		else if (Bot(Other) != None && (Controller(Other).PawnClass == None || Controller(Other).PawnClass == class'xPawn' || bForceBallisticPawn))
			Bot(Other).PreviousPawnClass = class'BallisticPawn';
	}
	
	//add Linked PRI
	else if (PlayerReplicationInfo(Other) != None)
	{
		BPRI = Spawn(class'BallisticPlayerReplicationInfo', Other.Owner);		
		
		if(PlayerReplicationInfo(Other).CustomReplicationInfo != None)
		{
			lPRI = PlayerReplicationInfo(Other).CustomReplicationInfo;
			PlayerReplicationInfo(Other).CustomReplicationInfo = BPRI;
			
			 if (BPRI.NextReplicationInfo != None)
				BPRI.NextReplicationInfo.NextReplicationInfo = lPRI;
			else
				BPRI.NextReplicationInfo = lPRI;
		}
		else
			PlayerReplicationInfo(Other).CustomReplicationInfo = BPRI;
	}
	
	else if (JumpSpot(Other) != None && BallisticReplicationInfo(BallisticReplicationInfo) != None && BallisticReplicationInfo(BallisticReplicationInfo).bNoDodging)
	{
		JumpSpot(Other).bDodgeUp = false;
	}
	else if (xPawn(Other) != None)
	{
		if (bRandomDefaultWeapons)
			xPawn(Other).RequiredEquipment[0] = string(GetInventoryFor(GetNewItem(1)));
		else
			xPawn(Other).RequiredEquipment[0] = string(GetInventoryFor(Replacements[1].NewItems[0]));
		xPawn(Other).RequiredEquipment[1] = string(GetInventoryFor(GetNewItem(0)));
	}

	else if (Weapon(Other) != None || xWeaponBase(Other) != None || WildCardBase(Other) != None || xPickupBase(Other) != None || WeaponLocker(Other) != None || Pickup(Other) != None)
	{
		//Go through replacements list and see if there is a match
		for (i=0;i<Replacements.Length;i++)
		{
			// Swap weapons
			if (Weapon(Other) != None)
			{
				if (GetInventoryFor(Replacements[i].OldItem) == Weapon(Other).Class && (!Replacements[i].bSuper || !bLeaveSuper))
					SwapWeapon(Other, GetInventoryFor(Replacements[i].NewItems[Rand(Replacements[i].NewItems.length)]));
			}
			// Replace Weapon base
			else if (xWeaponBase(Other) != None && xWeaponBase(Other).WeaponType != None && xWeaponBase(Other).WeaponType == GetInventoryFor(Replacements[i].OldItem) && (!Replacements[i].bSuper || !bLeaveSuper))
			{
				if (Replacements[i].bUseBase)
				{
					NewItem = GetNewItem(i);
					xWeaponBase(Other).WeaponType = class<weapon>(GetInventoryFor(NewItem));
					xWeaponBase(Other).PowerUp = GetPickupFor(NewItem);
				}
				else return SpawnNewItem(i, Other);
			}
			
			// Change pickup classes for WildcardBases
			else if (WildcardBase(Other) != None)
			{
				for(j=0;j<ArrayCount(WildcardBase(Other).PickupClasses);j++)
				{
					if (WildcardBase(Other).PickupClasses[j] != None && WildcardBase(Other).PickupClasses[j] == GetPickupFor(Replacements[i].OldItem) && (!Replacements[i].bSuper || !bLeaveSuper) && class<TournamentPickup>(GetPickupFor(GetNewItem(i))) != None)
						WildcardBase(Other).PickupClasses[j] = class<TournamentPickup>(GetPickupFor(GetNewItem(i)));
				}
			}
			
			// Replace Pickup base
			else if (xPickupBase(Other) != None && xPickupBase(Other).PowerUp != None && xPickupBase(Other).PowerUp == GetPickupFor(Replacements[i].OldItem) && (!Replacements[i].bSuper || !bLeaveSuper))
			{
				if (Replacements[i].bUseBase)
					xPickupBase(Other).PowerUp = GetPickupFor(GetNewItem(i));
				else return SpawnNewItem(i, Other);
			}
			
			// Change weapons in weaponlockers
			else if (WeaponLocker(Other) != None && (!Replacements[i].bSuper || !bLeaveSuper))
			{
				for (j=0;j<WeaponLocker(Other).Weapons.Length;j++)
				{
					if (WeaponLocker(Other).Weapons[j].WeaponClass == GetInventoryFor(Replacements[i].OldItem))
					{
						NewItem = GetNewItem(i);
						OMA = WeaponLocker(Other).Weapons[j].WeaponClass.default.FireModeClass[0].default.AmmoClass.default.MaxAmmo;
						NMA = class<weapon>(GetInventoryFor(NewItem)).default.FireModeClass[0].default.AmmoClass.default.MaxAmmo;
						WeaponLocker(Other).Weapons[j].ExtraAmmo = NMA * (WeaponLocker(Other).Weapons[j].ExtraAmmo / OMA);
						WeaponLocker(Other).Weapons[j].ExtraAmmo *= 2;
						WeaponLocker(Other).Weapons[j].WeaponClass = class<weapon>(GetInventoryFor(NewItem));
					}
				}
			}
			
			// Replace Pickup
			else if (Pickup(Other) != None && Pickup(Other).Class == GetPickupFor(Replacements[i].OldItem) && (!Replacements[i].bSuper || !bLeaveSuper))
				AddPickupSwap(Pickup(Other), i);
		}
	}
	return true;
}

// Spawns a new item from the replacements list at Index or uses NewITem if there is one
// Takes care of old pickup or PickupBase
// Returns true if failed and old pickup should stay
function bool SpawnNewItem(int Index, Actor Other, optional class<Actor> NewItem, optional out Pickup A)
{
	local Rotator ItemRot;
	local vector ItemLoc;

	// Get the new item class
	if (NewItem == None)
	{
		if (Index < 0 || (Replacements[Index].bSuper && bLeaveSuper))
			return true;
		NewItem = GetNewItem(Index,,Other.Class);
		if (NewItem == None)
		{
			log("Couldn't find new item for old "$Replacements[Index].OldItem$" in replacements list");
			return true;
		}
	}
	// Figure out Alignment
	ItemRot = PickupAlign(Other, ItemLoc, GetPickupFor(NewItem));
	if (class<BallisticWeaponPickup>(GetPickupFor(NewItem)) != None && class<BallisticWeaponPickup>(GetPickupFor(NewItem)).default.bOnSide)
		ItemRot.Roll += 16384;
	// Spawn the new item
	A = Spawn(GetPickupFor(NewItem),,,ItemLoc, ItemRot);
	if (A == None)
		return true;
	// Implement bright pickups
	if (bBrightPickups && level.NetMode == NM_StandAlone)
    	A.AmbientGlow = 128;
    // Set some stuff for Weapon and Ammo Pickups so tehy can change later
    if (BallisticWeaponPickup(A) != None)
    {
		BallisticWeaponPickup(A).OnItemChange = ItemChange;
		BallisticWeaponPickup(A).OnItemPickedUp = ItemPickedUp;
    	BallisticWeaponPickup(A).ReplacementsIndex = Index;
    }
	else if (BallisticAmmoPickup(A) != None)
    {
		BallisticAmmoPickup(A).OnItemChange = ItemChange;
		BallisticAmmoPickup(A).OnItemPickedUp = ItemPickedUp;
		BallisticAmmoPickup(A).ReplacementsIndex = Index;
    }

	// Settings for when old actor is a Pickup
	if (Pickup(Other) != None)
	{
		if (Pickup(Other).PickupBase != None && WildcardBase(Pickup(Other).PickupBase) != None)
		{
			A.PickupBase = Pickup(Other).PickupBase;
			A.PickupBase.myPickUp = A;
		}
		if (Pickup(Other).myMarker != None)
		{
			A.myMarker = Pickup(Other).MyMarker;
			A.myMarker.markedItem = A;
			Pickup(Other).myMarker = None;
		}
	}
	// Settings for when old actor is a xPickupBase
	else if (xPickupBase(Other) != None)
	{
		if (xWeaponBase(Other) != None)
			xWeaponBase(Other).WeaponType = None;
		xPickupBase(Other).PowerUp = None;
		Other.bHidden = true;
        A.Event = xPickupBase(Other).event;
		if (xPickupBase(Other).myMarker != None)
		{
			A.myMarker = xPickupBase(Other).MyMarker;
			A.myMarker.myPickupBase = None;
			A.myMarker.markedItem = A;
			A.myMarker.ExtraCost = xPickupBase(Other).ExtraPathCost;
			xPickupBase(Other).MyMarker = None;
		}
		return true;
	}
	return false;
}

simulated event Tick(float DT)
{
	super.Tick(DT);

	if (bDoItemize)
	{
		bDoItemize=false;
		class'ItemizerDB'.static.SpawnItems(class'ItemizerDB'.static.GetMap(self), ItemGroup, self, true);
	}
	if (level.NetMode != NM_DedicatedServer && !bSpawnedIA && level.GetLocalPlayerController() != None)
	{
		class'BallisticInteraction'.static.Launch (level.GetLocalPlayerController());
		bSpawnedIA=true;
	}
}

simulated function PreBeginPlay()
{
	if (Role == ROLE_Authority)
		BallisticReplicationInfo = class'BallisticReplicationInfo'.static.HitMe(self);

	if (level.Game != None)
	{
		Level.Game.AddGameModifier(Spawn(class'Rules_KillRewards'));
		
		if(DeathMatch(Level.Game) != none)
        {
           DeathMatch(Level.Game).ADR_Kill = class'BallisticReplicationInfo'.default.ADRKill;
           DeathMatch(Level.Game).ADR_MajorKill = class'BallisticReplicationInfo'.default.ADRMajorKill;
           DeathMatch(Level.Game).ADR_MinorBonus = class'BallisticReplicationInfo'.default.ADRMinorBonus;
           DeathMatch(Level.Game).ADR_KillTeamMate = class'BallisticReplicationInfo'.default.ADRKillTeamMate;
           DeathMatch(Level.Game).ADR_MinorError = class'BallisticReplicationInfo'.default.ADRMinorError;
        }
		
		if (level.Game.DefaultPlayerClassName ~= "XGame.xPawn" || bForceBallisticPawn)
			level.Game.DefaultPlayerClassName = "BallisticProV55.BallisticPawn";
		if (level.Game.PlayerControllerClassName ~= "XGame.xPlayer")
			Level.Game.PlayerControllerClassName = "BallisticProV55.BallisticPlayer";
	}
	LoadItemClasses();
	super.PreBeginPlay();
}

simulated function LoadItemClasses()
{
	local int i, j;

	for (i=0;i<Replacements.length;i++)
	{
		if (Replacements[i].OldItemName != "")
		{
			Replacements[i].OldItem = class<Actor>(DynamicLoadObject(Replacements[i].OldItemName, class'Class'));
			if (Replacements[i].OldItem == None)
				log("Mut_Balistic::LoadItemClasses: Bad old item class name "$Replacements[i].OldItemName$" for Replacements["$i$"]", 'Warning');
		}
	}

	for (i=0;i<Replacements.length;i++)
		if (Replacements[i].NewItemNames.length > 0)
			for(j=0;j<Replacements[i].NewItemNames.length;j++)
				if (Replacements[i].NewItemNames[j] != "")
				{
					Replacements[i].NewItems[j] = class<Actor>(DynamicLoadObject(Replacements[i].NewItemNames[j], class'Class'));
					if (Replacements[i].NewItems[j] == None)
						log("Mut_Balistic::LoadItemClasses: Bad new item class name "$Replacements[i].NewItemNames[j]$" in Replacements["$i$"]", 'Warning');
				}
}

function PostBeginPlay()
{
	local GameRules GR;
	super.PostBeginPlay();
	// Use Itemizer to spawn extra Ballistic Pickups
	if (bUseItemizer && Role==ROLE_Authority)
		bDoItemize=true;

	if (Invasion(Level.Game) != None)
		GR = spawn(class'Rules_Invasion');
	else GR = spawn(class'Rules_Ballistic');
	if ( Level.Game.GameRulesModifiers == None )
		Level.Game.GameRulesModifiers = GR;
	else
		Level.Game.GameRulesModifiers.AddGameRules(GR);
}

//simulated function PostNetBeginPlay()
simulated function BeginPlay()
{
	local xPickupBase PB;
	local WeaponLocker W;
	local int i, j;

	if (Level.NetMode == NM_Client)
	{
		// Remove all pads...
	    ForEach AllActors(class'xPickupBase', PB)
		{
			// Why the hell are these things so tough?
		    PB.bHidden=true;
			PB.SetDrawType(DT_None);
			if (PB.myEmitter != None)
				PB.myEmitter.Destroy();
		}
	    ForEach AllActors(class'WeaponLocker', W)
		{
			if (bHideLockers)
				W.GotoState('Disabled');
			else
			{
				for (i=0;i<Replacements.Length;i++)
					for (j=0;j<W.Weapons.Length;j++)
						if (W.Weapons[j].WeaponClass == GetInventoryFor(Replacements[i].OldItem))
						{
//							W.Weapons[j].WeaponClass = class<weapon>(GetInventoryFor(GetNewItem(i, true)));
							W.Weapons[j].WeaponClass = class<weapon>(GetInventoryFor(Replacements[i].NewItems[0]));
						}
			}
		}
	}
	// Stuff won't be ready now, do it after its had a chance to init...
	SetTimer(0.05, false);
	Super.BeginPlay();
}

simulated function AdjustLockerWeapons()
{
	local LockerWeapon L;
	local class<UTWeaponPickup> NP;
	local int i, j;

	if (bLWsInitialized)
		return;
	bLWsInitialized = true;
	if (bHideLockers)
		return;
	// Set mesh for locker weapons and make sure its the LowPoly version
    ForEach AllActors(class'LockerWeapon', L)
	{
		for (i=0;i<Replacements.Length;i++)
		{
			for (j=0;j<L.Emitters.Length;j++)
			{
				NP = class<UTWeaponPickup>(GetPickupFor(Replacements[i].NewItems[0]));
				if (NP != None && ( MeshEmitter(L.Emitters[j]).StaticMesh == GetPickupFor(Replacements[i].OldItem).default.StaticMesh ||
					MeshEmitter(L.Emitters[j]).StaticMesh == NP.default.StaticMesh) )
				{
					if (class<BallisticWeaponPickup>(NP) != None)
						MeshEmitter(L.Emitters[j]).StaticMesh = class<BallisticWeaponPickup>(NP).Default.LowPolyStaticMesh;
					else
						MeshEmitter(L.Emitters[j]).StaticMesh = NP.Default.StaticMesh;
					MeshEmitter(L.Emitters[j]).StartSpinRange.X.Min = NP.Default.Standup.X;
					MeshEmitter(L.Emitters[j]).StartSpinRange.X.Max = NP.Default.Standup.X;
					MeshEmitter(L.Emitters[j]).StartSpinRange.Y.Min = NP.Default.Standup.Y;
					MeshEmitter(L.Emitters[j]).StartSpinRange.Y.Max = NP.Default.Standup.Y;
					MeshEmitter(L.Emitters[j]).StartSpinRange.Z.Min = NP.Default.Standup.Z;
					MeshEmitter(L.Emitters[j]).StartSpinRange.Z.Max = NP.Default.Standup.Z;
					MeshEmitter(L.Emitters[j]).StartSizeRange.X.Min = 0.9 * NP.default.DrawScale;
					MeshEmitter(L.Emitters[j]).StartSizeRange.X.Max = 0.9 * NP.default.DrawScale;
					MeshEmitter(L.Emitters[j]).StartSizeRange.Y.Min = 0.9 * NP.default.DrawScale;
					MeshEmitter(L.Emitters[j]).StartSizeRange.Y.Max = 0.9 * NP.default.DrawScale;
					MeshEmitter(L.Emitters[j]).StartSizeRange.Z.Min = 0.9 * NP.default.DrawScale;
					MeshEmitter(L.Emitters[j]).StartSizeRange.Z.Max = 0.9 * NP.default.DrawScale;
				}
			}
		}
	}
}

function Array<Class<Weapon> > GetAllWeaponClasses()
{
	local int i, j, k;
	local Array<Class<Weapon> > Weaps;

	for(i=0;i<Replacements.length;i++)
	{
		if (Replacements[i].NewItems.length > 0)
		{
			for(j=0;j<Replacements[i].NewItems.length;j++)
			{
				if (class<Weapon>(GetInventoryFor(Replacements[i].NewItems[j])) != None)
				{
					for(k=0;k<Weaps.length;k++)
						if (Weaps[k] == GetInventoryFor(Replacements[i].NewItems[j]))
							break;
					if (k >= Weaps.length)
						Weaps[Weaps.length] = class<Weapon>(GetInventoryFor(Replacements[i].NewItems[j]));
				}
			}
		}
	}
	return Weaps;
}

function BCSprintControl GetSprintControl(PlayerController Sender)
{
    local int i;

    for (i=0;i<Sprinters.length;i++)
        if (Sprinters[i] != None && Sprinters[i].Instigator != None && Sprinters[i].Instigator.Controller == Sender)
            return Sprinters[i];
    return None;
}

function Mutate(string MutateString, PlayerController Sender)
{
    local BCSprintControl SC;

    if (MutateString ~= "BStartSprint" && bUseSprint)
    {
        SC = GetSprintControl(Sender);
        if (SC != None)
            SC.StartSprint();
    }
    else if (MutateString ~= "BStopSprint" && bUseSprint)
    {
        SC = GetSprintControl(Sender);
        if (SC != None)
            SC.StopSprint();
    }

    super.Mutate(MutateString, Sender);
}

defaultproperties
{
     Replacements(0)=(OldItemName="XWeapons.ShieldGun",NewItemNames=("BallisticProV55.X3Pickup","BallisticProV55.A909Pickup","BallisticProV55.EKS43Pickup","BallisticProV55.X4Pickup"))
     Replacements(1)=(OldItemName="XWeapons.AssaultRifle",NewItemNames=("BallisticProV55.M806Pickup","BallisticProV55.MRT6Pickup","BallisticProV55.A42Pickup","BallisticProV55.XK2Pickup","BallisticProV55.D49Pickup","BallisticProV55.AM67Pickup","BallisticProV55.Fifty9Pickup","BallisticProV55.RS8Pickup","BallisticProV55.XRS10Pickup","BallisticProV55.GRS9Pickup","BallisticProV55.leMatPickup","BallisticProV55.BOGPPickup","BallisticProV55.MD24Pickup","BallisticProV55.XMK5Pickup"))
     Replacements(2)=(OldItemName="XWeapons.BioRiflePickup",NewItemNames=("BallisticProV55.NRP57Pickup","BallisticProV55.FP7Pickup","BallisticProV55.FP9Pickup","BallisticProV55.BX5Pickup","BallisticProV55.T10Pickup"))
     Replacements(3)=(OldItemName="XWeapons.ShockRiflePickup",NewItemNames=("BallisticProV55.M50Pickup","BallisticProV55.XK2Pickup","BallisticProV55.SARPickup","BallisticProV55.SRS900Pickup","BallisticProV55.M46Pickup","BallisticProV55.XMK5Pickup"))
     Replacements(4)=(OldItemName="XWeapons.LinkGunPickup",NewItemNames=("BallisticProV55.A73Pickup","BallisticProV55.A42Pickup","BallisticProV55.HVCMk9Pickup","BallisticProV55.E23Pickup","BallisticProV55.RSDarkPickup","BallisticProV55.RSNovaPickup"))
     Replacements(5)=(OldItemName="XWeapons.MinigunPickup",NewItemNames=("BallisticProV55.M353Pickup","BallisticProV55.M925Pickup","BallisticProV55.XMV850Pickup"))
     Replacements(6)=(OldItemName="XWeapons.FlakCannonPickup",NewItemNames=("BallisticProV55.M763Pickup","BallisticProV55.M290Pickup","BallisticProV55.MRS138Pickup","BallisticProV55.A500Pickup"))
     Replacements(7)=(OldItemName="XWeapons.RocketLauncherPickup",NewItemNames=("BallisticProV55.G5Pickup","BallisticProV55.RX22APickup","BallisticProV55.MACPickup","BallisticProV55.MRLPickup"))
     Replacements(8)=(OldItemName="XWeapons.SniperRiflePickup",NewItemNames=("BallisticProV55.R78Pickup","BallisticProV55.M75Pickup","BallisticProV55.R9Pickup","BallisticProV55.MarlinPickup"))
     Replacements(9)=(OldItemName="XWeapons.PainterPickup",bSuper=True,NewItemNames=("BallisticProV55.R78Pickup","BallisticProV55.M75Pickup","BallisticProV55.R9Pickup","BallisticProV55.MarlinPickup"))
     Replacements(10)=(OldItemName="XWeapons.RedeemerPickup",bSuper=True,NewItemNames=("BallisticProV55.M75Pickup","BallisticProV55.G5Pickup","BallisticProV55.RX22APickup","BallisticProV55.MACPickup","BallisticProV55.MRLPickup"))
     Replacements(11)=(OldItemName="UTClassic.ClassicSniperRiflePickup",NewItemNames=("BallisticProV55.R78Pickup","BallisticProV55.M75Pickup","BallisticProV55.R9Pickup","BallisticProV55.MarlinPickup"))
     Replacements(12)=(OldItemName="Onslaught.ONSAVRiLPickup",NewItemNames=("BallisticProV55.G5Pickup","BallisticProV55.M75Pickup","BallisticProV55.MACPickup"))
     Replacements(13)=(OldItemName="Onslaught.ONSGrenadePickup",NewItemNames=("BallisticProV55.NRP57Pickup","BallisticProV55.FP7Pickup","BallisticProV55.T10Pickup"))
     Replacements(14)=(OldItemName="Onslaught.ONSMineLayerPickup",NewItemNames=("BallisticProV55.FP9Pickup","BallisticProV55.BX5Pickup"))
     Replacements(15)=(OldItemName="OnslaughtFull.ONSPainterPickup",bSuper=True,NewItemNames=("BallisticProV55.R78Pickup","BallisticProV55.M75Pickup","BallisticProV55.R9Pickup","BallisticProV55.MarlinPickup"))
     Replacements(16)=(OldItemName="XWeapons.AssaultAmmoPickup",NewItemNames=("BallisticProV55.AP_M806Clip","BallisticProV55.AP_12GaugeClips","BallisticProV55.AP_XK2Clip","BallisticProV55.AP_6Magnum","BallisticProV55.AP_AM67Clip","BallisticProV55.AP_Fifty9Clip","BallisticProV55.AP_RS8Clip","BallisticProV55.AP_XRS10Clip","BallisticProV55.AP_GRS9Clip","BallisticProV55.AP_leMat","BallisticProV55.AP_BOGPGrenades","BallisticProV55.AP_MD24Clip","BallisticProV55.AP_XMK5Clip"))
     Replacements(17)=(OldItemName="XWeapons.BioAmmoPickup",NewItemNames=("BallisticProV55.NRP57Pickup","BallisticProV55.FP7Pickup","BallisticProV55.FP9Pickup","BallisticProV55.BX5Pickup","BallisticProV55.T10Pickup"))
     Replacements(18)=(OldItemName="XWeapons.ShockAmmoPickup",NewItemNames=("BallisticProV55.AP_556mmClip","BallisticProV55.AP_XK2Clip","BallisticProV55.AP_SARClip","BallisticProV55.AP_SRS900Clip","BallisticProV55.AP_M46Clip","BallisticProV55.AP_XMK5Clip"))
     Replacements(19)=(OldItemName="XWeapons.LinkAmmoPickup",NewItemNames=("BallisticProV55.AP_A73Clip","BallisticProV55.AP_HVCMk9Cell","BallisticProV55.AP_E23Clip","BallisticProV55.AP_DarkDiamond","BallisticProV55.AP_NovaCrystal"))
     Replacements(20)=(OldItemName="XWeapons.MinigunAmmoPickup",NewItemNames=("BallisticProV55.AP_M353Belt","BallisticProV55.AP_M925Belt","BallisticProV55.AP_XMV850Ammo"))
     Replacements(21)=(OldItemName="XWeapons.FlakAmmoPickup",NewItemNames=("BallisticProV55.AP_12GaugeBox","BallisticProV55.AP_MRS138Box","BallisticProV55.AP_A500Cells"))
     Replacements(22)=(OldItemName="XWeapons.RocketAmmoPickup",NewItemNames=("BallisticProV55.AP_G5Ammo","BallisticProV55.AP_FlamerGas","BallisticProV55.AP_MACShells","BallisticProV55.AP_MRLRockets"))
     Replacements(23)=(OldItemName="XWeapons.SniperAmmoPickup",NewItemNames=("BallisticProV55.AP_R78Clip","BallisticProV55.AP_M75Clip","BallisticProV55.AP_R9Clip","BallisticProV55.AP_MarlinAmmo"))
     Replacements(24)=(OldItemName="UTClassic.ClassicSniperAmmoPickup",NewItemNames=("BallisticProV55.AP_R78Clip","BallisticProV55.AP_M75Clip","BallisticProV55.AP_R9Clip","BallisticProV55.AP_MarlinAmmo"))
     Replacements(25)=(OldItemName="Onslaught.ONSAVRiLAmmoPickup",NewItemNames=("BallisticProV55.AP_G5Ammo","BallisticProV55.AP_M75Clip","BallisticProV55.AP_MACShells"))
     Replacements(26)=(OldItemName="Onslaught.ONSGrenadeAmmoPickup",NewItemNames=("BallisticProV55.NRP57Pickup","BallisticProV55.FP7Pickup","BallisticProV55.T10Pickup"))
     Replacements(27)=(OldItemName="Onslaught.ONSMineAmmoPickup",NewItemNames=("BallisticProV55.FP9Pickup","BallisticProV55.BX5Pickup"))
     Replacements(28)=(OldItemName="XPickups.HealthPack",NewItemNames=("BallisticProV55.IP_HealthKit"))
     Replacements(29)=(OldItemName="XPickups.MiniHealthPack",NewItemNames=("BallisticProV55.IP_Bandage"))
     Replacements(30)=(OldItemName="XPickups.AdrenalinePickup",NewItemNames=("BallisticProV55.IP_Adrenaline"))
     Replacements(31)=(OldItemName="XPickups.UDamagePack",NewItemNames=("BallisticProV55.IP_UDamage"))
     Replacements(32)=(OldItemName="XPickups.SuperHealthPack",NewItemNames=("BallisticProV55.IP_SuperHealthKit"))
     Replacements(33)=(OldItemName="XPickups.SuperShieldPack",NewItemNames=("BallisticProV55.IP_BigArmor"))
     Replacements(34)=(OldItemName="XPickups.ShieldPack",NewItemNames=("BallisticProV55.IP_SmallArmor"))
     UDamageSnd=Sound'BW_Core_WeaponSound.Udamage.UDamageFire'
     
	 bUseSprint=True
     InitStamina=100.000000
     InitMaxStamina=100.000000
     InitStaminaDrainRate=15.000000
     InitStaminaChargeRate=20.000000
     InitSpeedFactor=1.350000
     JumpDrainFactor=2.000000
	 
	 ItemGroup="Ballistic"
     bSpawnUniqueItems=True
     bPickupsChange=True
     bRandomDefaultWeapons=True
     footstepAmplifier=1.500000
	 CamUpdateRate="1"
     CamRateOptions(0)="No Update"
     CamRateOptions(1)="Slow 2 FPS"
     CamRateOptions(2)="Medium 5 FPS"
     CamRateOptions(3)="Fast 10 FPS"
     CamRateOptions(4)="Super 15 FPS"
     bAddToServerPackages=True
     ConfigMenuClassName="BallisticProV55.BallisticConfigMenuPro"
     GroupName="Arena"
     FriendlyName="BallisticPro"
     Description="Replaces all the original weapons and items in the game with new, realistic Ballistic weapons and items. Adds reloading, fire modes, special weapon functions, real accuracy, realistic damage, special features like laser sights and tactical cameras, new effects and much much more...||http://www.runestorm.com"
     bNetTemporary=True
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
