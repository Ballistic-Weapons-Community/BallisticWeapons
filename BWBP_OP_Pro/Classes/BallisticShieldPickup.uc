//=============================================================================
// EKS43Pickup.
//=============================================================================
class BallisticShieldPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BWBP_OP_Tex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BWBP_OP_Static.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Shader'BWBP_OP_Tex.BallisticShield.BallisticShieldShiny');
	Level.AddPrecacheMaterial(FinalBlend'BW_Core_WeaponTex.RiotShield.RiotShieldFinal');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Shields.BallisticShieldPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.Shields.BallisticShieldPickup'
     StaticMesh=StaticMesh'BWBP_OP_Static.Shields.BallisticShieldPickup'	 
     InventoryType=Class'BWBP_OP_Pro.BallisticShieldWeapon'
     RespawnTime=10.000000
     PickupMessage="You picked up a ballistic shield."
     PickupSound=Sound'BW_Core_WeaponSound.EKS43.EKS-Putaway'
     Physics=PHYS_None
     DrawScale=1.00000
     CollisionHeight=3.500000
	 bOnSide=False	 
}
