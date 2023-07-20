//=============================================================================
// R9000EPickup.
//=============================================================================
class R9000EPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_CC_Static.R9000E.R9000E_SM'
     PickupDrawScale=0.400000
     InventoryType=Class'BWBP_APC_Pro.R9000ERifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the R9000E modular sniper rifle."
     PickupSound=Sound'BW_Core_WeaponSound.R78.R78Putaway'
     StaticMesh=StaticMesh'BWBP_CC_Static.R9000E.R9000E_SM'
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=3.000000
}
