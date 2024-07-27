//=============================================================================
// R78Pickup.
//=============================================================================
class LightningPickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.R78.RifleSkin');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.R78.ScopeSkin');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyRifleRound');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.R78.RifleMuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.R78.RifleSkin');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.R78.ScopeSkin');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyRifleRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.R78.RifleMuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Ammo.R78Clip');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.LightningGun.LightningGunPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.LightningGun.LightningGunPickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.LightningGun.LightningGunPickupLo'
     PickupDrawScale=0.150000
     InventoryType=Class'BWBP_OP_Pro.LightningRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the ARC-79 lightning rifle."
     PickupSound=Sound'BW_Core_WeaponSound.R78.R78Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.LightningGun.LightningGunPickupHi'
     Physics=PHYS_None
     DrawScale=0.300000
     CollisionHeight=3.000000
}
