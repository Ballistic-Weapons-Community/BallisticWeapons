//=============================================================================
// M575Pickup.
//=============================================================================
class M575Pickup extends BallisticWeaponPickup
	placeable;

/*#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M353.M353_Skin1');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M353.M353_Skin2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M353.M353_Ammo');
	
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M353.M353MuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M353.M353_Skin1');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M353.M353_Skin2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M353.M353_Ammo');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M353.M353MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Ammo.MachinegunBox');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M353.M353PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M353.M353PickupLo');
}*/

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.M575.Pickup_M575'
     PickupDrawScale=0.10000
     StandUp=(Y=0.800000)
     InventoryType=Class'BWBPOtherPackPro.M575Machinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the M575 machinegun."
     PickupSound=Sound'BW_Core_WeaponSound.M353.M353-Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.M575.Pickup_M575'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=12.000000
	 CollisionRadius=52.000000
}
