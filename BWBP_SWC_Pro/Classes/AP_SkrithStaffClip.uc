//=============================================================================
// AP_SkrithStaffClip
//
// The charge module from the A73 Skrith Rifle. Gives ammo between 10 amd 25.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_SkrithStaffClip extends BallisticAmmoPickup;

// Some of these are good, some not so good
auto state Pickup
{
	function BeginState()
	{
		AmmoAmount = default.AmmoAmount + (-10 + Rand(25));
		Super.BeginState();
	}
}

defaultproperties
{
     AmmoAmount=120
     InventoryType=Class'BWBP_SWC_Pro.Ammo_SSCells'
     PickupMessage="You picked up an energy cell"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.A73CellPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.A73Clip'
     DrawScale=0.300000
     Skins(0)=Texture'BW_Core_WeaponTex.A73OrangeLayout.A73BAmmoSkin'
     Skins(1)=Texture'BW_Core_WeaponTex.A73OrangeLayout.A73BAmmoSkin'
     CollisionRadius=8.000000
     CollisionHeight=4.800000
}
