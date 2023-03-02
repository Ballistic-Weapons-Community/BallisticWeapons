//=============================================================================
// HKMKSpecPickup.
//=============================================================================
class HKMKSpecPickup extends BallisticHandgunPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_JCF_Static.HKMKSpec.HKMK_SM'
     PickupDrawScale=0.100000
     InventoryType=Class'BWBP_JCF_Pro.HKMKSpecPistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the HKM-26 pistol."
     PickupSound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BWBP_JCF_Static.HKMKSpec.HKMK_SM'
     Physics=PHYS_None
     DrawScale=0.100000
     PrePivot=(Y=-18.000000)
     CollisionHeight=4.000000
}
