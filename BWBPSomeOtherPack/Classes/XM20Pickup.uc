//=============================================================================
// R9Pickup.
//=============================================================================
class XM20Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors3TexPro.utx
#exec OBJ LOAD FILE=BallisticRecolors4StaticPro.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.LS14.LS14-Main');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.LS14.LS14-Spec');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.LS14.LS14-Impact');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.LS14.ElectroBolt');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.LS14.PlasmaMuzzleFlash2');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.LaserCarbine.PlasmaMuzzleFlash');
}


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.LS14.LS14-Main');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.LS14.LS14-Spec');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.LS14.LS14-Impact');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.LS14.ElectroBolt');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.LS14.PlasmaMuzzleFlash2');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.LaserCarbine.LaserCarbinePickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.LaserCarbine.PlasmaMuzzleFlash');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticPro.LaserCarbine.LaserCarbinePickup'
     PickupDrawScale=1.100000
     InventoryType=Class'BWBPSomeOtherPack.XM20AutoLas'
     RespawnTime=20.000000
     PickupMessage="You picked up the XM20 Auto Las."
     PickupSound=Sound'PackageSounds4Pro.LS14.Gauss-Pickup'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.LaserCarbine.LaserCarbinePickup'
     Physics=PHYS_None
     DrawScale=1.100000
     CollisionHeight=3.000000
}
