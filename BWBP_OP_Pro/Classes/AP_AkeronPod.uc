class AP_AkeronPod extends BallisticAmmoPickup;

#exec OBJ LOAD File="BWBP_OP_Static.usx"

defaultproperties
{
     AmmoAmount=18
     InventoryType=Class'BWBP_OP_Pro.Ammo_Akeron'
     PickupMessage="You picked up an Akeron rocket pod."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_OP_Static.Akeron.AkeronAmmo'
     DrawScale=0.800000
	PrePivot=(Z=6.530000)
     CollisionRadius=9.250000
     CollisionHeight=5.200000
}
