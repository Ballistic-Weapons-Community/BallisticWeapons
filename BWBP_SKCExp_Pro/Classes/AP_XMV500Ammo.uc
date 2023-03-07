//=============================================================================
// AP_XMV850Ammo.
//
// 400 Rounds of 5.56mm incendiary ammo in an XMV500 backpack.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_XMV500Ammo extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=400
     InventoryType=Class'BWBP_SKCExp_Pro.Ammo_MinigunInc'
     PickupMessage="You got 400 rounds of 7.62mm incendiary ammo"
     PickupSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-AmmoPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.XMV850.XMV850AmmoPiickup'
     DrawScale=0.350000
     PrePivot=(Z=9.000000)
     Skins(0)=Texture'BWBP_Camos_Tex.XMVCamos.XMV500_BackPack'
     Skins(1)=Texture'BWBP_Camos_Tex.XMVCamos.XMV500_BackPack'
     Skins(2)=Texture'BWBP_Camos_Tex.XMVCamos.XMV500_BackPack'
     CollisionRadius=8.000000
     CollisionHeight=5.500000
}
