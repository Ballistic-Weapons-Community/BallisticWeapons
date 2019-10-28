class AP_AkeronPod extends BallisticAmmoPickup;

#exec OBJ LOAD File="BWBPOtherPackStatic3.usx"

defaultproperties
{
     AmmoAmount=90
     InventoryType=Class'BWBPOtherPackPro.Ammo_Akeron'
     PickupMessage="You picked up an Akeron rocket pod."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBPOtherPackStatic3.Akeron.AkeronAmmo'
     DrawScale=0.800000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
