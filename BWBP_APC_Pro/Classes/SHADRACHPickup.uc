//=============================================================================
// ChaffPickup.
//=============================================================================
class SHADRACHPickup extends BallisticWeaponPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.SRXSmg.SRX-RadGrenade');	
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.M4A1.M4-Ord');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.SPXSmg.SHADRACH_Proj');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.SRXSmg.SRX-RadGrenade');		
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.M4A1.M4-Ord');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.MOAC.MOACPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.SPXSmg.SHADRACH_Proj');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.MOAC.MOACPickup'
     PickupDrawScale=0.180000
     bWeaponStay=False
     InventoryType=Class'BWBP_APC_Pro.SRKSubMachinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the MOA-C chaff grenade."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.MOAC.MOACPickup'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=2.000000
     CollisionHeight=5.600000
}
