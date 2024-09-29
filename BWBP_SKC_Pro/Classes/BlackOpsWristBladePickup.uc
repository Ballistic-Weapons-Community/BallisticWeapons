//=============================================================================
// EKS43Pickup.
//=============================================================================
class BlackOpsWristBladePickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.BlkOpsBlade.BlkOpsBlade');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.X5W.X5WPickupHi');
     Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.X5W.X5WPickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.X5W.X5WPickupLo'
     PickupDrawScale=0.500000
     InventoryType=Class'BWBP_SKC_Pro.BlackOpsWristBlade'
     RespawnTime=10.000000
     PickupMessage="You picked up the X5W Black Ops Blade"
     PickupSound=Sound'BW_Core_WeaponSound.EKS43.EKS-Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.X5W.X5WPickupHi'
     Physics=PHYS_None
     DrawScale=0.600000
     CollisionHeight=4.000000
}
