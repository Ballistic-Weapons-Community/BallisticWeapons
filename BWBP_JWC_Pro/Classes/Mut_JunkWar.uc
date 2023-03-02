//=============================================================================
// Mut_BWBP_JWC_Pro.
//
// This mutator spawns JunkWeaponPickups in the arena. It uses info from the
// JunkObject classes for some pickup settings and initialization.
//
// Junk is spawned at navigationpoints
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Mut_JunkWar extends Mutator config(BWBP_JWC_Pro);

var() globalconfig int		NumJunks;
var() globalconfig int		NumShields;
var() globalconfig int		NumStartJunks;
var() globalconfig bool		bNoOtherWeapons;
var() globalconfig bool		bKeepTranslocators;
var() int					TotalJunks;
var() int					TotalShields;

struct JunkListEntry
{
	var class<JunkObject>	JunkClass;
	var int					Count;
};
var   array<JunkListEntry>	JunkList;
struct ShieldListEntry
{
	var class<JunkShield>	ShieldClass;
	var int					Count;
};
var   array<ShieldListEntry>	ShieldList;

replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		bNoOtherWeapons;
}

simulated function PostNetBeginPlay()
{
	local xPickupBase P;
	local Pickup L;

	if (bNoOtherWeapons)
	{
		foreach AllActors(class'xPickupBase', P)
		{
			if (xWeaponBase(P) == None)
				continue;
			xWeaponBase(P).WeaponType = None;
			xWeaponBase(P).PowerUp = None;
			P.bHidden = true;
			if (P.myEmitter != None)
				P.myEmitter.Destroy();
		}
		foreach AllActors(class'Pickup', L)
			if ( L.IsA('WeaponLocker') )
				L.GotoState('Disabled');
	}
	Super.PostNetBeginPlay();
}

function PostBeginPlay()
{
	local int i, j;
	local class<JunkObject> JC;
	local class<JunkShield> JSC;
	local array<string>	JunkNameList;

	if (level.NetMode == NM_Client)
		return;

	if (bNoOtherWeapons)
		DefaultWeaponName = "BWBP_JWC_Pro.JunkWeapon";

	GetAllInt("JunkObject", JunkNameList);
	for(i=0;i<JunkNameList.length;i++)
	{
		JC = class<JunkObject>(DynamicLoadObject(JunkNameList[i], class'Class'));
		if (JC == None || !JC.default.bListed)
		{
			JunkNameList.Remove(i,1);
			i--;
		}
		else
		{
			for (j=0;j<JunkList.Length;j++)
				if (JunkList[j].JunkClass.default.MeleeRating + JunkList[j].JunkClass.default.RangeRating > JC.default.MeleeRating + JC.default.RangeRating)
					break;
			JunkList.Insert(j, 1);
			JunkList[j].JunkClass = JC;
		}

	}

	if (NumStartJunks < 1 || NumStartJunks > JunkList.length)
		NumStartJunks = JunkList.length;

	GetAllInt("JunkShield", JunkNameList);
	for(i=0;i<JunkNameList.length;i++)
	{
		JSC = class<JunkShield>(DynamicLoadObject(JunkNameList[i], class'Class'));
		if (JSC == None || !JSC.default.bListed)
		{
			JunkNameList.Remove(i,1);
			i--;
		}
		else
		{
			ShieldList.length = i+1;
			ShieldList[i].ShieldClass = JSC;
		}

	}
	UpdateJunkPickups();
}

function UpdateJunkPickups ()
{
	local int i;

	if (NumJunks > TotalJunks)
		for (i=NumJunks-TotalJunks;i>0;i--)
			AddJunk();
	if (NumShields > TotalShields)
		for (i=NumShields-TotalShields;i>0;i--)
			AddShield();
}

