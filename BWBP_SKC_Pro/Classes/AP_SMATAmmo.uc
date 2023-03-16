//=============================================================================
// AP_SMATAmmo.
//
// 2 loose rockets for the SMAT
//
// by SK
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_SMATAmmo extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=2
     InventoryType=Class'BWBP_SKC_Pro.Ammo_SMAT'
     PickupMessage="You picked up 2 SMAT artillery shells"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.RocketPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.G5Rockets'
     DrawScale=0.750000
     //Skins(0)=Texture'BWBP_SKC_Tex.SMAA.SMAARocket'
     CollisionRadius=8.000000
     CollisionHeight=5.000000
}
