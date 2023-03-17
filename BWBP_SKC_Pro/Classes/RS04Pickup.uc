//=============================================================================
// RS04Pickup.
//=============================================================================
class RS04Pickup extends BallisticHandGunPickup
	placeable;


#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.RS04.RS04-Main');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.RS04.RS04Pickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.RS04.RS04Pickup'
     PickupDrawScale=0.600000
     InventoryType=Class'BWBP_SKC_Pro.RS04Pistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the RS04 .45 Compact"
     PickupSound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.RS04.RS04Pickup'
     Physics=PHYS_None
     DrawScale=0.620000
     CollisionHeight=4.000000
}
