//=============================================================================
// A909Pickup.
//=============================================================================
class A909Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.A909.WristBladeSkin');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.A73BladeCut');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.A73BladeCutWood');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.A909.WristBladeSkin');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.A73BladeCut');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.A73BladeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A909.A909Hi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A909.A909Lo');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.A909.A909Lo'
     PickupDrawScale=0.300000
     InventoryType=Class'BallisticProV55.A909SkrithBlades'
     RespawnTime=10.000000
     PickupMessage="You picked up the A909 Skrith wrist blades."
     PickupSound=Sound'BW_Core_WeaponSound.A909.A909Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.A909.A909Hi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.350000
     CollisionHeight=4.000000
}
