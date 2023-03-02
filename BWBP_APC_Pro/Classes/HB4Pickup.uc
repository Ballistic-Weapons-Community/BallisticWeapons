//=============================================================================
// MGLPickup.
//=============================================================================
class HB4Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_CC_Static.HoloBlaster.HoloBlaster_SM_Main'
     InventoryType=Class'BWBP_APC_Pro.HB4GrenadeBlaster'
     RespawnTime=120.000000
     PickupMessage="You picked up the HB4 Electro Grenade Blaster."
     PickupSound=Sound'BW_Core_WeaponSound.M763.M763Putaway'
     StaticMesh=StaticMesh'BWBP_CC_Static.HoloBlaster.HoloBlaster_SM_Main'
     Physics=PHYS_None
     DrawScale=0.120000
     CollisionHeight=3.000000
}
