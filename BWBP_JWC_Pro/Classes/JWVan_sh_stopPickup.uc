//=============================================================================
// JS_stopSignPickup.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_sh_stoppickup extends JunkShieldPickup;

defaultproperties
{
     SpawnPivot=(Roll=30000)
     InventoryType=Class'BWBP_JWC_Pro.JWVan_sh_stop'
     PickupMessage="You picked up a Stop Sign."
     StaticMesh=StaticMesh'BWBP_JW_Static.sh_stop_LD'
}
