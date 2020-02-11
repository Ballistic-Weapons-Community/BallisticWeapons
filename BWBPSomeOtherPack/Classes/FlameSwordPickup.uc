//=============================================================================
// DragonsToothPickup.
//=============================================================================
class FlameSwordPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BWBPSomeOtherPackTex.utx
#exec OBJ LOAD FILE=BWBPSomeOtherPackStatic.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Shader'BWBPSomeOtherPackTex.FlameSword.BWsword_SH1');
	L.AddPrecacheMaterial(Shader'BWBPSomeOtherPackTex.FlameSword.BWsword_SH2');
	L.AddPrecacheMaterial(Shader'BWBPSomeOtherPackTex.FlameSword.BWsword_SH3');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCut');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Shader'BWBPSomeOtherPackTex.FlameSword.BWsword_SH1');
	Level.AddPrecacheMaterial(Shader'BWBPSomeOtherPackTex.FlameSword.BWsword_SH2');;
	Level.AddPrecacheMaterial(Shader'BWBPSomeOtherPackTex.FlameSword.BWsword_SH3');;
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPSomeOtherPackStatic.FlameSword.Sword_Static');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPSomeOtherPackStatic.FlameSword.Sword_Static'
     InventoryType=Class'BWBPSomeOtherPack.FlameSword'
     RespawnTime=50.000000
     PickupMessage="You picked up the PSI-56 Fire Sword."
     PickupSound=Sound'BWBPSomeOtherPackSounds.FlameSword.FlameSword-Equip'
     StaticMesh=StaticMesh'BWBPSomeOtherPackStatic.FlameSword.Sword_Static'
     Physics=PHYS_None
     DrawScale=1.60000
     CollisionHeight=3.500000
}
