//=============================================================================
// AK47Pickup.
//=============================================================================
class ProtonStreamPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_OP_Static.usx
#exec OBJ LOAD FILE=BWBP_OP_Tex.utx

simulated function UpdatePrecacheMaterials()
{

}
simulated function UpdatePrecacheStaticMeshes()
{

}

defaultproperties
{
     bOnSide=False
	 LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.ProtonPack.ProtonPackPickupLo'
     PickupDrawScale=0.750000
     InventoryType=Class'BWBP_OP_Pro.ProtonStreamer'
     RespawnTime=20.000000
     PickupMessage="You picked up the E90-N particle accelerator."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.ProtonPack.ProtonPackPickupHi'
     Physics=PHYS_None
     DrawScale=0.750000
     CollisionHeight=4.500000
}
