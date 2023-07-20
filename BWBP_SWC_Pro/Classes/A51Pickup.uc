//=============================================================================
// FP7Pickup.
//=============================================================================
class A51Pickup extends BallisticWeaponPickup
	placeable;
/*
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
*/

/*simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.FP7.FP7Grenade');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.FlameParts');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.BlazingSubdivide');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');
}*/

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SWC_Static.SkrithGrenadeProj');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SWC_Static.SkrithGrenadePickupHi');

}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_SWC_Static.SkrithGrenadePickupHi'
     PickupDrawScale=0.500000
     bWeaponStay=False
     InventoryType=Class'BWBP_SWC_Pro.A51Grenade'
     RespawnTime=20.000000
     PickupMessage="You picked up the AD-51 Reptile Corossive Grenade"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BWBP_SWC_Static.SG.SkrithGrenadePickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     CollisionHeight=5.600000
}
