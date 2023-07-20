//=============================================================================
// ScarabPickup.
//=============================================================================
class ScarabPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_CC_Static.CruGren.Grenade_SM_Pickup'
     PickupDrawScale=0.050000
     bWeaponStay=False
     InventoryType=Class'BWBP_APC_Pro.ScarabGrenade'
     RespawnTime=20.000000
     PickupMessage="You picked up the NRX-82 'Scarab' grenade."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BWBP_CC_Static.CruGren.Grenade_SM_Pickup'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.050000
     CollisionHeight=5.600000
}
