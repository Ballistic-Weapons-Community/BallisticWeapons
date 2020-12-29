//=============================================================================
// M58Pickup.
//=============================================================================
class M58Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M58.M58GrenadeSkin');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.T10.T10Clip');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M58.M58Projectile');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.T10.T10Pickup');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.T10.T10Pickup'
     PickupDrawScale=0.350000
     bWeaponStay=False
     InventoryType=Class'BallisticProV55.M58Grenade'
     RespawnTime=20.000000
     PickupMessage="You picked up the M58 smoke grenade."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.T10.T10Pickup'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.700000
     CollisionHeight=5.600000
}
