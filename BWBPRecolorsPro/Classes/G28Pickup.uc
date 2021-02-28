//=============================================================================
// T10Pickup.
//=============================================================================
class G28Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.G28.G28-Main');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.G28.G28Proj');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.G28.G28-Main');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.G28.G28Proj');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.G28.G28Pickup');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.G28.G28Pickup'
     PickupDrawScale=0.350000
     bWeaponStay=False
     InventoryType=Class'BWBPRecolorsPro.G28Grenade'
     RespawnTime=20.000000
     PickupMessage="You picked up G28 medicinal aerosol."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.G28.G28Pickup'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=5.600000
}
