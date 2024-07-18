//=============================================================================
// ScarabPickup.
//=============================================================================
class ScarabPickup extends BallisticWeaponPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_CC_Tex.Grenade.Grenade_Weapon_Tex');
     L.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.CruGren.CruGrenPickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.CruGren.CruGrenPickupLo');

}

simulated function UpdatePrecacheMaterials()
{
    super.UpdatePrecacheMaterials();
	Level.AddPrecacheMaterial(Texture'BWBP_CC_Tex.Grenade.Grenade_Weapon_Tex');
}

simulated function UpdatePrecacheStaticMeshes()
{
    Super.UpdatePrecacheStaticMeshes();
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.CruGren.CruGrenPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.CruGren.CruGrenPickupLo');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_CC_Static.CruGren.CruGrenPickupLo'
     PickupDrawScale=0.200000
     bWeaponStay=False
     InventoryType=Class'BWBP_APC_Pro.ScarabGrenade'
     RespawnTime=20.000000
     PickupMessage="You picked up the NRX-82 'Scarab' grenade."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BWBP_CC_Static.CruGren.CruGrenPickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=5.600000
}
