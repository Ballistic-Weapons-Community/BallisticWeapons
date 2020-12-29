//=============================================================================
// M353Pickup.
//=============================================================================
class M353Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.M353.M353_Skin1');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.M353.M353_Skin2');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.M353.M353_Ammo');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M353.M353MuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.M353.M353_Skin1');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.M353.M353_Skin2');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.M353.M353_Ammo');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M353.M353MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Ammo.MachinegunBox');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M353.M353PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M353.M353PickupLo');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.M353.M353PickupLo'
     PickupDrawScale=0.750000
     StandUp=(Y=0.800000)
     InventoryType=Class'BallisticProV55.M353Machinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the M353 machinegun."
     PickupSound=Sound'BallisticSounds2.M353.M353-Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.M353.M353PickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.650000
     CollisionHeight=12.000000
}
