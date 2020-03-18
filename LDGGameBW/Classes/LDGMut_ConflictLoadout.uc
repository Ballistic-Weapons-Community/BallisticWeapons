class LDGMut_ConflictLoadout extends Mut_ConflictLoadout
	HideDropDown
	CacheExempt;

//=================================================
// ModifyPlayer
// Outfits the player on spawn
//=================================================
function ModifyPlayer( pawn Other )
{
	local int i, Size, SpaceUsed;
	local float BonusAmmo;
	local Inventory Inv;
	local Weapon W;
	local BallisticWeapon BW;
	local class<Inventory> InventoryClass;
	local ConflictLoadoutLRI CLRI;
	local string s;
	local class<ConflictItem> itemclass;

	Super(Mut_Ballistic).ModifyPlayer(Other);
	
	//ModifyPlayer isn't always called on spawn
	if (Other.LastStartTime > Level.TimeSeconds + 1)
		return;

	CLRI = ConflictLoadoutLRI(GetBPRI(Other.PlayerReplicationInfo));
	
	if (CLRI == None)
		return;

	if (Other.PlayerReplicationInfo.bBot)
		EquipBot(Other);
	else
	{
		CLRI.Validate(CLRI.Loadout);
		if (CLRI.Loadout.length == 0)
		{
 			s = GetRandomWeapon(CLRI);
	 		if (s != "")
 				CLRI.Loadout[0] = s;
	 	}
	}

	CLRI.AppliedItems.length = 0;

	if ( xPawn(Other) != None )
	{
		for (i=0;i<Max(CLRI.Loadout.length,2);i++)
		{
			if (i >= CLRI.Loadout.length)
				xPawn(Other).RequiredEquipment[i] = "";
			else
			{
				InventoryClass = Level.Game.BaseMutator.GetInventoryClass(CLRI.Loadout[i]);

				if(InventoryClass != None)
				{
					Size = GetItemSize(InventoryClass);

					if (SpaceUsed + Size > INVENTORY_SIZE_MAX)
						continue;
				
					if (class<Weapon>(InventoryClass) != None)
						SpawnConflictWeapon(class<Weapon>(InventoryClass), Other);
					else 
						SpawnInventoryItem(InventoryClass, Other);

					SpaceUsed += Size;
				}

				else
				{
					itemclass = class<ConflictItem>(DynamicLoadObject(CLRI.Loadout[i],class'Class'));
					if (itemclass != None)
					{
						Size = itemclass.default.Size/5;
						if (SpaceUsed + Size > INVENTORY_SIZE_MAX)
							continue;
						CLRI.AppliedItems[CLRI.AppliedItems.length] = ItemClass;
						if (ItemClass.default.bBonusAmmo)
						{
							if (ItemClass.static.AddAmmoBonus(Other, BonusAmmo));
								SpaceUsed += Size;
						}
						else if (ItemClass.static.Applyitem(Other))
							SpaceUsed += Size;
					}
				}
			}
		}
	}

	if (SpaceUsed < INVENTORY_SIZE_MAX)
	{
		for (Inv=Other.Inventory;Inv!=None;Inv=Inv.Inventory)
			if (Weapon(Inv) != None)
				break;
		if (Inv == None)
		{
			s = GetRandomWeapon(CLRI);

			InventoryClass = Level.Game.BaseMutator.GetInventoryClass(s);
			if( (InventoryClass!=None))
			{
				Inv = Spawn(InventoryClass);
				if( Inv != None )
				{
					Inv.GiveTo(Other);
					if (Weapon(Inv) != None && Other.PendingWeapon == None && Other.Weapon == None)
					{
						Other.PendingWeapon = Weapon(Inv);
						Other.ChangedWeapon();
					}
					if ( Inv != None )
						Inv.PickupFunction(Other);
				}
			}
		}
	}

	for (Inv = Other.Inventory; Inv != None; Inv = Inv.Inventory)
	{
		W = Weapon(Inv);
		if (W != None && BonusAmmo > 0)
		{
			SpawnAmmo(W.default.FireModeClass[0].default.AmmoClass, Other, BonusAmmo);
			if (W.default.FireModeClass[1] != None && W.default.FireModeClass[0].default.AmmoClass != W.default.FireModeClass[1].default.AmmoClass)
				SpawnAmmo(W.default.FireModeClass[1].default.AmmoClass, Other, BonusAmmo);
		}
	}
		for (i = 0; i < CLRI.AppliedItems.length; i++)
		CLRI.AppliedItems[i].static.PostApply(Other);
}

function OnWeaponSpawned(Weapon W, Pawn Other)
{
	local BallisticWeapon BW;
	local Freon_Player.AmmoTrack TrackInfo;

	TrackInfo = Freon_Player(Other.Controller).GetAmmoTrackFor(W.Class);

	if (TrackInfo.GunClass == None || (TrackInfo.GunClass != W.Class && !ClassIsChildOf(TrackInfo.GunClass, W.Class)))
		return;

	BW = BallisticWeapon(W);
	BW.SetAmmoTo(TrackInfo.Ammo1, 0);
	if (BW.GetAmmoClass(0) != BW.GetAmmoClass(1) && BW.GetAmmoClass(1) != None)
		BW.SetAmmoTo(TrackInfo.Ammo2, 1);
}

function bool AllowExtraAmmo(Weapon W, Pawn Other)
{
	local Freon_Player.AmmoTrack TrackInfo;

	TrackInfo = Freon_Player(Other.Controller).GetAmmoTrackFor(W.Class);
	
	return (TrackInfo.GunClass == None || (TrackInfo.GunClass != W.Class && !ClassIsChildOf(TrackInfo.GunClass, W.Class)));
}

defaultproperties
{
}