function AddJunk ()
{
	local NavigationPoint Best;//, Next;
	local int Index;//, i;
	local vector SpawnLoc;

	Best = GetBestPoint();
	if (Best == None)
		return;
	SpawnLoc = Best.Location;
/*	for (i=0;i<Best.PathList.length;i++)
	{
		Next = Best.PathList[i].End;
		if (Next != None && FastTrace(Next.Location, Best.location))
		{
			SpawnLoc = Best.Location + (Next.Location - Best.Location) * FRand();
			Best = Next;
			break;
		}
	}
*/
/*	Next = Best.PathList[Rand(Best.PathList.length)].End;
	if (Next != None && FastTrace(Next.Location, Best.location))
	{
		Best = Next;
		SpawnLoc = Best.Location + (Next.Location - Best.Location) * FRand();
	}
	else
		SpawnLoc = Best.Location;
*/	Index = GetBestJunk();
	if (Index > -1 && Index < JunkList.length)
	{
		if (InventorySpot(Best) != None && FastTrace(SpawnLoc + vect(0,0,96), SpawnLoc))
			SpawnLoc += vect(0,0,92);
		else if (PathNode(Best) != None && FastTrace(SpawnLoc + vect(0,0,64), SpawnLoc))
			SpawnLoc += vect(0,0,60);
		PutJunkHere (SpawnLoc, JunkList[Index].JunkClass, Index);
	}
}

function AddShield ()
{
	local NavigationPoint Best;
	local int Index;
	local vector NodeLoc;

	Index = GetBestShield();
	if (Index < 0)
		return;
	Best = GetBestPoint();
	if (Best != None && Index > -1 && Index < ShieldList.length)
	{
		NodeLoc = Best.Location;
		if (InventorySpot(Best) != None && FastTrace(NodeLoc + vect(0,0,128), NodeLoc))
			NodeLoc += vect(0,0,124);
		else if (PathNode(Best) != None && FastTrace(NodeLoc + vect(0,0,96), NodeLoc))
			NodeLoc += vect(0,0,92);
		PutShieldHere (NodeLoc, ShieldList[Index].ShieldClass.default.PickupClass, Index);
	}
}

function NavigationPoint GetBestPoint()
{
	local NavigationPoint N, Best;
	local int BestRank, Rank;

	BestRank = -100000;
	for ( N=Level.NavigationPointList; N!=None; N=N.NextNavigationPoint )
	{
		Rank = 80000 + Rand(20000);
		if (N.base == None)
			Rank -= 50000;
		else if (Mover(N.Base) != None)
			Rank-=50000;
		if (N.PlayerCanSeeMe())
			Rank-=60000;
		if (InventorySpot(N) != None)
			Rank-=12000;
		else if (PlayerStart(N) != None)
			Rank-=10000;
		else if (LiftCenter(N) != None)
			Rank-=30000;
		else if (LiftExit(N) != None)
			Rank-=15000;
		else if (FlyingPathNode(N) != None)
			Rank-=150000;
		else if (RoadPathNode(N) != None)
			Rank-=15000;
		if (Rank > BestRank)
		{
			BestRank = Rank;
			Best = N;
		}
	}
	return Best;
}

function int GetBestShield()
{
	local int i, LowestCount;
	local Array<int> LowJunkList;

	LowestCount = 999999;
	for(i=0;i<ShieldList.length;i++)
	{
		if (ShieldList[i].Count < LowestCount)
		{
			LowJunkList.length = 1;
			LowJunkList[0] = i;
			LowestCount = ShieldList[i].Count;
		}
		else if (ShieldList[i].Count == LowestCount)
			LowJunkList[LowJunkList.length] = i;
	}
	return LowJunkList[Rand(LowJunkList.length)];
}

function int GetBestJunk()
{
	local int i;
	local Array<float> Blocks;
	local float	Total, Index;

	for(i=0;i<JunkList.length;i++)
	{
		Blocks[i] = JunkList[i].JunkClass.default.SpawnWeight / (JunkList[i].Count+1);
		Total += Blocks[i];
	}
	Index = FRand() * Total;
	Total = 0;
	for (i=0;i<Blocks.length;i++)
		if (Index <= Total + Blocks[i])
			return i;
		else
			Total += Blocks[i];
	return Rand(JunkList.length);

/*
	local int i;
	local float HighestValue, CurrentValue;
	local Array<int> BestJunkList;

	HighestValue = -999999;
	for(i=0;i<JunkList.length;i++)
	{
		CurrentValue = JunkList[i].JunkClass.default.SpawnWeight / (JunkList[i].Count+1);
		if (CurrentValue > HighestValue)
		{
			BestJunkList.length = 1;
			BestJunkList[0] = i;
			HighestValue = CurrentValue;
		}
		else if (CurrentValue == HighestValue)
			BestJunkList[BestJunkList.length] = i;
	}
	return BestJunkList[Rand(BestJunkList.length)];
*/}

