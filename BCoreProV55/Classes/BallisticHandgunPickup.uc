//=============================================================================
// BallisticHandgunPickup.
//=============================================================================
class BallisticHandgunPickup extends BallisticWeaponPickup
	placeable;


function inventory SpawnCopy( pawn Other )
{
	local inventory Copy, Inv;
	local Weapon W;
	local int Count;
	local bool bHasTwoAlready;

	if (!bDropped)
		OnItemPickedUp(self);

	for(Inv=Other.Inventory; Inv!=None && Count<1000; Inv=Inv.Inventory)
	{
		if (Inv.class == InventoryType)
		{
			if (W == None)
				W = Weapon(Inv);
			else
			{
				bHasTwoAlready = true;
				break;
			}
		}
		Count++;
	}

	if (bHasTwoAlready && W != None)
	{
		GiveWeaponAmmo(W, Other);
		return None;
	}

	if ( Inventory != None )
	{
		Copy = Inventory;
		Inventory = None;
	}
	else
		Copy = spawn(InventoryType,Other,,,rot(0,0,0));

	Copy.GiveTo( Other, self );

	return Copy;
}

defaultproperties
{
}
