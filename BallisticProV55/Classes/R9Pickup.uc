//=============================================================================
// R9Pickup.
//=============================================================================
class R9Pickup extends BallisticWeaponPickup
	placeable;

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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.R9.USSRSkin');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.R9.USSRSkin');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.USSR.USSRPickup-Hi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.USSR.USSRPickup-Lo');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.USSR.USSRClips');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.USSR.USSRPickup-Lo'
     PickupDrawScale=0.240000
     InventoryType=Class'BallisticProV55.R9RangerRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the R9 ranger rifle."
     PickupSound=Sound'BW_Core_WeaponSound.R78.R78Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.USSR.USSRPickup-Hi'
     Physics=PHYS_None
     DrawScale=0.350000
     //Skins(0)=Shader'BWBP_OP_Tex.R9_body_SH1'
     CollisionHeight=3.000000
}
