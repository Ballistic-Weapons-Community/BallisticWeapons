//=============================================================================
// SK410Pickup.
//=============================================================================
class RCS715Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BWBP_OP_Tex.utx

#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx
#exec OBJ LOAD FILE=BWBP_OP_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Shader'BWBP_OP_Tex.AssaultShotgun.TacBusterShiny');
	L.AddPrecacheMaterial(Shader'BWBP_OP_Tex.AssaultShotgun.BusterGrenadeShiny');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CoachGun.DBL-Misc');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CYLO.Reflex');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Concrete');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Metal');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Wood');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.M763Bash');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.M763BashWood');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M763.M763MuzzleFlash');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M763.M763Flash1');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Shader'BWBP_OP_Tex.AssaultShotgun.TacBusterShiny');
	Level.AddPrecacheMaterial(Shader'BWBP_OP_Tex.AssaultShotgun.BusterGrenadeShiny');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CoachGun.DBL-Misc');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CYLO.Reflex');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.SK410.SK410-Misc');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Concrete');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Metal');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Wood');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.M763Bash');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.M763BashWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M763.M763MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M763.M763Flash1');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyShell');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.AssaultShotgun.AA12Pickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.AssaultShotgun.AA12AmmoPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.AssaultShotgun.AA12GrenadePickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.AssaultShotgun.AA12Pickup'
     PickupDrawScale=1.300000
     InventoryType=Class'BWBP_OP_Pro.RCS715Shotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the RCS-715 Tactical Buster."
     PickupSound=Sound'BW_Core_WeaponSound.M763.M763Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.AssaultShotgun.AA12Pickup'
     Physics=PHYS_None
     DrawScale=2.000000
     CollisionHeight=3.000000
}
