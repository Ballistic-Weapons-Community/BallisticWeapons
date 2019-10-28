//=============================================================================
// R9Pickup.
//=============================================================================
class R9Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BallisticTextures3.Weapons.USSRSkin');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticTextures3.Weapons.USSRSkin');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware3.USSR.USSRPickup-Hi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware3.USSR.USSRPickup-Lo');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware3.USSR.USSRClips');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware3.USSR.USSRPickup-Lo'
     PickupDrawScale=0.240000
     InventoryType=Class'BallisticProV55.R9RangerRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the R9 ranger rifle."
     PickupSound=Sound'BallisticSounds2.R78.R78Putaway'
     StaticMesh=StaticMesh'BallisticHardware3.USSR.USSRPickup-Hi'
     Physics=PHYS_None
     DrawScale=0.350000
     Skins(0)=Shader'R9A_tex.R9_body_SH1'
     CollisionHeight=3.000000
}
