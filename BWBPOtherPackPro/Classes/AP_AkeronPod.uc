class AP_AkeronPod extends BallisticAmmoPickup;

#exec OBJ LOAD File="BWBP_OP_Static.usx"

defaultproperties
{
     AmmoAmount=18
     InventoryType=Class'BWBPOtherPackPro.Ammo_Akeron'
     PickupMessage="You picked up an Akeron rocket pod."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_OP_Static.Akeron.AkeronAmmo'
     DrawScale=0.800000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
