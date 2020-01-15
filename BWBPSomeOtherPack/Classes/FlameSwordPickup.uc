//=============================================================================
// DragonsToothPickup.
//=============================================================================
class FlameSwordPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors3TexPro.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticRecolors4StaticPro.usx
//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.DragonToothSword.DragonTooth-Main');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.DragonToothSword.DragonTooth-Red');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.DragonToothSword.DragonToothCore-Red');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.DragonToothSword.DTS-Glow');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.DragonToothSword.DTSAplhaMask');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.DragonToothSword.DTSMask');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCut');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.DragonToothSword.DragonTooth-Main');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.DragonToothSword.DragonTooth-Red');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.DragonToothSword.DragonToothCore-Red');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.DragonToothSword.DTS-Glow');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.DragonToothSword.DTSAplhaMask');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.DragonToothSword.DTSMask');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.DTS.DragonsToothPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticPro.DTS.DragonsToothPickup'
     PickupDrawScale=1.000000
     InventoryType=Class'BWBPRecolorsPro.DragonsToothSword'
     RespawnTime=50.000000
     PickupMessage="You picked up the PSI-56 Fire Sword."
     PickupSound=Sound'PackageSounds4Pro.NEX.NEX-Pullout'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.DTS.DragonsToothPickup'
     Physics=PHYS_None
     DrawScale=0.600000
     CollisionHeight=4.000000
}
