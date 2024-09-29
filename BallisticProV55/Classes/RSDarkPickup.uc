//=============================================================================
// RSDarkPickup.
//=============================================================================
class RSDarkPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

var float SoulPower;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.BigProj');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.BigProj2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.Dark-ScorchA');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.Dark-ScorchB');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkAmmoPickup');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkShock');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkSpec0');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkSpec1');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkSpec2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkSpec3');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkSpec4');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkSpec5');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkStarChain');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkStarDiamond');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkStarSkin');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkStarSpecMask');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkTrail');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.EvilSoul');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.HotFlareA2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.Plasma-A');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.Plasma-A-AlphaAdd');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.Plasma-B-AlphaAdd');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.SmallProj');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.SmallProj2');

	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkDiamond');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkPickup-HD');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkPickup-LD');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkProjBig');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkProjSmall');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkStarAmmo');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.DarkStar.GlowChunk');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.DarkStar.Horns');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.BigProj');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.BigProj2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.Dark-ScorchA');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.Dark-ScorchB');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkAmmoPickup');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkShock');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkSpec0');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkSpec1');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkSpec2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkSpec3');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkSpec4');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkSpec5');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkStarChain');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkStarDiamond');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkStarSkin');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkStarSpecMask');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.DarkTrail');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.EvilSoul');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.HotFlareA2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.Plasma-A');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.Plasma-A-AlphaAdd');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.Plasma-B-AlphaAdd');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.SmallProj');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.DarkStar.SmallProj2');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkDiamond');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkPickup-HD');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkPickup-LD');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkProjBig');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkProjSmall');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkStarAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.DarkStar.GlowChunk');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.DarkStar.Horns');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkPickup-LD'
     PickupDrawScale=0.700000
     InventoryType=Class'BallisticProV55.RSDarkStar'
     RespawnTime=20.000000
     PickupMessage="You picked up the Dark Star."
     PickupSound=Sound'BW_Core_WeaponSound.A73.A73Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkPickup-HD'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.500000
     PrePivot=(Z=7.000000)
     CollisionHeight=4.500000
}
