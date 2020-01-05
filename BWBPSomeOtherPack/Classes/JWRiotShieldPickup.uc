//=============================================================================
// EKS43Pickup.
//=============================================================================
class JWRiotShieldPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx
#exec OBJ LOAD FILE=BallisticProStatic.usx
#exec OBJ LOAD FILE=BallisticProTextures.utx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.EKS43.Katana');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.EKS43.KatanaPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.EKS43.KatanaPickupLo');
}

defaultproperties
{
     PickupDrawScale=0.450000
     InventoryType=Class'BWBPSomeOtherPack.JWRiotShieldWeapon'
     RespawnTime=10.000000
     PickupMessage="You picked up a civilion riot shield."
     PickupSound=Sound'BallisticSounds2.EKS43.EKS-Putaway'
     Physics=PHYS_None
     DrawScale=0.700000
     CollisionHeight=4.000000
}
