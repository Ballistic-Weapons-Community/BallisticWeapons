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
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.AssaultShotgun.AA12Diffuse');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CYLO.Reflex');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.AssaultShotgun.AA12GrenadeDiffuse');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.AssaultShotgun.AA12PickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.AssaultShotgun.AA12PickupLo');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.AssaultShotgun.AA12Diffuse');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CYLO.Reflex');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.AssaultShotgun.AA12GrenadeDiffuse');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.AssaultShotgun.AA12PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.AssaultShotgun.AA12PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.AssaultShotgun.AA12PickupLo'
     PickupDrawScale=0.100000
     InventoryType=Class'BWBP_OP_Pro.RCS715Shotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the RCS-715 Assault Shotgun."
     PickupSound=Sound'BW_Core_WeaponSound.M763.M763Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.AssaultShotgun.AA12PickupHi'
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=3.000000
}
