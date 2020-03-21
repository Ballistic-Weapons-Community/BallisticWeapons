//=============================================================================
// R9Pickup.
//=============================================================================
class XM20Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors3TexPro.utx
#exec OBJ LOAD FILE=BWBPSomeOtherPackTex.utx
#exec OBJ LOAD FILE=BWBPSomeOtherPackStatic.usx
#exec OBJ LOAD FILE=BallisticRecolors4StaticPro.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Shader'BWBPSomeOtherPackTex.XM20.XM20Shiny');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.LS14.LS14-Impact');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.LS14.ElectroBolt');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.LS14.PlasmaMuzzleFlash2');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.LaserCarbine.PlasmaMuzzleFlash');
}


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Shader'BWBPSomeOtherPackTex.XM20.XM20Shiny');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.LS14.LS14-Impact');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.LS14.ElectroBolt');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.LS14.PlasmaMuzzleFlash2');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPSomeOtherPackStatic.XM20.XM20Pickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.LaserCarbine.PlasmaMuzzleFlash');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPSomeOtherPackStatic.XM20.XM20Pickup'
     PickupDrawScale=1.100000
     InventoryType=Class'BWBPSomeOtherPack.XM20AutoLas'
     RespawnTime=20.000000
     PickupMessage="You picked up the XM20 laser rifle."
     PickupSound=Sound'PackageSounds4Pro.LS14.Gauss-Pickup'
     StaticMesh=StaticMesh'BWBPSomeOtherPackStatic.XM20.XM20Pickup'
     Physics=PHYS_None
     DrawScale=1.00000
     CollisionHeight=3.500000
}
