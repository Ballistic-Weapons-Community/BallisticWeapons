//=============================================================================
// ICISPickup.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class ICISPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Stim.Stim-Main');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCut');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Stim.Stim-Main');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.Stim.StimpackPickup');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticProExp.Stim.StimpackPickup'
     PickupDrawScale=0.270000
     InventoryType=Class'BWBPRecolorsPro.ICISStimpack'
     RespawnTime=10.000000
     PickupMessage="You picked up the FMD ICIS-25 Stimulant Autoinjector"
     PickupSound=Sound'BallisticSounds2.Knife.KnifePutaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.Stim.StimpackPickup'
     Physics=PHYS_None
     DrawScale=0.300000
     CollisionHeight=4.000000
}
