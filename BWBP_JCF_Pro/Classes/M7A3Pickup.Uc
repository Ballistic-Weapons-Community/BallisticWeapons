//=============================================================================
// SARPickup.
//=============================================================================
class M7A3Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_JCF_Static.M7A3.M7A3_Main_Static'
     PickupDrawScale=0.100000
     InventoryType=Class'BWBP_JCF_Pro.M7A3AssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the M7A3 Assault Rifle"
     PickupSound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BWBP_JCF_Static.M7A3.M7A3_Main_Static'
     Physics=PHYS_None
     DrawScale=0.10000
     CollisionHeight=4.000000
}
