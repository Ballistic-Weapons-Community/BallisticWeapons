//=============================================================================
// G5Pickup.
//=============================================================================
class HydraPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_CC_Static.RL.Pickup_CruRL'
     PickupDrawScale=0.100000
     InventoryType=Class'BWBP_APC_Pro.HydraBazooka'
     RespawnTime=60.000000
     PickupMessage="You picked up the Hydra missile launcher."
     PickupSound=Sound'BW_Core_WeaponSound.G5.G5-Putaway'
     StaticMesh=StaticMesh'BWBP_CC_Static.RL.Pickup_CruRL'
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=6.000000
}
