//=============================================================================
// EKS43Pickup.
//=============================================================================
class JWRiotShieldPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BWBP_OP_Tex.utx
#exec OBJ LOAD FILE=BallisticProTextures.utx
#exec OBJ LOAD FILE=BWBP_OP_Static.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(FinalBlend'BallisticProTextures.Misc.RiotShieldFinal');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.OtherShields.JWTruncheon');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Shields.JWRiotShieldPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.Shields.JWRiotShieldPickup'
     StaticMesh=StaticMesh'BWBP_OP_Static.Shields.JWRiotShieldPickup'	 
     InventoryType=Class'BWBPOtherPackPro.JWRiotShieldWeapon'
     RespawnTime=10.000000
     PickupMessage="You picked up a civilion riot shield."
     PickupSound=Sound'BW_Core_WeaponSound.EKS43.EKS-Putaway'
     Physics=PHYS_None
     DrawScale=1.00000
     CollisionHeight=3.500000
	 bOnSide=False	 
}
