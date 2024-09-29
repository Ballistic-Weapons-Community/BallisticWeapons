//=============================================================================
// XRS10Pickup.
//=============================================================================
class XRS10Pickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
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
	L.AddPrecacheMaterial(Shader'BW_Core_WeaponTex.XRS10.XRS10Shiney');
	L.AddPrecacheMaterial(Shader'BW_Core_WeaponTex.XRS10.XRS10LaserShiney');
	L.AddPrecacheMaterial(Shader'BW_Core_WeaponTex.XRS10.XRS10SilencerShiney');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Shader'BW_Core_WeaponTex.XRS10.XRS10Shiney');
	Level.AddPrecacheMaterial(Shader'BW_Core_WeaponTex.XRS10.XRS10LaserShiney');
	Level.AddPrecacheMaterial(Shader'BW_Core_WeaponTex.XRS10.XRS10SilencerShiney');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.XRS10.XRS10Clips');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.XRS10.XRS10PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.XRS10.XRS10PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.XRS10.XRS10PickupLo'
     PickupDrawScale=0.190000
     InventoryType=Class'BallisticProV55.XRS10SubMachinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the XRS-10 machine pistol."
     PickupSound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.XRS10.XRS10PickupHi'
     Physics=PHYS_None
     DrawScale=0.220000
     PrePivot=(Y=-20.000000)
     CollisionHeight=4.000000
}
