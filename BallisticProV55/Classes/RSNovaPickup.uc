//=============================================================================
// RSNovaPickup.
//=============================================================================
class RSNovaPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

var float SoulPower;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Lighter.NovaProjectile');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Lighter.NovaProjectile2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Lighter.Projectile3');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Lighter.Projectile4');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.GoodSoul');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.Nova-ScorchA');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.Nova-ScorchB');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.NovaAura');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.NovaStaff-AmmoPod');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.NovaStaff-SpecMask');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.NovaStaff_Ammo');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.NovaStaff_Blades');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.NovaStaff_Main');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.NovaWing');

	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.NovaStaff.NovaBladeGlow');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.NovaStaff.Nova-GlowChips');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.NovaStaff.NovaProjectile');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.NovaStaff.NovaProjectile2');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.NovaStaff.Wing');
}
simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Lighter.NovaProjectile');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Lighter.NovaProjectile2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Lighter.Projectile3');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Lighter.Projectile4');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.GoodSoul');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.Nova-ScorchA');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.Nova-ScorchB');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.NovaAura');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.NovaStaff-AmmoPod');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.NovaStaff-SpecMask');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.NovaStaff_Ammo');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.NovaStaff_Blades');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.NovaStaff_Main');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NovaStaff.NovaWing');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.NovaStaff.Nova-Ammo');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.NovaStaff.NovaBladeGlow');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.NovaStaff.NovaGemGlow');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.NovaStaff.Nova-GlowChips');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.NovaStaff.NovaPickup-HD');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.NovaStaff.NovaPickup-LD');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.NovaStaff.NovaProjectile');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.NovaStaff.NovaProjectile2');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.NovaStaff.Wing');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.NovaStaff.NovaPickup-LD'
     PickupDrawScale=0.900000
     InventoryType=Class'BallisticProV55.RSNovaStaff'
     RespawnTime=20.000000
     PickupMessage="You picked up the Nova Staff."
     PickupSound=Sound'BW_Core_WeaponSound.A73.A73Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.NovaStaff.NovaPickup-HD'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.700000
     PrePivot=(Z=7.000000)
     CollisionHeight=4.500000
}
