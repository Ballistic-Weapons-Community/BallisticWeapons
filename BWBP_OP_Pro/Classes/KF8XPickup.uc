//=============================================================================
// CX61 pickup
//=============================================================================
class KF8XPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_OP_Tex.utx
#exec OBJ LOAD FILE=BWBP_OP_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XBow.XBow_diff');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XBow.XBow_spec');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XBow.XBow_diff');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XBow.XBow_spec');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.XBow.XBow_static');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.XBow.XBow_static'
     InventoryType=Class'BWBP_OP_Pro.KF8XCrossbow'
     RespawnTime=20.000000
     PickupMessage="You picked up the KF8X stealth crossbow."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.XBow.XBow_static'
     Physics=PHYS_None
     DrawScale=0.250000
     CollisionHeight=4.000000
	 bOnSide=False
}
