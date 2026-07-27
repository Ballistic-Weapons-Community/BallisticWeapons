//=============================================================================
// Fifty9Pickup.
//=============================================================================
class Fifty9Pickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Fifty9.Fifty9Skin');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Fifty9.Fifty9Skin');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Ammo.XK2Clip');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Fifty9.Fifty9PickupLD');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Fifty9.Fifty9PickupHD');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.Fifty9.Fifty9PickupLD'
     PickupDrawScale=0.400000
     InventoryType=Class'BallisticProV55.Fifty9MachinePistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the Fifty-9 machine pistol."
     PickupSound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Fifty9.Fifty9PickupHD'
     Physics=PHYS_None
     DrawScale=0.380000
     CollisionHeight=4.000000
}