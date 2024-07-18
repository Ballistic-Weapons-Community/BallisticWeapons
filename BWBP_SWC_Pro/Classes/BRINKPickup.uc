class BRINKPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SWC_Static.BRINK.BRINKPickupLo'
     InventoryType=Class'BWBP_SWC_Pro.BRINKAssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the BR1-NK Mod-2 LSW."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SWC_Static.BRINK.BRINKPickupHi'
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=4.000000
}
