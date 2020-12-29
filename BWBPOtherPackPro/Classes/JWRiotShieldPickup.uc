//=============================================================================
// EKS43Pickup.
//=============================================================================
class JWRiotShieldPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BWBPSomeOtherPackTex.utx
#exec OBJ LOAD FILE=BallisticProTextures.utx
#exec OBJ LOAD FILE=BWBPSomeOtherPackStatic.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(FinalBlend'BallisticProTextures.Misc.RiotShieldFinal');
	Level.AddPrecacheMaterial(Texture'BWBPSomeOtherPackTex.OtherShields.JWTruncheon');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPSomeOtherPackStatic.Shields.JWRiotShieldPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPSomeOtherPackStatic.Shields.JWRiotShieldPickup'
     StaticMesh=StaticMesh'BWBPSomeOtherPackStatic.Shields.JWRiotShieldPickup'	 
     InventoryType=Class'BWBPOtherPackPro.JWRiotShieldWeapon'
     RespawnTime=10.000000
     PickupMessage="You picked up a civilion riot shield."
     PickupSound=Sound'BallisticSounds2.EKS43.EKS-Putaway'
     Physics=PHYS_None
     DrawScale=1.00000
     CollisionHeight=3.500000
	 bOnSide=False	 
}
