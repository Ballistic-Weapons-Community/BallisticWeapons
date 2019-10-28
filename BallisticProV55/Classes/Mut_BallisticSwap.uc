//=============================================================================
// Mut_BallisticSwap.
//
// Implements Ballistic Mod with all mutator features, replacing original
// weapon type with chosen Ballistic ones. When multiple new weapons are set to
// replace a single old pickup, one of the new weapons is picked randomly and
// replaces all instances of the original weapon. All ammo pickups for the old
// weapons are replaced with ammo for the new weapon.
// For every swap that has multiple new weapons, a new item is chosen randomly
// and all pickups are changed at intervals determined by PickupChangeTime.
// When bRandom is set, each ammo and weapon pickup of the same type is treated
// seperately and replaced with any one of the new pickups.
//
// This also allows the swap lists to be changed and configured during the game.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Mut_BallisticSwap extends Mut_Ballistic;

//===========================================================================
// Structs
//===========================================================================

struct WeaponSwap	// The info to swap 1 old weapon with multiple new ones
{
	var() config bool			bRandom;		// Don't sync all weapons, just spawn them randomly from NewClasses list
	var() config class<Weapon>	Old;			// The original class
	var() config Array<string>	NewClassNames;	// Class names of new weapons
	var   Array<class<Weapon> >	NewClasses;		// Classes of new weapons(generated from NewClassNames list)
	var() byte					CurrentIndex;	// Index of currently active weapon in NewClasses array
	var() bool					bSuper;			// The old one is a super weapon. Allow it to stay if bLeaveSuper
};
struct AmmoSwap		// The info to swap 1 old ammo with multiple new ones (generated from and kept in sync with the weapons!)
{
	var() config bool			bIndependant;	// Like bRandom for weapons...
	var() config class<Ammunition> Old;			// Old Ammo class
	var   Array<class<Pickup> >	NewClasses;		// Classes of new ammos
	var() byte					CurrentIndex;	// Index of currently active weapon in NewClasses array
};

//===========================================================================
// Constants
//===========================================================================
const NumWeapons = 17;			// Number of entires in the weapon swap list
const NumAmmos = 14;			// Number of entires in the ammo swap list

//===========================================================================
// Vars
//===========================================================================
var() config WeaponSwap	Swaps[NumWeapons];		// List of the old weapons and what to replace them with
var() config AmmoSwap		AmmoSwaps[NumAmmos];	// List of the old ammos and what to replace them with (generated from Weapon swaps list)
var() config int					NadeReplacePercent; // Chance of replacing an ammo pickup with a grenade
var() config Array<class<BallisticWeaponPickup> > GrenadePickupClasses; // Config list of grenades that will be used in swapping
var 	bool	bLockersSetup;

var() config 	float	PickupChangeTime;		// How long between pickups being changed (for entires with multiple new items)
var() config 	float	LockerChangeTime;		// How long between locker weapons being changed
var() config 	bool	bLockersChange;			// Do locker weapons get swapped over time.

//===========================================================================
// Functions
//===========================================================================

// Return number of weapon swaps
static function int GetNumWeapons()	{	return NumWeapons;	}
// Return class of old weapon at index i in the swaps list
static function class<Weapon> GetOldWeaponClass(int i)	{	return default.Swaps[i].Old;	}
// Return list of new weapons for Swaps[i]. Also returns bRandom setting as an out byte
static function array<string> GetNewWeapons(int i, optional out byte bRandom)
{
	bRandom = byte(default.Swaps[i].bRandom);
	return default.Swaps[i].NewClassNames;
}
// Set the NewClassNames array and bRandom setting for Swaps[i]
static function SetNewWeapons(int i, array<string> NewWeaps, optional bool bRandom)
{
	default.Swaps[i].NewClassNames = NewWeaps;
	default.Swaps[i].bRandom = bRandom;
}

