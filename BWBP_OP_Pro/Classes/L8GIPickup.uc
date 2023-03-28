//=============================================================================
// FP7Pickup.
//=============================================================================
class L8GIPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

simulated function UpdatePrecacheMaterials()
{
	//Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Health.NTOVSkin');
}

simulated function UpdatePrecacheStaticMeshes()
{
	//Level.AddPrecacheStaticMesh(StaticMesh'BWSkrithRecolorsArchive2Static.NTOV.NTOVPickup');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.AmmoPackLo'
     PickupDrawScale=0.350000
     bWeaponStay=False
     InventoryType=Class'BWBP_OP_Pro.L8GIAmmoPack'
     RespawnTime=20.000000
     PickupMessage="You picked up the L8 GI Ammunition Pack"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.AmmoPackPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.AmmoPackHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.350000
     CollisionRadius=16.000000
     CollisionHeight=15.000000
}
