//=============================================================================
// EKS43Pickup.
//=============================================================================
class JWJunkShieldPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BWBPSomeOtherPackTex.utx
#exec OBJ LOAD FILE=BWBPSomeOtherPackStatic.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBPSomeOtherPackTex.OtherShields.JWSignBack');
	Level.AddPrecacheMaterial(Texture'BWBPSomeOtherPackTex.OtherShields.JWSignFace');
	Level.AddPrecacheMaterial(Texture'BWBPSomeOtherPackTex.OtherShields.JW2x4');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPSomeOtherPackStatic.Shields.JWJunkShieldPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPSomeOtherPackStatic.Shields.JWJunkShieldPickup'
     StaticMesh=StaticMesh'BWBPSomeOtherPackStatic.Shields.JWJunkShieldPickup'	 
     InventoryType=Class'BWBPOtherPackPro.JWJunkShieldWeapon'
     RespawnTime=10.000000
     PickupMessage="You picked up a junk shield."
     PickupSound=Sound'BallisticSounds2.EKS43.EKS-Putaway'
     Physics=PHYS_None
     DrawScale=1.00000
     CollisionHeight=3.500000
	 bOnSide=False	 
}
