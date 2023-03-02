//=============================================================================
// M353Pickup.
//=============================================================================
class PKMPickup extends BallisticWeaponPickup
	placeable;
	
/*
#exec OBJ LOAD FILE=BWBP_CC_Tex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BWBP_CC_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_CC_Tex.PKM.PKM-Main');
	L.AddPrecacheMaterial(Texture'BWBP_CC_Tex.PKM.PKM-Spec');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M353.M353MuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_CC_Tex.PKM.PKM-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_CC_Tex.PKM.PKM-Spec');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M353.M353MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Ammo.MachinegunBox');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M353.M353PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M353.M353PickupLo');
}
*/

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_CC_Static.PKMA.PKMA-Main'
     PickupDrawScale=0.100000
     StandUp=(Y=0.800000)
     InventoryType=Class'BWBP_APC_Pro.PKMMachinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the PKMA machinegun."
     PickupSound=Sound'BW_Core_WeaponSound.M353.M353-Putaway'
     StaticMesh=StaticMesh'BWBP_CC_Static.PKMA.PKMA-Main'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=12.000000
}