//===========================================================================
// PreBeginPlay
//
// FIXME: Generate ammo from weapons
//===========================================================================
simulated function PreBeginPlay()
{
	local int i, j, k;
	super.PreBeginPlay();

	if (Role < ROLE_Authority)
		return;
	PickupChangeTime = FMax(5, PickupChangeTime);
	PickupChangeTime = level.TimeSeconds + default.PickupChangeTime;
	LockerChangeTime = level.TimeSeconds + default.LockerChangeTime;
	// Load new weapon classes
	for(i=0;i<NumWeapons;i++)
	{
		Swaps[i].CurrentIndex = Rand(Swaps[i].NewClassNames.length);
		for (j=0;j<Swaps[i].NewClassNames.length;j++)
			if (Swaps[i].NewClassNames[j] != "")
				Swaps[i].NewClasses[j] = class<Weapon>(DynamicLoadObject( Swaps[i].NewClassNames[j], class'class' ));
	}
	// Generate ammo swap lists.
	// If weapon fire mode class matches ammo, pass over some data.
	for(i=0;i<NumAmmos;i++)
		for(j=0;j<NumWeapons;j++)
			if (Swaps[j].Old.default.FireModeClass[0].default.AmmoClass == AmmoSwaps[i].Old || Swaps[j].Old.default.FireModeClass[1].default.AmmoClass == AmmoSwaps[i].Old)
			{
				AmmoSwaps[i].CurrentIndex = Swaps[j].CurrentIndex;
				AmmoSwaps[i].bIndependant = Swaps[j].bRandom;
				for (k=0;k<Swaps[j].NewClasses.length;k++)
				{
					if (class<BallisticWeapon>(Swaps[j].NewClasses[k]) != None && class<BallisticWeapon>(Swaps[j].NewClasses[k]).static.RecommendAmmoPickup(-1) != None)
						AmmoSwaps[i].NewClasses[k] = class<BallisticWeapon>(Swaps[j].NewClasses[k]).static.RecommendAmmoPickup(-1);
					else
						AmmoSwaps[i].NewClasses[k] = Swaps[j].NewClasses[k].default.FireModeClass[0].default.AmmoClass.default.PickupClass;
				}
			}
}

// Give an extra magazine if the pickup is new.
// It actually gives you whatever the ammo pickup would.
function ItemPickedUp(Pickup Other)
{
	local class<Weapon> Weap;

	if(BallisticWeaponPickup(Other) == None)
		return;

	if(BallisticWeaponPickup(Other) != None && !BallisticWeaponPickup(Other).bDropped && BallisticWeaponPickup(Other).LastPickedUpBy != None)
	{
		Weap = class<Weapon>(BallisticWeaponPickup(Other).InventoryType);
		if(Weap != None)
		{
			SpawnAmmo(Weap.default.FireModeClass[0].default.AmmoClass, BallisticWeaponPickup(Other).LastPickedUpBy);
			if (Weap.default.FireModeClass[1].default.AmmoClass != None && Weap.default.FireModeClass[0].default.AmmoClass != Weap.default.FireModeClass[1].default.AmmoClass)
				SpawnAmmo(Weap.default.FireModeClass[1].default.AmmoClass, BallisticWeaponPickup(Other).LastPickedUpBy);
		}
	}
}

// Called by a weapon pickup that wants to change and is not visible to players
function WeaponPickupChange(Pickup Other)
{
	local BallisticWeaponPickup WP;

	if (BallisticWeaponPickup(Other) != None)
	{
		WP = BallisticWeaponPickup(Other);
		if (WP.ReplacementsIndex >= NumWeapons || WP.ReplacementsIndex < 0)
			return;
		if (Swaps[WP.ReplacementsIndex].bRandom)
			SwapPickup(WP, Swaps[WP.ReplacementsIndex].NewClasses[Rand(Swaps[WP.ReplacementsIndex].NewClasses.length)].default.PickupClass, WP.ReplacementsIndex);
		else
			SwapPickup(WP, Swaps[WP.ReplacementsIndex].NewClasses[Swaps[WP.ReplacementsIndex].CurrentIndex].default.PickupClass, WP.ReplacementsIndex);
	}
	else
		return;
	if (Other != None)
		Other.Destroy();
}