function FindRandomLocation (vector InLoc, out vector OutLoc, out vector OutNorm)
{
	local Vector RandLoc, Extent, SavedLoc, SavedNorm;
	local Actor T;
	local int i;

	SavedNorm.Z = -1;
//	Extent = vect(1,1,0) * class'JunkWeaponPickup'.default.CollisionRadius + vect(0,0,1) * class'JunkWeaponPickup'.default.CollisionHeight;
	Extent = vect(6,6,6);
	for (i=0;i<4;i++)
	{
		if (i < 3)
			RandLoc = VRand() * 384;
		RandLoc.Z = -384;
//		RandLoc.Z = -256;
		RandLoc += InLoc;
		T = Trace(OutLoc, OutNorm, RandLoc, InLoc, false, Extent);
		if (T == None || OutNorm.Z < 0.0)
			continue;
		else if (OutNorm.Z < 0.5 && OutNorm.Z > SavedNorm.Z)
		{
			if (Terraininfo(T) != None)
				OutLoc+=OutNorm*6;
			SavedLoc = OutLoc;
			SavedNorm = OutNorm;
			continue;
		}
//		if (T == None || OutNorm.Z < 0.0)
//			continue;
		if (Terraininfo(T) != None)
			OutLoc+=OutNorm*6;
		return;
	}
	if (SavedLoc != vect(0,0,0))
	{
		OutLoc = SavedLoc;
		OutNorm = SavedNorm;
	}
	else
	{
		OutLoc = InLoc;
		OutNorm = vect(0,0,1);
	}
}

function PutJunkHere (vector NodeLoc, class<JunkObject> JunkClass, int Index)
{
	local Vector HitLoc, HitNorm;

	FindRandomLocation(NodeLoc, HitLoc, HitNorm);
	SpawnJunk(HitLoc, HitNorm, JunkClass, Index);
}
function SpawnJunk (vector SpawnLoc, vector SpawnNorm, class<JunkObject> JunkClass, int JunkIndex)
{
	local Rotator Dir, R;
	local Vector X, Y, Z;
	local JunkWeaponPickup JP;

	Dir = Rotator(SpawnNorm)-rot(16384,0,0);

	R.Yaw = Rand(65536);
	GetAxes (R,X,Y,Z);
	SpawnLoc += class'BUtil'.static.AlignedOffset(OrthoRotation (X>>Dir, Y>>Dir, Z>>Dir), JunkClass.Default.SpawnOffset);

	R.Pitch = JunkClass.default.SpawnPivot.Pitch;
	R.Roll  = JunkClass.default.SpawnPivot.Roll;
	GetAxes (R,X,Y,Z);
	Dir = OrthoRotation (X>>Dir, Y>>Dir, Z>>Dir);

	JP = Spawn(class'JunkWeaponPickup',,, SpawnLoc, Dir);
	if (JP == None)
	{
//		log("Failed to spawn JunkWeaponPickup for "$JunkClass.default.FriendlyName,'Warning');
		return;
	}
	TotalJunks++;
	JP.SetJunkClass(JunkClass);
	JP.OnItemRespawn = ItemRespawned;
	if (JunkIndex >= 0 && JunkIndex < JunkList.length)
		JunkList[JunkIndex].Count++;
}

function PutShieldHere (vector NodeLoc, class<Pickup> ShieldPickupClass, int Index)
{
	local Vector HitLoc, HitNorm;

	FindRandomLocation(NodeLoc, HitLoc, HitNorm);
	SpawnShield(HitLoc, HitNorm, ShieldPickupClass, Index);
}
function SpawnShield (vector SpawnLoc, vector SpawnNorm, class<Pickup> PC, int Index)
{
	local Rotator Dir, R;
	local Vector X, Y, Z;
	local Pickup JSP;

	Dir = Rotator(SpawnNorm)-rot(16384,0,0);

	if (class<JunkShieldPickup>(PC) != None)
	{
		R.Yaw = Rand(65536);
		GetAxes (R,X,Y,Z);
		SpawnLoc += class'BUtil'.static.AlignedOffset(OrthoRotation (X>>Dir, Y>>Dir, Z>>Dir), class<JunkShieldPickup>(PC).Default.SpawnOffset);

		R.Pitch = class<JunkShieldPickup>(PC).default.SpawnPivot.Pitch;
		R.Roll  = class<JunkShieldPickup>(PC).default.SpawnPivot.Roll;
		GetAxes (R,X,Y,Z);
		Dir = OrthoRotation (X>>Dir, Y>>Dir, Z>>Dir);
	}
	JSP = Spawn(PC,,, SpawnLoc, Dir);
	if (JunkShieldPickup(JSP) == None)
	{
//		log("Failed to spawn JunkShieldPickup for "$PC.default.InventoryType.default.ItemName,'Warning');
		return;
	}
	TotalShields++;
	JunkShieldPickup(JSP).OnItemRespawn = ItemRespawned;
	if (Index >= 0 && Index < ShieldList.length)
		ShieldList[Index].Count++;
}

