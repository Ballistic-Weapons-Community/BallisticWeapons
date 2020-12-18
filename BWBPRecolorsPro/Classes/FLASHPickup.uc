//=============================================================================
// FLASHPickup.
//=============================================================================
class FLASHPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors4TexPro.utx
#exec OBJ LOAD FILE=BallisticRecolors4StaticProExp.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Flash.FLASH-Main');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Flash.FLASH-Rocket');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Flash.FLASH-Scope');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Flash.FLASH-Main');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Flash.FLASH-Rocket');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Flash.FLASH-Scope');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.Flash.FLASHAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.Flash.FLASHPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticProExp.Flash.FLASHPickup'
     PickupDrawScale=0.600000
     InventoryType=Class'BWBPRecolorsPro.FLASHLauncher'
     RespawnTime=120.000000
     PickupMessage="You picked up the AT40 'STREAK' incendiary rocket launcher."
     PickupSound=Sound'BallisticSounds2.G5.G5-Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.Flash.FLASHPickup'
     Physics=PHYS_None
     DrawScale=0.600000
     CollisionHeight=6.000000
}
