//=============================================================================
// AH208Pickup. DE pickup.
//=============================================================================
class AH208Pickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors4TexPro.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx
#exec OBJ LOAD FILE=BallisticRecolors4StaticProExp.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Eagle.Eagle-MainGoldEngraved');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Eagle.Eagle-ScopeGold');
	L.AddPrecacheMaterial(Shader'BallisticRecolors4TexPro.Eagle.Eagle-GoldShine');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M925.M925MuzzleFlash');
}
simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Eagle.Eagle-MainGoldEngraved');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Eagle.Eagle-ScopeGold');
	Level.AddPrecacheMaterial(Shader'BallisticRecolors4TexPro.Eagle.Eagle-GoldShine');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M925.M925MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.D49.D49AmmoBox');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.DesertEagle.GoldenEaglePickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticProExp.DesertEagle.GoldenEaglePickup'
     PickupDrawScale=0.400000
     InventoryType=Class'BWBPRecolorsPro.AH208Pistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the AH208 golden pistol."
     PickupSound=Sound'BallisticSounds2.MRT6.MRT6Pullout'
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.DesertEagle.GoldenEaglePickup'
     Physics=PHYS_None
     DrawScale=0.400000
     Skins(0)=FinalBlend'ONSstructureTextures.CoreGroup.InvisibleFinal'
     Skins(1)=Texture'BallisticRecolors4TexPro.Eagle.Eagle-ScopeGold'
     Skins(2)=FinalBlend'ONSstructureTextures.CoreGroup.InvisibleFinal'
     Skins(3)=Shader'BallisticRecolors4TexPro.Eagle.Eagle-GoldShine'
     CollisionHeight=4.000000
}
