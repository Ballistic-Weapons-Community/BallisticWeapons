//=============================================================================
// ICISPickup.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class ICISPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Stim.Stim-Main');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCut');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCutWood');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Stim.Stim-Main');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Stim.StimpackPickupHi');
     Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Stim.StimpackPickupLo');

}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.Stim.StimpackPickupLo'
     PickupDrawScale=0.270000
     InventoryType=Class'BWBP_SKC_Pro.ICISStimpack'
     RespawnTime=10.000000
     PickupMessage="You picked up the FMD ICIS-25 Stimulant Autoinjector"
     PickupSound=Sound'BW_Core_WeaponSound.Knife.KnifePutaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.Stim.StimpackPickupHi'
     Physics=PHYS_None
     DrawScale=0.300000
     CollisionHeight=4.000000
}
