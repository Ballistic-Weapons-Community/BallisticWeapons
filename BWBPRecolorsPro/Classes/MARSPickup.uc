//=============================================================================
// MRASPickup. Jason MRAS.
//=============================================================================
class MARSPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors4TexPro.utx
#exec OBJ LOAD FILE=BallisticRecolors4StaticProExp.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MARS.F2000-MainGreen');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MARS.F2000-Misc');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MARS.F2000-Scope');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MARS.F2000-ScopeLensAlt');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MARS.MARS-SpecScope');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MARS.F2000-MainGreen');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MARS.F2000-Misc');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MARS.F2000-Scope');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MARS.F2000-ScopeLensAlt');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MARS.MARS-SpecScope');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.F2000.MARSPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.F2000.MARSPickupLow');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticProExp.F2000.MARSPickupLow'
     InventoryType=Class'BWBPRecolorsPro.MARSAssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the MARS-2 assault rifle."
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.F2000.MARSPickup'
     Physics=PHYS_None
     CollisionHeight=4.000000
}
