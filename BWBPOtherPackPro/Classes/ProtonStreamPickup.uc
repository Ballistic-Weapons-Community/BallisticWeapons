//=============================================================================
// AK47Pickup.
//=============================================================================
class ProtonStreamPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBPOtherPackStatic.usx
#exec OBJ LOAD FILE=BWBPOtherPackTex2.utx
#exec OBJ LOAD FILE=R9A_tex.utx

simulated function UpdatePrecacheMaterials()
{

}
simulated function UpdatePrecacheStaticMeshes()
{

}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPOtherPackStatic.ProtonPack.proton_pack_static'
     PickupDrawScale=0.750000
     InventoryType=Class'BWBPOtherPackPro.ProtonStreamer'
     RespawnTime=20.000000
     PickupMessage="You picked up the E90-N particle accelerator."
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBPOtherPackStatic.ProtonPack.proton_pack_static'
     Physics=PHYS_None
     DrawScale=0.750000
     CollisionHeight=4.500000
}
