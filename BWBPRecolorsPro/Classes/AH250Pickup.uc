//=============================================================================
// AH250Pickup. DE pickup.
//=============================================================================
class AH250Pickup extends BallisticHandgunPickup
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
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Eagle.Eagle-MainSilverEngraved');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Eagle.Eagle-FrontSilver');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Eagle.Eagle-Misc');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Eagle.Eagle-ScopeRed');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Eagle.Eagle-SightReticleGreen');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M925.M925MuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Eagle.Eagle-MainSilverEngraved');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Eagle.Eagle-FrontSilver');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Eagle.Eagle-Misc');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Eagle.Eagle-ScopeRed');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Eagle.Eagle-SightReticleGreen');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M925.M925MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.DesertEagle.EaglePickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticProExp.DesertEagle.EaglePickup'
     PickupDrawScale=1.000000
     InventoryType=Class'BWBPRecolorsPro.AH250Pistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the AH250 'Hawk' scoped pistol."
     PickupSound=Sound'BallisticSounds2.MRT6.MRT6Pullout'
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.DesertEagle.EaglePickup'
     Physics=PHYS_None
     CollisionHeight=4.000000
}
