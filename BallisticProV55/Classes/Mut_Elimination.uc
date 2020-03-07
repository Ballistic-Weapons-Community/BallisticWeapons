// ====================================================================
// Mut_Elimination.
//
// Mut_Elimination
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
// ====================================================================
class Mut_Elimination extends Mutator
	HideDropDown
	CacheExempt;

struct Replacement
{
	var() class<Pickup>	OldItem;
	var() class<Pickup>	NewItem;
};
var() array<Replacement> Replacements;

struct PickupSwap
{
	var() Pickup Old;
	var() int	 NewIndex;
};
var   array<PickupSwap> PickupSwaps;				// Items to be swapped

var   Game_BWConflict	Conflict;

var   bool 					bSpawnedIA;		//Interaction has been spawnd for local player.


function PostBeginPlay()
{
	Conflict = Game_BWConflict(level.Game);
}

simulated function BeginPlay()
{
	local xPickupBase PB;
	local WeaponLocker W;

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
			W.GotoState('Disabled');
	}
	Super.BeginPlay();
}

simulated event Timer()
{
	local int i;

 	if (Role < ROLE_Authority)
 		return;

	for (i=0;i<PickupSwaps.Length;i++)
	{
		if (PickupSwaps[i].Old != None)
			if (!SpawnNewItem(PickupSwaps[i].NewIndex, PickupSwaps[i].Old))
				PickupSwaps[i].Old.Destroy();
	}
	PickupSwaps.Length = 0;
}

simulated event Tick(float DT)
{
	super.Tick(DT);

	if (level.NetMode != NM_DedicatedServer && !bSpawnedIA && level.GetLocalPlayerController() != None)
	{
		class'BallisticInteraction'.static.Launch (level.GetLocalPlayerController());
		bSpawnedIA=true;
	}
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

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local int i;
	local BallisticPlayerReplicationInfo BPRI;
	local LinkedReplicationInfo lPRI;

	//shunt the lris down to make way for this one
	if (PlayerReplicationInfo(Other) != None)
	{
		BPRI = Spawn(class'ConflictLoadoutLRI', Other.Owner);		
		
		if(PlayerReplicationInfo(Other).CustomReplicationInfo != None)
		{
			lPRI = PlayerReplicationInfo(Other).CustomReplicationInfo;
		
			PlayerReplicationInfo(Other).CustomReplicationInfo = BPRI;
			
			//this should be impossible?
			if (BPRI.NextReplicationInfo != None)
				BPRI.NextReplicationInfo.NextReplicationInfo = lPRI;
			else
				BPRI.NextReplicationInfo = lPRI;
		}
		else
			PlayerReplicationInfo(Other).CustomReplicationInfo = BPRI;
	}

	if (Conflict == None)
		return true;

	if (WeaponLocker(Other) != None)
	{
		Other.GotoState('Disabled');
		if (Conflict.bAmmoPacks)
			SpawnNewItem(-1, Other, class'IP_AmmoPack');
		return false;
	}
	else if (Other.IsA('Pickup'))
	{
		if (Other.IsA('AdrenalinePickup'))
        	return false;

		if (Other.IsA('WeaponPickup'))
		{
			if (!Conflict.bKeepWeapons)
				return !Level.bStartup;
		}
		else if (Other.IsA('Ammo'))
		{
			if (Conflict.bAmmoPacks && IP_AmmoPack(Other)!=None)
				return true;
			if (!Conflict.bKeepWeapons || Conflict.bAmmoPacks)
				return !Level.bStartup;
		}
		else
		{
			if (!Conflict.bKeepHealth && (Other.IsA('TournamentPickup') || Other.IsA('ArmorPickup')))
			{
				bSuperRelevant = 0;
				return false;
			}
			if (Conflict.bBallisticItems)
			{
				for (i=0;i<Replacements.length;i++)
					if (Pickup(Other).Class == Replacements[i].OldItem)
					{
						AddPickupSwap(Pickup(Other), i);
						return true;
					}
			}
		}
	}

	// Hide all weapon bases apart from super weapons
	if (Other.IsA('xPickupBase'))
	{
		if (Other.IsA('xWeaponBase'))
        {
			if (Conflict.bAmmoPacks)
			{
				Other.bHidden = true;
				if (!SpawnNewItem(-1, Other, class'IP_AmmoPack'))
					return false;
			}
			else if (!Conflict.bKeepWeapons)
				Other.bHidden = true;
        }
        else if (!Conflict.bKeepHealth || Conflict.bBallisticItems)
        {
			Other.bHidden = true;
			if (xPickupBase(Other).myEmitter != None)
				xPickupBase(Other).myEmitter.Destroy();
		}
	}
	bSuperRelevant = 0;
	return true;
}

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

function bool SpawnNewItem(int Index, Actor Other, optional class<Pickup> NewItem, optional out Pickup A)
{
	local Rotator ItemRot;
	local vector ItemLoc;

	// Get the new item class
	if (NewItem == None)
	{
		if (Index < 0)
			return true;
		NewItem = Replacements[Index].NewItem;
		if (NewItem == None)
		{
			log("Couldn't find new item for old "$Replacements[Index].OldItem$" in replacements list");
			return true;
		}
	}
	// Figure out Alignment
	ItemRot = PickupAlign(Other, ItemLoc, NewItem);
	if (class<BallisticWeaponPickup>(NewItem) != None && class<BallisticWeaponPickup>(NewItem).default.bOnSide)
		ItemRot.Roll += 16384;
	// Spawn the new item
	A = Spawn(NewItem,,,ItemLoc, ItemRot);
	if (A == None)
	{
//		log("Couldn't spawn "$NewItem$" at "$Other);
		return true;
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

defaultproperties
{
     Replacements(0)=(OldItem=Class'XPickups.HealthPack',NewItem=Class'BallisticProV55.IP_HealthKit')
     Replacements(1)=(OldItem=Class'XPickups.MiniHealthPack',NewItem=Class'BallisticProV55.IP_Bandage')
     Replacements(2)=(OldItem=Class'XPickups.AdrenalinePickup',NewItem=Class'BallisticProV55.IP_Adrenaline')
     Replacements(3)=(OldItem=Class'XPickups.UDamagePack',NewItem=Class'BallisticProV55.IP_UDamage')
     Replacements(4)=(OldItem=Class'XPickups.SuperHealthPack',NewItem=Class'BallisticProV55.IP_SuperHealthKit')
     Replacements(5)=(OldItem=Class'XPickups.SuperShieldPack',NewItem=Class'BallisticProV55.IP_BigArmor')
     Replacements(6)=(OldItem=Class'XPickups.ShieldPack',NewItem=Class'BallisticProV55.IP_SmallArmor')
     bNetTemporary=True
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
