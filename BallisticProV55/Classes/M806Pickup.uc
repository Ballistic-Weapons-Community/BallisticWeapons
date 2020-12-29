//=============================================================================
// M806Pickup.
//=============================================================================
class M806Pickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M806.M806_Main');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyPistolRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M806.PistolMuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Ammo.M806Clip');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.M806.M806PickupLo'
     PickupDrawScale=0.070000
     InventoryType=Class'BallisticProV55.M806Pistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the M806A2 pistol."
     PickupSound=Sound'BW_Core_WeaponSound.M806.M806Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.M806.M806PickupHi'
     Physics=PHYS_None
     DrawScale=0.120000
     CollisionHeight=4.000000
}
