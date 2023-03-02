//=============================================================================
// IP_AmmoPack.
//
// Special ammo pack. Gives some ammo for each weapon in the inventory.
// Also gives players 5 health
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IP_L8GIAmmoPack extends IP_AmmoPack;

//var() StaticMesh	LowPolyStaticMesh;	// Mesh for low poly stuff, like when its far away
//var() float			LowPolyDist;		// How far must player be to use low poly mesh

function float DetourWeight(Pawn Other,float PathWeight)
{
	local Inventory inv;
	local Weapon W;
	local float Desire;

	if ( Other.Weapon != None && Other.Weapon.AIRating >= 0.5 )
		return 0;

	for ( Inv=Other.Inventory; Inv!=None; Inv=Inv.Inventory )
	{
		W = Weapon(Inv);
		if ( W != None )
			Desire +=  FMax(-0.5, W.DesireAmmo(W.GetAmmoClass(0), true));
	}
	return Desire/PathWeight;
}

function float BotDesireability(Pawn Bot)
{
	local Inventory inv;
	local Weapon W;
	local float Desire;

	for ( Inv=Bot.Inventory; Inv!=None; Inv=Inv.Inventory )
	{
		W = Weapon(Inv);
		if ( W != None )
			Desire += FMax(-0.5, W.DesireAmmo(W.GetAmmoClass(0), false));
	}
	if ( Bot.Controller.bHuntPlayer )
		return Desire *= 0.25;
	return Desire * MaxDesireability;
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
			for (Inv=Pawn(Other).Inventory; Inv!=None && /*!Inv.IsA('L8GIAmmoPack') &&*/ Count < 1000; Count++)
			{
				if (!Inv.IsA('L8GIAmmoPack'))
				{
					// If our grenades ran out, this should bring them back...
					if (BCGhostWeapon(Inv) != None && BCGhostWeapon(Inv).MyWeaponClass != class'L8GIAmmoPack')
					{
						GW = Inv;
						Inv = Inv.Inventory;
						//log("In if statement - shouldn't have L8GIAmmoPack");
						//log("GhostWeapon is: "$GW);
						//log("Inv is: "$Inv);
						//log("MyWeaponsClass is: "$BCGhostWeapon(GW).MyWeaponClass);
						BCGhostWeapon(GW).ReviveWeapon();
					}
					else
						Inv=Inv.Inventory;
				}
			}
			Count = 0;
			// Now give all weapons some ammo
			for (Inv=Pawn(Other).Inventory; Inv!=None && /*!Inv.IsA('L8GIAmmoPack') &&*/ Count < 1000; Inv=Inv.Inventory)
			{
				A = Ammunition(Inv);
				if (A!= None && !A.IsA('Ammo_L8GI'))
				{
					if (A.AmmoAmount < A.MaxAmmo)
					{
						A.AddAmmo(A.InitialAmount);
						BGetIt=true;
					}
				}
				else
				{
					W = Weapon(Inv);
					//log(W);
					if (W != None &&  !W.IsA('L8GIAmmoPack')) 
					{
						if (W.bNoAmmoInstances)
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
     RespawnTime=0.000000
}
