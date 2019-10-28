class WrenchPickup extends BallisticWeaponPickup
	placeable;

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Wrench.WrenchTex');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Wrench.ShieldGenerator_BLU');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Wrench.Teleport_BLU');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Wrench.Jumppad_BLU');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Wrench.Teleport_RED');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Wrench.Jumppad_RED');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Wrench.Unreal2_CrateTex');
	
	L.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.Wrench.AmmoCrate');
	L.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.Wrench.BoostPad');
	L.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.Wrench.EnergyWall');
	L.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.Wrench.ShieldGenCore');
	L.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.Wrench.ShieldOut2');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Wrench.WrenchTex');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Wrench.ShieldGenerator_BLU');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Wrench.Teleport_BLU');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Wrench.Jumppad_BLU');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Wrench.Teleport_RED');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Wrench.Jumppad_RED');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Wrench.Unreal2_CrateTex');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.Wrench.AmmoCrate');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.Wrench.BoostPad');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.Wrench.EnergyWall');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.Wrench.ShieldGenCore');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.Wrench.ShieldOut2');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPOtherPackStatic.Wrench.WrenchPickup'
     PickupDrawScale=0.750000
     InventoryType=Class'BWBPOtherPackPro.WrenchWarpDevice'
     RespawnTime=10.000000
     PickupMessage="You picked up the NFUD Combat Wrench."
     PickupSound=Sound'BallisticSounds2.Knife.KnifePutaway'
     StaticMesh=StaticMesh'BWBPOtherPackStatic.Wrench.WrenchPickup'
     Physics=PHYS_None
     DrawScale=0.750000
     CollisionHeight=4.000000
}
