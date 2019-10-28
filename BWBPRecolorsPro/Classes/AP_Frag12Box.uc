//=============================================================================
// AP_Frag12Box
//
// some boom booms for the boom boom gun
//
// by George W. Bush
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_Frag12Box extends BallisticAmmoPickup;

simulated event PreBeginplay()
{
}

defaultproperties
{
     AmmoAmount=3
     InventoryType=Class'BWBPRecolorsPro.Ammo_20mmGrenade'
     PickupMessage="You picked up 3 FRAG-12 explosives."
     PickupSound=Sound'BallisticSounds2.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.Bulldog.BullDogAmmoGL'
     DrawScale=0.800000
     CollisionRadius=8.000000
     CollisionHeight=10.000000
}
