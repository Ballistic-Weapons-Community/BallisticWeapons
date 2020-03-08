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
	local Freon_Player.AmmoTrack TrackInfo;

	Super(Mut_Ballistic).ModifyPlayer(Other);
	
	//ModifyPlayer isn't always called on spawn
	if (Other.LastStartTime > Level.TimeSeconds + 2)
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
				if( (InventoryClass!=None))
				{
					Size = GetItemSize(InventoryClass);
					if (SpaceUsed + Size > INVENTORY_SIZE_MAX)
						continue;
					xPawn(Other).RequiredEquipment[i] = CLRI.Loadout[i];
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
						SpaceUsed += Size;
						
						if (class<BallisticWeapon>(InventoryClass) != None)
							TrackInfo = Freon_Player(Other.Controller).GetAmmoTrackFor(class<BallisticWeapon>(InventoryClass));
						if (TrackInfo.GunClass != None && (TrackInfo.GunClass == InventoryClass || ClassIsChildOf(TrackInfo.GunClass, InventoryClass)))
						{
							BW = BallisticWeapon(Inv);
							BW.SetAmmoTo(TrackInfo.Ammo1, 0);
							if (BW.GetAmmoClass(0) != BW.GetAmmoClass(1) && BW.GetAmmoClass(1) != None)
								BW.SetAmmoTo(TrackInfo.Ammo2, 1);
						}
					}
				}
				else
				{
					xPawn(Other).RequiredEquipment[i] = "";
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
    if ( UnrealPawn(Other) != None )
        UnrealPawn(Other).AddDefaultInventory();

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

	for (Inv=Other.Inventory;Inv!=None;Inv=Inv.Inventory)
	{
		W = Weapon(Inv);
		if (W != None && BonusAmmo > 0)
		{
			SpawnAmmo(W.default.FireModeClass[0].default.AmmoClass, Other, BonusAmmo);
			if (W.default.FireModeClass[1] != None && W.default.FireModeClass[0].default.AmmoClass != W.default.FireModeClass[1].default.AmmoClass)
				SpawnAmmo(W.default.FireModeClass[1].default.AmmoClass, Other, BonusAmmo);
		}
	}
	for (i=0;i<CLRI.AppliedItems.length;i++)
		CLRI.AppliedItems[i].static.PostApply(Other);
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local LDGKillstreakLRI KLRI;
	
	local LinkedReplicationInfo LPRI;
	
	bSuperRelevant = 0;
		
	//shunt the lris down to make way for this one
	if (PlayerReplicationInfo(Other) != None)
	{
		KLRI = Spawn(class'LDGKillstreakLRI', Other.Owner);		
		
		if(PlayerReplicationInfo(Other).CustomReplicationInfo != None)
		{
			LPRI = PlayerReplicationInfo(Other).CustomReplicationInfo;
		
			PlayerReplicationInfo(Other).CustomReplicationInfo = KLRI;
			
			//this should be impossible?
			if (KLRI.NextReplicationInfo != None)
				KLRI.NextReplicationInfo.NextReplicationInfo = LPRI;
			else
				KLRI.NextReplicationInfo = LPRI;
		}
		else
			PlayerReplicationInfo(Other).CustomReplicationInfo = KLRI;
	}
	
	return super(Mut_Ballistic).CheckReplacement(Other, bSuperRelevant);
}

defaultproperties
{
}