function ItemRespawned (Pickup Pickup)
{
	local int i;
	if (JunkWeaponPickup(Pickup) != None)
	{
		for (i=0;i<JunkList.length;i++)
			if (JunkList[i].JunkClass == JunkWeaponPickup(Pickup).JunkClass)
			{	JunkList[i].Count--;	break;	}
		Pickup.Destroy();
		TotalJunks--;
		UpdateJunkPickups();
	}
	if (JunkShieldPickup(Pickup) != None)
	{
		for (i=0;i<JunkList.length;i++)
			if (ShieldList[i].ShieldClass == JunkShieldPickup(Pickup).InventoryType)
			{	ShieldList[i].Count--;	break;	}
		Pickup.Destroy();
		TotalShields--;
		UpdateJunkPickups();
	}
}

function ModifyPlayer(Pawn Other)
{
	local Inventory Inv;
	local JunkObject JO;

	for (Inv=Other.Inventory;Inv!=None;Inv=Inv.Inventory)
	{
		if (JunkWeapon(Inv) != None)
		{
			if (JunkWeapon(Inv).JunkChain == None)
			{
				JO = JunkWeapon(Inv).GiveJunk(JunkList[Rand(NumStartJunks)].JunkClass );
//				JunkWeapon(Inv).SwitchJunk(JO, false);
			}
			JunkWeapon(Inv).bCanThrow = JunkWeapon(Inv).default.bCanThrow;
		}
	}
	Super.ModifyPlayer(Other);
}

// Check for item replacement.
function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	bSuperRelevant = 0;

	if (bNoOtherWeapons)
	{
		if (xPawn(Other) != None)
		{
			xPawn(Other).RequiredEquipment[0] = "BWBP_JWC_Pro.JunkWeapon";
			xPawn(Other).RequiredEquipment[1] = "";
		}
		else if (Weapon(Other) != None)
		{
			if (JunkWeapon(Other) != None || Other.IsA('BallLauncher') || (bKeepTranslocators && Other.IsA('Translauncher')))
				return true;
			return false;
		}
		else if (Ammo(Other) != None)
		{
			if ( Other.bStatic || Other.bNoDelete )
				Other.GotoState('Disabled');
//			Ammo(Other).RemoveFromNavigation();
//			Ammo(Other).myMarker.Destroy();
			return false;
		}
		else if (xWeaponBase(Other) != None && xWeaponBase(Other).WeaponType != class'JunkWeapon')
		{
			xWeaponBase(Other).WeaponType = None;
			xPickupBase(Other).PowerUp = None;
//			xPickupBase(Other).myMarker.Destroy();;
			Other.bHidden = true;
		}
		// Change weapons in weaponlockers
		else if (WeaponLocker(Other) != None)
		{
			Other.GotoState('Disabled');
			return false;
		}
		else if (WeaponPickup(Other) != None && JunkWeaponPickup(Other) == None && Other.Owner == None)
			return false;
	}
	return true;
}

defaultproperties
{
     NumJunks=20
     NumShields=10
     bNoOtherWeapons=True
     ConfigMenuClassName="BWBP_JWC_Pro.JunkWarConfigMenu"
     FriendlyName="Ballistic Weapons: Junk Wars"
     Description="Battle it out with whatever you can get your hands on! All manner of junk is dotted around the arena, everything from rusted old pipes, crowbars and spanners to ice picks, tazers and empty beer bottles, it can all be used as a weapon... ||http://www.runestorm.com"
     bNetTemporary=True
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
