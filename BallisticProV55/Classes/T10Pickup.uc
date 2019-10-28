//=============================================================================
// T10Pickup.
//=============================================================================
class T10Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.T10.T10GrenadeSkin');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.T10.T10GrenadeSkin');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.T10.T10Clip');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.T10.T10Projectile');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.T10.T10Pickup');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.T10.T10Pickup'
     PickupDrawScale=0.350000
     bWeaponStay=False
     InventoryType=Class'BallisticProV55.T10Grenade'
     RespawnTime=20.000000
     PickupMessage="You picked up the T10 toxic grenade."
     PickupSound=Sound'BallisticSounds2.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BallisticHardware2.T10.T10Pickup'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.700000
     CollisionHeight=5.600000
}
