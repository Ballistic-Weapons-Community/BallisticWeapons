//=============================================================================
// RSDarkPickup.
//=============================================================================
class RSDarkPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP4-Tex.utx
#exec OBJ LOAD FILE=BWBP4-Hardware.usx

var float SoulPower;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.BigProj');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.BigProj2');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.Dark-ScorchA');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.Dark-ScorchB');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkAmmoPickup');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkShock');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkSpec0');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkSpec1');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkSpec2');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkSpec3');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkSpec4');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkSpec5');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkStarChain');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkStarDiamond');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkStarSkin');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkStarSpecMask');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkTrail');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.EvilSoul');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.HotFlareA2');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.Plasma-A');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.Plasma-A-AlphaAdd');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.Plasma-B-AlphaAdd');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.SmallProj');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.SmallProj2');

	L.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.DarkStar.DarkDiamond');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.DarkStar.DarkPickup-HD');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.DarkStar.DarkPickup-LD');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.DarkStar.DarkProjBig');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.DarkStar.DarkProjSmall');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.DarkStar.DarkStarAmmo');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.DarkStar.GlowChunk');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.DarkStar.Horns');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.BigProj');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.BigProj2');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.Dark-ScorchA');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.Dark-ScorchB');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkAmmoPickup');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkShock');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkSpec0');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkSpec1');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkSpec2');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkSpec3');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkSpec4');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkSpec5');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkStarChain');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkStarDiamond');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkStarSkin');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkStarSpecMask');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.DarkTrail');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.EvilSoul');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.HotFlareA2');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.Plasma-A');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.Plasma-A-AlphaAdd');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.Plasma-B-AlphaAdd');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.SmallProj');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.DarkStar.SmallProj2');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.DarkStar.DarkDiamond');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.DarkStar.DarkPickup-HD');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.DarkStar.DarkPickup-LD');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.DarkStar.DarkProjBig');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.DarkStar.DarkProjSmall');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.DarkStar.DarkStarAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.DarkStar.GlowChunk');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.DarkStar.Horns');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP4-Hardware.DarkStar.DarkPickup-LD'
     PickupDrawScale=0.700000
     InventoryType=Class'BallisticProV55.RSDarkStar'
     RespawnTime=20.000000
     PickupMessage="You picked up the Dark Star."
     PickupSound=Sound'BallisticSounds2.A73.A73Putaway'
     StaticMesh=StaticMesh'BWBP4-Hardware.DarkStar.DarkPickup-HD'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.600000
     PrePivot=(Z=7.000000)
     CollisionHeight=4.500000
}
