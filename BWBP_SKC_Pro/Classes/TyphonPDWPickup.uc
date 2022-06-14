//=============================================================================
// TyphonPDWPickup.
//=============================================================================
class TyphonPDWPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M806.M806_Main');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyPistolRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M806.PistolMuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Ammo.M806Clip');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.Typhon.TyphonPickup'
     PickupDrawScale=0.200000
     InventoryType=Class'BWBP_SKC_Pro.TyphonPDW'
     RespawnTime=10.000000
     PickupMessage="You picked up the LRX-5 'Typhon' Pulse PDW."
     PickupSound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-Pickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.Typhon.TyphonPickup'
     Physics=PHYS_None
     DrawScale=0.220000
     CollisionHeight=4.000000
}
