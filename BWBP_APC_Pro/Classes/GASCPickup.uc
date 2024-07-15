//=============================================================================
// GASCPickup.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class GASCPickup extends BallisticHandgunPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_CC_Tex.GASC.GASCMain');
	L.AddPrecacheMaterial(Texture'BWBP_CC_Tex.GASC.GASCMagMain');
     L.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.GASC.GASCPickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.GASC.GASCPickupLo');

}

simulated function UpdatePrecacheMaterials()
{
     super.UpdatePrecacheMaterials();
	Level.AddPrecacheMaterial(Texture'BWBP_CC_Tex.GASC.GASCMain');
	Level.AddPrecacheMaterial(Texture'BWBP_CC_Tex.GASC.GASCMagMain');
}

simulated function UpdatePrecacheStaticMeshes()
{
     Super.UpdatePrecacheStaticMeshes();
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.GASC.GASCPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.GASC.GASCPickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_CC_Static.GASC.GASCPickupLo'
     PickupDrawScale=0.600000
     InventoryType=Class'BWBP_APC_Pro.GASCPistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the Gaucho and Stallion"
     PickupSound=Sound'BW_Core_WeaponSound.M806.M806Putaway'
     StaticMesh=StaticMesh'BWBP_CC_Static.GASC.GASCPickupHi'
     Physics=PHYS_None
     DrawScale=0.600000
     CollisionHeight=4.000000
}
