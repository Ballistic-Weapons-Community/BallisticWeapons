//=============================================================================
// SPASPickup.
//=============================================================================
class SPASPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_JCF_Static.SPAS.SPAS_Main_Static'
     PickupDrawScale=0.100000
     InventoryType=Class'BWBP_JCF_Pro.SPASShotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the SPAS Compact Shotgun"
     PickupSound=Sound'BW_Core_WeaponSound.M763.M763Putaway'
     StaticMesh=StaticMesh'BWBP_JCF_Static.SPAS.SPAS_Main_Static'
     Physics=PHYS_None
     CollisionHeight=3.000000
	 DrawScale=0.100000
}
