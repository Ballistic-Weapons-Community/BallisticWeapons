//=============================================================================
// Mk781Pickup.
//=============================================================================
class Mk781Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.M1014.M1014-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.M1014.M1014-Misc');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.M1014.M1014-SpecMap');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyShell');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.M1014.M1014-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.M1014.M1014-Misc');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Concrete');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_StaticExp.M1014.M1014Pickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M763.M763MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M763.M763Flash1');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyShell');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Ammo.M763ShellBox');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_StaticExp.M1014.M1014Pickup'
     PickupDrawScale=1.000000
     InventoryType=Class'BWBPRecolorsPro.MK781Shotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the MK781 combat shotgun."
     PickupSound=Sound'BW_Core_WeaponSound.M763.M763Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.M1014.M1014Pickup'
     Physics=PHYS_None
     CollisionHeight=3.000000
}
