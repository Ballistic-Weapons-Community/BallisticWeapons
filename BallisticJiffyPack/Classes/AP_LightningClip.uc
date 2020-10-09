//=============================================================================
// AP_R78Clip.
//
// 2 x 7 round clip for the R78.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_LightningClip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=12
     InventoryType=Class'BallisticJiffyPack.Ammo_LightningRifle'
     PickupMessage="You picked up ARC-79 Lightning Rifle cylinders."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBPJiffyPackStatic.LightningGun.LG_Mag'
     DrawScale=0.500000
	 PrePivot=(Z=30.000000)
     CollisionRadius=8.000000
     CollisionHeight=14.000000
}
