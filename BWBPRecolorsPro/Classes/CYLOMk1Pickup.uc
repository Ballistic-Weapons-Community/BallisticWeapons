//=============================================================================
// CYLOMk1Pickup.
//=============================================================================
class CYLOMk1Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors3TexPro.utx
#exec OBJ LOAD FILE=BallisticRecolors4StaticPro.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.CYLO.UAW');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.CYLO.CYLOMag');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.CYLO.UAW');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.CYLO.CYLOMag');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.CYLO.CYLOPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.CYLO.CYLOPickupLow');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticPro.CYLO.CYLOPickupLow'
     InventoryType=Class'BWBPRecolorsPro.CYLOUAW'
     RespawnTime=20.000000
     PickupMessage="You picked up the CYLO urban assault weapon."
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.CYLO.CYLOPickupHi'
     Physics=PHYS_None
     CollisionHeight=4.000000
}
