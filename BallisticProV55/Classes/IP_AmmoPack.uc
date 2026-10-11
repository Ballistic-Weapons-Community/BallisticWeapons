//=============================================================================
// IP_AmmoPack.
//
// Special ammo pack. Gives some ammo for each weapon in the inventory.
// Also gives players 5 health
//
// Packs will never resupply bWT_Trap or bWT_Super weaponry
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IP_AmmoPack extends BallisticAmmoPickup;

var() StaticMesh	LowPolyStaticMesh;	// Mesh for low poly stuff, like when its far away
var() float			LowPolyDist;		// How far must player be to use low poly mesh

function float DetourWeight(Pawn Other,float PathWeight)
{
	if ( Other.Weapon != None && Other.Weapon.AIRating >= 0.5 )
		return 0;

	return AmmoDesire(Other, true)/PathWeight;
}

function float BotDesireability(Pawn Bot)
{
	local float Desire;

	Desire = AmmoDesire(Bot, false);
	if ( Bot.Controller.bHuntPlayer )
		return Desire *= 0.25;
	return Desire * MaxDesireability;
}

// How much a bot wants this pack: what each of its weapons says about its ammo, as before, but only for what the pack
// will hand over (see Touch). Bots walked onto a pack and stood on it with nothing to get: the placeholder weapon of a
// bot with empty hands always asked for ammo, and so did weapons whose ammo packs never refill (mines, the flamer's gas,
// HVC cells, the MGL...). A weapon that was used up and comes back with the pack counts as an empty one
function float AmmoDesire(Pawn Other, bool bDetour)
{
	local Inventory Inv;
	local Weapon W;
	local BCGhostWeapon G;
	local float Desire;
	local int Count;

	for ( Inv=Other.Inventory; Inv!=None && Count < 1000; Inv=Inv.Inventory )
	{
		Count++;
		W = Weapon(Inv);
		G = BCGhostWeapon(Inv);
		if ( W != None )
		{
			if ( GivesAmmo(W.GetAmmoClass(0)) )
				Desire += FMax(-0.5, W.DesireAmmo(W.GetAmmoClass(0), bDetour));
		}
		else if ( G != None && RevivesGhost(G) && Other.FindInventoryType(G.MyWeaponClass) == None && GivesAmmo(GhostAmmoClass(G)) )
			Desire += 1.0;
	}
	return Desire;
}

// Ammo this pack hands out
function bool GivesAmmo(class<Ammunition> AC)
{
	if (AC == None || class<BallAmmo>(AC) != None)
		return false;
	return class<BallisticAmmo>(AC) == None || class<BallisticAmmo>(AC).static.ResuppliesFromPack();
}

function bool RevivesGhost(BCGhostWeapon G)
{
	return G.MyWeaponClass != None;
}

function class<Ammunition> GhostAmmoClass(BCGhostWeapon G)
{
	if (G.MyWeaponClass == None || G.MyWeaponClass.default.FireModeClass[0] == None)
		return None;
	return G.MyWeaponClass.default.FireModeClass[0].default.AmmoClass;
}

auto state Pickup
{
	function Touch( actor Other )
	{
		local Inventory Inv, GW;
		local int Count;
		local Weapon W;
		local bool bGetIt;

		local Ammunition A;

		if ( ValidTouch(Other) )
		{
			if ( Pawn(Other).GiveHealth(5, Pawn(Other).HealthMax) )
				bGetIt=true;
			// First go through our inventory and revive all the ghosts
			for (Inv=Pawn(Other).Inventory; Inv!=None && Count < 1000; Count++)
			{
				// If our grenades ran out, this should bring them back...
				if (BCGhostWeapon(Inv) != None)
				{
					GW = Inv;
					Inv = Inv.Inventory;
					BCGhostWeapon(GW).ReviveWeapon();
				}
				else
					Inv=Inv.Inventory;
			}
			Count = 0;
			// Now give all weapons some ammo
			for (Inv=Pawn(Other).Inventory; Inv!=None && Count < 1000; Inv=Inv.Inventory)
			{
				A = Ammunition(Inv);
				if (A!= None)
				{
					if (A.AmmoAmount < A.MaxAmmo && BallAmmo(A) == None && (BallisticAmmo(A) == None || BallisticAmmo(A).ResuppliesFromPack()))
					{
						if (A.InitialAmount != 0)
						{
							A.AddAmmo(A.InitialAmount);
							BGetIt=true;
						}
						else
						{
							//this is a fallback if InitialAmount is 0, eg. xmv-850 has no initial ammo
							//can't seem to access the weapon class from here to get a fraction of MagAmmo, but if there is a workaround feel free to change this
							A.AddAmmo(A.MaxAmmo/4);
							BGetIt=true;
						}
					}
				}
				else
				{
					W = Weapon(Inv);
					if (W != None && W.bNoAmmoInstances)
					{
						if ( !W.AmmoMaxed(0) && W.GetAmmoClass(0) != None)
						{
							W.AddAmmo(W.GetAmmoClass(0).default.InitialAmount, 0);
							BGetIt=true;
						}
						if ( W.GetAmmoClass(1) != None && W.GetAmmoClass(1) != W.GetAmmoClass(0) && (!W.AmmoMaxed(1)) )
						{
							BGetIt=true;
							W.AddAmmo(W.GetAmmoClass(1).default.InitialAmount, 1);
						}
					}
				}
				Count++;
			}
			// This pack provided something, so announce and make it go away
			if (bGetIt)
			{
            	AnnouncePickup(Pawn(Other));
            	SetRespawn();
            }
		}
	}
}

simulated event Tick(float DT)
{
	local PlayerController PC;

	super.Tick(DT);

	if (level.NetMode == NM_DedicatedServer)
		return;

	PC = Level.GetLocalPlayerController();
	if (PC==None)
		return;
	if (PC.ViewTarget != None)
	{
		if (VSize(Location - PC.ViewTarget.Location) > LowPolyDist * (90 / PC.FOVAngle))
		{
			if (StaticMesh != LowPolyStaticMesh)
				SetStaticMesh(LowPolyStaticMesh);
		}
		else if (StaticMesh != default.StaticMesh)
			SetStaticMesh(default.StaticMesh);
	}
	else if (VSize(Location - PC.Location) > LowPolyDist * (90 / PC.FOVAngle))
	{
		if (StaticMesh != LowPolyStaticMesh)
			SetStaticMesh(LowPolyStaticMesh);
	}
	else if (StaticMesh != default.StaticMesh)
		SetStaticMesh(default.StaticMesh);
}

defaultproperties
{
	LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.AmmoPackLo'
	LowPolyDist=500.000000
	MaxDesireability=0.700000
	PickupMessage="You picked up an ammo pack."
	PickupSound=Sound'BW_Core_WeaponSound.Ammo.AmmoPackPickup'
	PickupForce="HealthPack"
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.AmmoPackHi'
	DrawScale=0.350000
	PrePivot=(Z=10.000000)
	CollisionRadius=18.000000
	CollisionHeight=24.000000
}
