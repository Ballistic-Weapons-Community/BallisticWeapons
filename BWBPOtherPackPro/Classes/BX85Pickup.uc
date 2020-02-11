//=============================================================================
// CX61 pickup
//=============================================================================
class BX85Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBPOtherPackTex.utx
#exec OBJ LOAD FILE=BWBPOtherPackStatic.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex2.XBow.XBow_diff');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex2.XBow.XBow_spec');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex2.XBow.XBow_diff');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex2.XBow.XBow_spec');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.XBow.XBow_static');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPOtherPackStatic.XBow.XBow_static'
     InventoryType=Class'BWBPOtherPackPro.BX85Crossbow'
     RespawnTime=20.000000
     PickupMessage="You picked up the BX85 stealth crossbow."
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBPOtherPackStatic.XBow.XBow_static'
     Physics=PHYS_None
     DrawScale=0.250000
     CollisionHeight=4.000000
	 bOnSide=False
}
