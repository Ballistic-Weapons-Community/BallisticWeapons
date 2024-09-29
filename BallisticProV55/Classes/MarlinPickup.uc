//=============================================================================
// MarlinPickup.
//=============================================================================
class MarlinPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Marlin.Marlin_Ammo');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Marlin.Marlin_Main');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Marlin.Marlin_Shell');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Marlin.Marlin_Specmask');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Marlin.Marlin_Ammo');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Marlin.Marlin_Main');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Marlin.Marlin_Shell');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Marlin.Marlin_Specmask');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Marlin.Marlin-AmmoBox');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Marlin.Marlin-PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Marlin.Marlin-PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.Marlin.Marlin-PickupLo'
     PickupDrawScale=0.210000
     InventoryType=Class'BallisticProV55.MarlinRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the Redwood 6000 'DeerMaster'."
     PickupSound=Sound'BW_Core_WeaponSound.R78.R78Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Marlin.Marlin-PickupHi'
     Physics=PHYS_None
     DrawScale=0.170000
     CollisionHeight=3.000000
}
