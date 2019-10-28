//=============================================================================
// PS9mPickup.
//=============================================================================
class PS9mPickup extends BallisticHandgunPickup
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
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Stealth.Stealth-Main');
}


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Stealth.Stealth-Main');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.Ps9m.PS9mPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.Ps9m.PS9mAmmo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticProExp.PS9M.PS9mPickup'
     PickupDrawScale=0.190000
     InventoryType=Class'BWBPRecolorsPro.PS9mPistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the PS-9m stealth pistol."
     PickupSound=Sound'PackageSounds4ProExp.Stealth.Stealth-Pickup'
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.PS9M.PS9mPickup'
     Physics=PHYS_None
     DrawScale=0.150000
     CollisionHeight=4.000000
}
