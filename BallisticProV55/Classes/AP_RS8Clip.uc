//=============================================================================
// AP_RS8Clip.
//
// 2 clips for th RS8.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_RS8Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=36
     InventoryType=Class'BallisticProV55.Ammo_RS8Bullets'
     PickupMessage="You picked up four RS8 magazines."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWAddPack-RS-Hardware.RS8.RS8Clips'
     DrawScale=0.300000
     PrePivot=(Z=-12.000000)
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
