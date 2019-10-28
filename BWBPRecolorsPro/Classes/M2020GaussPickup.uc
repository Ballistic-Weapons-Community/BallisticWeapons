//=============================================================================
// M2020GaussPickup.
//=============================================================================
class M2020GaussPickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M2020.M2020-Main');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M2020.M2020-Secondary');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M2020.M2020-SpecMask');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M2020.M2020-Screen');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M2020.M2020-Numbers');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M2020.M2020-FlareX1');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M2020.M2020-ScreenOff');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M2020.M2020-EnergyMaskAlt');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M2020.M2020-EnergyMask');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M2020.M2020-Main');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M2020.M2020-Secondary');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M2020.M2020-SpecMask');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M2020.M2020-Screen');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M2020.M2020-Numbers');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M2020.M2020-FlareX1');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M2020.M2020-ScreenOff');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M2020.M2020-EnergyMaskAlt');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M2020.M2020-EnergyMask');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.M2020.M2020Pickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticProExp.M2020.M2020Pickup'
     InventoryType=Class'BWBPRecolorsPro.M2020GaussDMR'
     RespawnTime=20.000000
     PickupMessage="You picked up the M2020 Gauss rifle."
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.M2020.M2020Pickup'
     Physics=PHYS_None
     DrawScale=0.700000
     CollisionHeight=4.000000
}