// Called by an ammo pickup that wants to change and is not visible to players
function AmmoPickupChange(Pickup Other)
{
	local BallisticWeaponPickup WP;
	local BallisticAmmoPickup 	AP;
	local class<Pickup> NewPickup;
//	local Pickup P;
	local int ReplacementsIndex;

	if (BallisticWeaponPickup(Other) != None)
	{
		WP = BallisticWeaponPickup(Other);
		WP.ChangeTime = 0.0;
		ReplacementsIndex = WP.ReplacementsIndex;
		if (AmmoSwaps[WP.ReplacementsIndex].bIndependant)
			NewPickup = AmmoSwaps[WP.ReplacementsIndex].NewClasses[Rand(AmmoSwaps[WP.ReplacementsIndex].NewClasses.length)];
		else
			NewPickup = AmmoSwaps[WP.ReplacementsIndex].NewClasses[AmmoSwaps[WP.ReplacementsIndex].CurrentIndex];
	}
    else if (BallisticAmmoPickup(Other) != None)
	{
		AP = BallisticAmmoPickup(Other);
		AP.ChangeTime = 0.0;
		ReplacementsIndex = AP.ReplacementsIndex;

		if (NadeReplacePercent > 0 && Rand(100) < NadeReplacePercent)
			NewPickup = GrenadePickupClasses[Rand(GrenadePickupClasses.Length)]; 
		else if (AmmoSwaps[AP.ReplacementsIndex].bIndependant)
			NewPickup = AmmoSwaps[AP.ReplacementsIndex].NewClasses[Rand(AmmoSwaps[AP.ReplacementsIndex].NewClasses.length)];
		else
			NewPickup = AmmoSwaps[AP.ReplacementsIndex].NewClasses[AmmoSwaps[AP.ReplacementsIndex].CurrentIndex];
	}
	else
		return;
	if (NewPickup == None || NewPickup == class'BallisticAmmoPickup')
		return;
	if (!SwapPickup(Other, NewPickup, ReplacementsIndex, true/*, P*/) && Other != None)
		Other.Destroy();
//	if (Other.IsInState('Sleeping'))
//		P.StartSleeping();
}

