//=============================================================================
// X82clip.
//
// 2 x 4 round clip for the X82.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_50BMGClip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=8
     InventoryType=Class'BWBPRecolorsPro.Ammo_50BMG'
     PickupMessage="You got two X83 magazines."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.X83.X82A2Mag'
     PrePivot=(Z=13.000000)
     CollisionRadius=8.000000
     CollisionHeight=10.000000
}
