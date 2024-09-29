//=============================================================================
// HMCPickup.
//SgtK: im making the HMC pickups atm
//SgtK: im assuming decimate them to hell and back
//SgtK: hear the lamentations of their polygons
//SgtK: real sad HMC energy on this one
//SgtK: please kill me father
//=============================================================================
class HMCPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Static.usx
#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.HMC.HMC117Pickup_LD');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.HMC.HMC117Pickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.BackPack.HVPCBackPackLarge');
}


defaultproperties
{
     bOnSide=true
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.HMC.HMC117Pickup_LD'
     PickupDrawScale=0.1
     InventoryType=Class'BWBP_SKC_Pro.HMCBeamCannon'
     PickupMessage="You picked up the HMC-117 photon cannon."
     PickupSound=Sound'BW_Core_WeaponSound.RX22A.RX22A-Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.HMC.HMC117Pickup'
     Physics=PHYS_None
     DrawScale=0.080000
     CollisionHeight=5.000000
}
