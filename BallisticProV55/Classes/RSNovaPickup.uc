//=============================================================================
// RSNovaPickup.
//=============================================================================
class RSNovaPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP4-Tex.utx
#exec OBJ LOAD FILE=BWBP4-Hardware.usx

var float SoulPower;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.Lighter.NovaProjectile');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.Lighter.NovaProjectile2');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.Lighter.Projectile3');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.Lighter.Projectile4');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.GoodSoul');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.Nova-ScorchA');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.Nova-ScorchB');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.NovaAura');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.NovaStaff-AmmoPod');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.NovaStaff-SpecMask');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.NovaStaff_Ammo');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.NovaStaff_Blades');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.NovaStaff_Main');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.NovaWing');

	L.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.NovaStaff.NovaBladeGlow');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.NovaStaff.Nova-GlowChips');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.NovaStaff.NovaProjectile');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.NovaStaff.NovaProjectile2');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.NovaStaff.Wing');
}
simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.Lighter.NovaProjectile');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.Lighter.NovaProjectile2');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.Lighter.Projectile3');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.Lighter.Projectile4');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.GoodSoul');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.Nova-ScorchA');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.Nova-ScorchB');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.NovaAura');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.NovaStaff-AmmoPod');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.NovaStaff-SpecMask');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.NovaStaff_Ammo');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.NovaStaff_Blades');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.NovaStaff_Main');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.NovaStaff.NovaWing');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.NovaStaff.Nova-Ammo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.NovaStaff.NovaBladeGlow');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.NovaStaff.NovaGemGlow');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.NovaStaff.Nova-GlowChips');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.NovaStaff.NovaPickup-HD');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.NovaStaff.NovaPickup-LD');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.NovaStaff.NovaProjectile');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.NovaStaff.NovaProjectile2');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.NovaStaff.Wing');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP4-Hardware.NovaStaff.NovaPickup-LD'
     PickupDrawScale=0.900000
     InventoryType=Class'BallisticProV55.RSNovaStaff'
     RespawnTime=20.000000
     PickupMessage="You picked up the Nova Staff."
     PickupSound=Sound'BallisticSounds2.A73.A73Putaway'
     StaticMesh=StaticMesh'BWBP4-Hardware.NovaStaff.NovaPickup-HD'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.700000
     PrePivot=(Z=7.000000)
     CollisionHeight=4.500000
}
