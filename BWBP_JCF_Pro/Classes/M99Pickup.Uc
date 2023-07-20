//=============================================================================
// R78Pickup.
//=============================================================================
class M99Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_JCF_Static.M99.M99_Pickup'
     PickupDrawScale=0.500000
     InventoryType=Class'BWBP_JCF_Pro.M99Rifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the M99-ECS Anti Material Rifle"
     PickupSound=Sound'BW_Core_WeaponSound.R78.R78Putaway'
     StaticMesh=StaticMesh'BWBP_JCF_Static.M99.M99_Pickup'
     Physics=PHYS_None
     DrawScale=0.500000
     CollisionHeight=3.000000
}
