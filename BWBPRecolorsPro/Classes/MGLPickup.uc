//=============================================================================
// MGLPickup.
//=============================================================================
class MGLPickup extends BallisticWeaponPickup
	placeable;

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
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MGL.MGL-Main');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MGL.MGL-Holosight');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MGL.MGL-Screen');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MGL.MGL-ScreenBase');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MGL.MGL-Main');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MGL.MGL-Holosight');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MGL.MGL-Screen');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MGL.MGL-ScreenBase');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.MGL.MGLPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.MGL.MGLPickupLow');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticProExp.MGL.MGLPickupLow'
     InventoryType=Class'BWBPRecolorsPro.MGLauncher'
     RespawnTime=120.000000
     PickupMessage="You picked up the Conqueror multiple grenade launcher."
     PickupSound=Sound'BallisticSounds2.M763.M763Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.MGL.MGLPickup'
     Physics=PHYS_None
     DrawScale=0.900000
     CollisionHeight=3.000000
}
