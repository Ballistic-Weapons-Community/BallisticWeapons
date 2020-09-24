//=============================================================================
// AP_XMV850Ammo.
//
// 450 Rounds of 5.56mm ammo in an XMV850 backpack.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_XMV850Ammo extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=150
     InventoryType=Class'BallisticProV55.Ammo_MinigunRounds'
     PickupMessage="You stowed a backpack of minigun rounds."
     PickupSound=Sound'BallisticSounds2.XMV-850.XMV-AmmoPickup'
     StaticMesh=StaticMesh'BallisticHardware2.XMV850.XMV850AmmoPiickup'
     DrawScale=0.350000
     PrePivot=(Z=9.000000)
     CollisionRadius=8.000000
     CollisionHeight=5.500000
}