// Swap a pickup with one of a new class
function bool SwapPickup(Actor Other, class<Pickup> NewItem, int Index, optional bool bIsAmmo, optional out Pickup A)
{
	local Rotator ItemRot;
	local vector ItemLoc;
	local bool bOldCW;

	if (NewItem == None)
	{
		log("SwapPickup: NewItem is None!");
		return true;
	}

	// Figure out Alignment
	ItemRot = PickupAlign(Other, ItemLoc, NewItem);
	if (class<BallisticWeaponPickup>(NewItem) != None && class<BallisticWeaponPickup>(NewItem).default.bOnSide)
		ItemRot.Roll += 16384;

	// Spawn the new item
	bOldCW = NewItem.default.bCollideWorld;	// Turn off bCollideWorld before we spawn this pickup otherwise it
	NewItem.default.bCollideWorld = false;	// may not appear in maps where pickups have been placed inside geometry

	A = Spawn(NewItem,,,ItemLoc, ItemRot);
	if (A == None)
	{
		log("Couldn't spawn "$NewItem$" at "$Other);
		return true;
	}
	NewItem.default.bCollideWorld = bOldCW;;
	A.bCollideWorld = bOldCW;

	// Implement bright pickups
	if (bBrightPickups && level.NetMode == NM_StandAlone)
    	A.AmbientGlow = 128;
    // Set some stuff for Weapon and Ammo Pickups so they can change later
    if (BallisticWeaponPickup(A) != None)
    {
		if (bIsAmmo)
			BallisticWeaponPickup(A).OnItemChange = AmmoPickupChange;
		else
			BallisticWeaponPickup(A).OnItemChange = WeaponPickupChange;
		BallisticWeaponPickup(A).OnItemPickedUp = ItemPickedUp;
    	BallisticWeaponPickup(A).ReplacementsIndex = Index;
		//Pass respawn time onto this new pickup.
		if (BallisticWeaponPickup(Other) != None && BallisticWeaponPickup(Other).IsInState('Sleeping'))
		{
			BallisticWeaponPickup(A).PassedRespawnTime = BallisticWeaponPickup(Other).LatentFloat;
			BallisticWeaponPickup(A).GoToState('Sleeping');
		}
    }
	else if (BallisticAmmoPickup(A) != None)
    {
		BallisticAmmoPickup(A).OnItemChange = AmmoPickupChange;
		BallisticAmmoPickup(A).OnItemPickedUp = ItemPickedUp;
		BallisticAmmoPickup(A).ReplacementsIndex = Index;
    }

	// Settings for when old actor is a Pickup
	if (Pickup(Other) != None)
	{
		if (Pickup(Other).PickupBase != None && WildcardBase(Pickup(Other).PickupBase) != None)
			A.PickupBase = Pickup(Other).PickupBase;
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

// Spawn the default weapon replacements at default ammo pickups...
function SpawnBonusPickup(Pickup Other)
{
	local Vector S, V, HitLoc, HitNorm, E;
	local Actor T;
	local Rotator R;
	local class<Pickup> NewItem;
	local Pickup NewPickup;
	
	if (FRand() > 0.1)
		return;

	if (Swaps[1].bRandom)
		NewItem = Swaps[1].NewClasses[Rand(Swaps[1].NewClasses.length)].default.PickupClass;
	else
		NewItem = Swaps[1].NewClasses[Swaps[1].CurrentIndex].default.PickupClass;

	V = VRand()*128;
	V.Z = 0;
	S = Other.Location;
	S.Z += NewItem.default.CollisionHeight - Other.CollisionHeight;
	E.X = NewItem.default.CollisionRadius;
	E.Y = NewItem.default.CollisionRadius;
	E.Z = NewItem.default.CollisionHeight;

	T = Trace(HitLoc, HitNorm, S+V, S, false, E);
	if (T == None)
		HitLoc = S+V;

	R.Yaw = Rand(65536);
	NewPickup = Spawn(NewItem,,,HitLoc, R);
	if (BallisticWeaponPickup(NewPickup) != None)
	{
		BallisticWeaponPickup(NewPickup).OnItemChange = WeaponPickupChange;
		BallisticWeaponPickup(NewPickup).OnItemPickedUp = ItemPickedUp;
		BallisticWeaponPickup(NewPickup).ReplacementsIndex = 1;
	}
}

function AddStartingAmmo (Pawn Other)
{
	local Inventory Inv;

	for (Inv=Other.Inventory;Inv!=None;Inv=Inv.Inventory)
	{
		if (Weapon(Inv) != None)
		{
			SpawnAmmo(Weapon(Inv).default.FireModeClass[0].default.AmmoClass, Other);
			if (Weapon(Inv).default.FireModeClass[1].default.AmmoClass != None && Weapon(Inv).default.FireModeClass[0].default.AmmoClass != Weapon(Inv).default.FireModeClass[1].default.AmmoClass)
				SpawnAmmo(Weapon(Inv).default.FireModeClass[1].default.AmmoClass, Other);
		}
	}
}

// Check for item replacement.
function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local int i, j;

	bSuperRelevant = 0;

	if (xPawn(Other) != None)
	{
		for(i=0;i<NumWeapons;i++)
		{
			for (j=0;j<16;j++)
			{
				if (xPawn(Other).RequiredEquipment[j] != "" && xPawn(Other).RequiredEquipment[j] ~= string(Swaps[i].Old) && (!bLeaveSuper || !Swaps[i].bSuper))
				{
					if (bRandomDefaultWeapons || Swaps[i].bRandom)
						xPawn(Other).RequiredEquipment[j] = Swaps[i].NewClassNames[Rand(Swaps[i].NewClassNames.length)];
					else
						xPawn(Other).RequiredEquipment[j] = Swaps[i].NewClassNames[Swaps[i].CurrentIndex];
				}
			}
		}
		return true;
	}
	else if (Weapon(Other) != None)
	{
		for(i=0;i<NumWeapons;i++)
		{
			if (Weapon(Other).class == Swaps[i].Old && (!bLeaveSuper || !Swaps[i].bSuper))
			{
				if (Swaps[i].bRandom)
					SwapWeapon(Other, Swaps[i].NewClasses[Rand(Swaps[i].NewClasses.length)]);
				else
					SwapWeapon(Other, Swaps[i].NewClasses[Swaps[i].CurrentIndex]);
			}
		}
		return true;
	}

	// Replace Weapon base
	else if (xWeaponBase(Other) != None && xWeaponBase(Other).WeaponType != None)
	{
		for(i=0;i<NumWeapons;i++)
		{
			if (xWeaponBase(Other).WeaponType == Swaps[i].Old)
			{
				if (bLeaveSuper && Swaps[i].bSuper)
					return true;
				xWeaponBase(Other).WeaponType = None;
				xWeaponBase(Other).bHidden = True;
				if (Swaps[i].bRandom)
					return SwapPickup(Other, Swaps[i].NewClasses[Rand(Swaps[i].NewClasses.length)].default.PickupClass, i);
				else
					return SwapPickup(Other, Swaps[i].NewClasses[Swaps[i].CurrentIndex].default.PickupClass, i);
			}
		}
		if (bKillRogueWeaponPickups)
			return SwapPickup(Other, Swaps[Rand(NumWeapons)].NewClasses[Rand(Swaps[i].NewClasses.length)].default.PickupClass, i);
		return true;
	}

	else if (Ammo(Other) != None)
	{
		for(i=0;i<NumAmmos;i++)
		{
			if (Ammo(Other).InventoryType == AmmoSwaps[i].Old && AmmoSwaps[i].NewClasses.length > 0)
			{
				if(i == 0 || i == 13)
					SpawnBonusPickup(Ammo(Other));
				if (AmmoSwaps[i].bIndependant)
				{
					j = Rand(AmmoSwaps[i].NewClasses.length);
					if (AmmoSwaps[i].NewClasses[j] == None)
						for (j=0;j<AmmoSwaps[i].NewClasses.length;j++)
							if (AmmoSwaps[i].NewClasses[j] != None)
								break;
					if (AmmoSwaps[i].NewClasses[j] == None)
						return false;
					return SwapPickup(Other, AmmoSwaps[i].NewClasses[j], i, true);
				}
				else
				{
					j = AmmoSwaps[i].CurrentIndex;
					if (AmmoSwaps[i].NewClasses[j] == None)
						for (j=0;j<AmmoSwaps[i].NewClasses.length;j++)
							if (AmmoSwaps[i].NewClasses[j] != None)
								break;
					if (AmmoSwaps[i].NewClasses[j] == None)
						return false;
					return SwapPickup(Other, AmmoSwaps[i].NewClasses[j], i, true);
				}
			}
		}
		return true;
	}

	else if (WeaponPickup(Other) != None && Other.Owner == None && !WeaponPickup(Other).bDropped)
	{
		for(i=0;i<NumWeapons;i++)
		{
			if (WeaponPickup(Other).InventoryType == Swaps[i].Old)
			{
				if (bLeaveSuper && Swaps[i].bSuper)
					return true;
				if (Swaps[i].bRandom)
					return SwapPickup(Other, Swaps[i].NewClasses[Rand(Swaps[i].NewClasses.length)].default.PickupClass, i);
				else
					return SwapPickup(Other, Swaps[i].NewClasses[Swaps[i].CurrentIndex].default.PickupClass, i);
			}
		}
		return true;
	}

	return super.CheckReplacement(Other, bSuperRelevant);
}

function DoSomeShit()
{
	local int i, j;
	local BallisticWeaponPickup WP;
	local BallisticAmmoPickup AP;

	for(i=0;i<NumWeapons;i++)
		Swaps[i].CurrentIndex = Rand(Swaps[i].NewClassNames.length);
	for(i=0;i<NumAmmos;i++)
		for(j=0;j<NumWeapons;j++)
			if (Swaps[j].Old.default.FireModeClass[0].default.AmmoClass == AmmoSwaps[i].Old || Swaps[j].Old.default.FireModeClass[1].default.AmmoClass == AmmoSwaps[i].Old)
				AmmoSwaps[i].CurrentIndex = Swaps[j].CurrentIndex;

	foreach DynamicActors (class'BallisticWeaponPickup', WP)
		if (WP.ReplacementsIndex > -1)
			WP.ChangeTime = 0.1;
	foreach DynamicActors (class'BallisticAmmoPickup', AP)
		if (AP.ReplacementsIndex > -1)
			AP.ChangeTime = 0.1;
}

//BE: Added locker weapon swapping during the game.
//Azarael:
//Now works based on InventoryGroup, which is how I recommend the weapons to be laid out.
//Should you want to change this, feel free to make a weaponlocker subclass.
//Sets ammo based on the BW's Initial Ammo, not by trying to convert original weaponlocker ammo amounts
//since that requires knowledge to be saved of the original weaponlocker loadout, which isn't possible on a per-WL
//basis without a lot of faffing around and checkreplacing weaponlockers into a subclass for the purpose.

function SwapLockers()
{
	local int i, j, k;
	local WeaponLocker L;
	local LockerWeapon LW;
	local class<UTWeaponPickup> NP;
	local array<WeaponLocker> Lockers;

	if(!bLockersChange && bLockersSetup) // Az
		return;

	ForEach AllActors(class'WeaponLocker', L)
	{
		for (j=0;j<L.Weapons.Length;j++)
		{
				if(!bLockersSetup)
				{
					for (i=0; i < NumWeapons; i++)
					{
						//initial case, replacing default weapons
						if(L.Weapons[j].WeaponClass == GetInventoryFor(Swaps[i].Old))
						{
							L.Weapons[j].WeaponClass = Swaps[i].NewClasses[Rand(Swaps[i].NewClasses.length)];
							L.Weapons[j].ExtraAmmo = L.Weapons[j].WeaponClass.default.FireModeClass[0].default.AmmoClass.default.InitialAmount;
							break;
						}
					}
				}

				//currently uses inv.group instead of actual weapon as actual weapon can't be tracked properly
				//thus, will ignore avril, grenade, mines and anything else which shares a slot, using the rocket, flak and bio instead
				else
				{
					k = Max(0, L.Weapons[j].WeaponClass.default.InventoryGroup - 1);
					L.Weapons[j].WeaponClass = Swaps[k].NewClasses[Rand(Swaps[k].NewClasses.length)];
					L.Weapons[j].ExtraAmmo = L.Weapons[j].WeaponClass.default.FireModeClass[0].default.AmmoClass.default.InitialAmount;
				}
		}
		Lockers[Lockers.length] = L;
	}

	ForEach AllActors(class'LockerWeapon', LW)
	{
		for(i=0; i < Lockers.Length; i++)
		{
			if(Lockers[i].Location == LW.Location)
			{
				L = Lockers[i];
				break;
			}
		}
		if(L != None)
		{
			for (j=0;j<LW.Emitters.Length;j++)
			{
				if(j >= L.Weapons.Length)
					MeshEmitter(LW.Emitters[j]).Disabled=true;
				else
					MeshEmitter(LW.Emitters[j]).Disabled=false;
				
				if(j < L.Weapons.Length)
					NP = class<UTWeaponPickup>(GetPickupFor(L.Weapons[j].WeaponClass));

				if (NP != None && MeshEmitter(LW.Emitters[j]).StaticMesh != NP.default.StaticMesh)
				{
					if (class<BallisticWeaponPickup>(NP) != None)
						MeshEmitter(LW.Emitters[j]).StaticMesh = class<BallisticWeaponPickup>(NP).Default.LowPolyStaticMesh;
					else
						MeshEmitter(LW.Emitters[j]).StaticMesh = NP.Default.StaticMesh;
					MeshEmitter(LW.Emitters[j]).StartSpinRange.X.Min = NP.Default.Standup.X;
					MeshEmitter(LW.Emitters[j]).StartSpinRange.X.Max = NP.Default.Standup.X;
					MeshEmitter(LW.Emitters[j]).StartSpinRange.Y.Min = NP.Default.Standup.Y;
					MeshEmitter(LW.Emitters[j]).StartSpinRange.Y.Max = NP.Default.Standup.Y;
					MeshEmitter(LW.Emitters[j]).StartSpinRange.Z.Min = NP.Default.Standup.Z;
					MeshEmitter(LW.Emitters[j]).StartSpinRange.Z.Max = NP.Default.Standup.Z;
					MeshEmitter(LW.Emitters[j]).StartSizeRange.X.Min = 0.9 * NP.default.DrawScale;
					MeshEmitter(LW.Emitters[j]).StartSizeRange.X.Max = 0.9 * NP.default.DrawScale;
					MeshEmitter(LW.Emitters[j]).StartSizeRange.Y.Min = 0.9 * NP.default.DrawScale;
					MeshEmitter(LW.Emitters[j]).StartSizeRange.Y.Max = 0.9 * NP.default.DrawScale;
					MeshEmitter(LW.Emitters[j]).StartSizeRange.Z.Min = 0.9 * NP.default.DrawScale;
					MeshEmitter(LW.Emitters[j]).StartSizeRange.Z.Max = 0.9 * NP.default.DrawScale;
				}
			}
		}
	}
}

event Tick (float DT)
{
	super.Tick(DT);

	if (bPickupsChange && level.TimeSeconds >= PickupChangeTime)
	{
		DoSomeShit();
		PickupChangeTime = level.TimeSeconds + default.PickupChangeTime;
	}
	//Cheap method of getting initial swaps in after a short delay - Azarael
	if (!bLockersSetup && level.TimeSeconds > 5)
	{
		SwapLockers();
		bLockersSetup = True;
	}
	if (bLockersChange && level.TimeSeconds >= LockerChangeTime)
	{
		SwapLockers();
		LockerChangeTime = level.TimeSeconds + default.LockerChangeTime;
	}
}

defaultproperties
{
     Swaps(0)=(Old=Class'XWeapons.ShieldGun',NewClassNames=("BallisticProV55.X3Knife","BallisticProV55.A909SkrithBlades","BallisticProV55.EKS43Katana","BallisticProV55.X4Knife"))
     Swaps(1)=(Old=Class'XWeapons.AssaultRifle',NewClassNames=("BallisticProV55.M806Pistol","BallisticProV55.MRT6Shotgun","BallisticProV55.A42SkrithPistol","BallisticProV55.D49Revolver","BallisticProV55.AM67Pistol","BallisticProV55.RS8Pistol","BallisticProV55.GRS9Pistol","BallisticProV55.leMatRevolver","BallisticProV55.BOGPPistol","BallisticProV55.MD24Pistol"))
     Swaps(2)=(Old=Class'XWeapons.BioRifle',NewClassNames=("BallisticProV55.XK2SubMachinegun","BallisticProV55.Fifty9MachinePistol","BallisticProV55.XRS10SubmachineGun","BallisticProV55.XMK5SubMachinegun"))
     Swaps(3)=(Old=Class'XWeapons.ShockRifle',NewClassNames=("BallisticProV55.M50AssaultRifle","BallisticProV55.SARAssaultRifle","BallisticProV55.M46AssaultRifle"))
     Swaps(4)=(Old=Class'XWeapons.LinkGun',NewClassNames=("BallisticProV55.A73SkrithRifle","BallisticProV55.E23PlasmaRifle","BallisticProV55.RSDarkStar","BallisticProV55.RSNovaStaff"))
     Swaps(5)=(Old=Class'XWeapons.Minigun',NewClassNames=("BallisticProV55.M353Machinegun","BallisticProV55.M925Machinegun","BallisticProV55.XMV850Minigun"))
     Swaps(6)=(Old=Class'XWeapons.FlakCannon',NewClassNames=("BallisticProV55.M763Shotgun","BallisticProV55.M290Shotgun","BallisticProV55.MRS138Shotgun","BallisticProV55.A500Reptile"))
     Swaps(7)=(Old=Class'XWeapons.RocketLauncher',NewClassNames=("BallisticProV55.G5Bazooka","BallisticProV55.MACWeapon","BallisticProV55.MRocketLauncher"))
     Swaps(8)=(Old=Class'XWeapons.SniperRifle',NewClassNames=("BallisticProV55.R78Rifle","BallisticProV55.R9RangerRifle","BallisticProV55.M75Railgun","BallisticProV55.MarlinRifle","BallisticProV55.SRS900Rifle","BallisticProV55.M75Railgun"))
     Swaps(9)=(Old=Class'XWeapons.Painter',NewClassNames=("BallisticProV55.RX22AFlamer","BallisticProV55.HVCMk9LightningGun"),bSuper=True)
     Swaps(10)=(Old=Class'XWeapons.Redeemer',NewClassNames=("BallisticProV55.RX22AFlamer","BallisticProV55.HVCMk9LightningGun"),bSuper=True)
     Swaps(11)=(Old=Class'UTClassic.ClassicSniperRifle',NewClassNames=("BallisticProV55.R78Rifle","BallisticProV55.R9RangerRifle","BallisticProV55.M75Railgun","BallisticProV55.MarlinRifle","BallisticProV55.SRS900Rifle","BallisticProV55.M75Railgun"))
     Swaps(12)=(Old=Class'Onslaught.ONSAVRiL',NewClassNames=("BallisticProV55.G5Bazooka","BallisticProV55.MACWeapon"))
     Swaps(13)=(Old=Class'Onslaught.ONSGrenadeLauncher',NewClassNames=("BallisticProV55.NRP57Grenade"))
     Swaps(14)=(Old=Class'Onslaught.ONSMineLayer',NewClassNames=("BallisticProV55.BX5Mine"))
     Swaps(15)=(Old=Class'OnslaughtFull.ONSPainter',NewClassNames=("BallisticProV55.R78Rifle"),bSuper=True)
     Swaps(16)=(Old=Class'XWeapons.SuperShockRifle',NewClassNames=("BallisticProV55.HVCMk9LightningGun"),bSuper=True)
     AmmoSwaps(0)=(Old=Class'XWeapons.AssaultAmmo')
     AmmoSwaps(1)=(Old=Class'XWeapons.BioAmmo')
     AmmoSwaps(2)=(Old=Class'XWeapons.ShockAmmo')
     AmmoSwaps(3)=(Old=Class'XWeapons.LinkAmmo')
     AmmoSwaps(4)=(Old=Class'XWeapons.MinigunAmmo')
     AmmoSwaps(5)=(Old=Class'XWeapons.FlakAmmo')
     AmmoSwaps(6)=(Old=Class'XWeapons.RocketAmmo')
     AmmoSwaps(7)=(Old=Class'XWeapons.SniperAmmo')
     AmmoSwaps(8)=(Old=Class'UTClassic.ClassicSniperAmmo')
     AmmoSwaps(9)=(Old=Class'Onslaught.ONSAVRiLAmmo')
     AmmoSwaps(10)=(Old=Class'Onslaught.ONSGrenadeAmmo')
     AmmoSwaps(11)=(Old=Class'Onslaught.ONSGrenadeAmmo')
     AmmoSwaps(12)=(Old=Class'Onslaught.ONSMineAmmo')
     AmmoSwaps(13)=(Old=Class'XWeapons.GrenadeAmmo')
     NadeReplacePercent=15
     GrenadePickupClasses(0)=Class'BallisticProV55.FP7Pickup'
     GrenadePickupClasses(1)=Class'BallisticProV55.NRP57Pickup'
     GrenadePickupClasses(2)=Class'BallisticProV55.T10Pickup'
     GrenadePickupClasses(3)=Class'BallisticProV55.BX5Pickup'
     GrenadePickupClasses(4)=Class'BallisticProV55.FP9Pickup'
     PickupChangeTime=60.000000
     LockerChangeTime=90.000000
     bLockersChange=True
     FriendlyName="BallisticPro: Swap"
     Description="Applies Ballistic Weapons mod. Replaces the original weapons with the Ballistic weapons and implements all the new features and options including: reloading, recoil, inaccuracy, improved damage, iron sights, firing modes, new effects, new sounds, new items, altered player movement, etc... All options are accesible through the 'configure mutator' menu and the swapping lists can be used to change which weapons are spawned and how...||Pro changes: Support for variable walking and crouching speeds, run anims for walking, BX5 universal lights, and random replacement of standard ammo pickups with grenades.||http://www.runestorm.com"
}
