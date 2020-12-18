class AP_CX85Mag extends BallisticAmmoPickup;

function inventory SpawnCopy( Pawn Other )
{
	local Inventory Copy, Copy2;

	InventoryType = Class'Ammo_CX85Darts';
	AmmoAmount = 6;
	Copy = Super.SpawnCopy(Other);
	AmmoAmount = default.AmmoAmount;
	InventoryType = default.InventoryType;

	Copy2 = Super.SpawnCopy(Other);
	Ammo_CX85Bullets(Copy2).Darts = Ammo_CX85Darts(Copy);
	Ammo_CX85Darts(Copy).Bullets = Ammo_CX85Bullets(Copy2);
	return Copy2;
}

defaultproperties
{
     AmmoAmount=90
     InventoryType=Class'BallisticProV55.Ammo_556mm'
     PickupMessage="You got two CX85 magazines."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBPOtherPackStatic3.CX85.CX85Ammo'
     DrawScale=0.800000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
