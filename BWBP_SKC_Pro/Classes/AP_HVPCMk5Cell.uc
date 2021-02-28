//=============================================================================
// AP_HVCMk9Cell
//
// Favorite ammo pickup of the HVC-Mk9 Lightning Gun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_HVPCMk5Cell extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=50
     InventoryType=Class'BWBP_SKC_Pro.Ammo_HVPCCells'
     PickupMessage="You got an E-115 Plasma Cell"
     PickupSound=Sound'BW_Core_WeaponSound.LightningGun.LG-AmmoPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.LightningGun.LighterAmmo'
     DrawScale=0.250000
     Skins(0)=Texture'BWBP_SKC_Tex.XavPlasCannon.XavPackSkin'
     Skins(1)=Texture'BWBP_SKC_Tex.XavPlasCannon.XavAmmoSkin'
     CollisionRadius=8.000000
     CollisionHeight=4.800000
}
