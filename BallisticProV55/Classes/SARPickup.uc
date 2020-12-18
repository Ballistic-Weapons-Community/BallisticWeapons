//=============================================================================
// SARPickup.
//=============================================================================
class SARPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticTextures3.utx
#exec OBJ LOAD FILE=BallisticHardware3.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticTextures3.Weapons.SARSkin');
}
simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticTextures3.Weapons.SARSkin');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware3.SAR.SARClips');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware3.SAR.SARPickup-Hi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware3.SAR.SARPickup-Lo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware3.SAR.SARPickup-Lo'
     PickupDrawScale=0.140000
     InventoryType=Class'BallisticProV55.SARAssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the Sub-Assault Rifle 12."
     PickupSound=Sound'BallisticSounds2.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BallisticHardware3.SAR.SARPickup-Hi'
     Physics=PHYS_None
     DrawScale=0.220000
     CollisionHeight=4.000000
}
