//=============================================================================
// EKS43Pickup.
//=============================================================================
class BallisticShieldPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BWBPSomeOtherPackTex.utx
#exec OBJ LOAD FILE=BallisticProTextures.utx
#exec OBJ LOAD FILE=BWBPSomeOtherPackStatic.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Shader'BWBPSomeOtherPackTex.BallisticShield.BallisticShieldShiny');
	Level.AddPrecacheMaterial(FinalBlend'BallisticProTextures.Misc.RiotShieldFinal');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPSomeOtherPackStatic.Shields.BallisticShieldPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPSomeOtherPackStatic.Shields.BallisticShieldPickup'
     StaticMesh=StaticMesh'BWBPSomeOtherPackStatic.Shields.BallisticShieldPickup'	 
     InventoryType=Class'BWBPOtherPackPro.BallisticShieldWeapon'
     RespawnTime=10.000000
     PickupMessage="You picked up a ballistic shield."
     PickupSound=Sound'BallisticSounds2.EKS43.EKS-Putaway'
     Physics=PHYS_None
     DrawScale=1.00000
     CollisionHeight=3.500000
	 bOnSide=False	 
}
