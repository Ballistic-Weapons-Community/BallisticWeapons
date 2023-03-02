//=============================================================================
// EKS43Pickup.
//=============================================================================
class BlackOpsWristBladePickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_TexExp.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BWBP_SKC_StaticExp.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.BlkOpsBlade.BlkOpsBlade');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_StaticExp.X5W.X5W');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_StaticExp.X5W.X5W'
     PickupDrawScale=0.500000
     InventoryType=Class'BWBP_SKCExp_Pro.BlackOpsWristBlade'
     RespawnTime=10.000000
     PickupMessage="You picked up the X5W Black Ops Blade"
     PickupSound=Sound'BW_Core_WeaponSound.EKS43.EKS-Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.X5W.X5W'
     Physics=PHYS_None
     DrawScale=0.200000
     CollisionHeight=4.000000
}
