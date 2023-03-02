//=============================================================================
// XMV850Pickup.
//=============================================================================
class A800MinigunPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=..\Textures\BWBP_SWC_Tex.utx
#exec OBJ LOAD FILE=..\StaticMeshes\BWBP_SWC_Static.usx

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SWC_Static.SkrithHyperBlaster.SkrithHB_SM');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_SWC_Static.SkrithHyperBlaster.SkrithHB_SM'
     PickupDrawScale=0.070000
     InventoryType=Class'BWBP_SWC_Pro.A800SkrithMinigun'
     RespawnTime=20.000000
     PickupMessage="You picked up the A800 Skrith HyperBlaster"
     PickupSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-Putaway'
     StaticMesh=StaticMesh'BWBP_SWC_Static.SkrithHyperBlaster.SkrithHB_SM'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.07
     PrePivot=(Z=35.000000)
     CollisionHeight=8.000000
}
