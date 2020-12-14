//=============================================================================
// PS9mPickup.
//=============================================================================
class PS9mPickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_TexExp.utx
#exec OBJ LOAD FILE=BWBP_SKC_StaticExp.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.Stealth.Stealth-Main');
}


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.Stealth.Stealth-Main');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_StaticExp.Ps9m.PS9mPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_StaticExp.Ps9m.PS9mAmmo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_StaticExp.PS9M.PS9mPickup'
     PickupDrawScale=0.190000
     InventoryType=Class'BWBPRecolorsPro.PS9mPistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the PS-9m stealth pistol."
     PickupSound=Sound'BWBP_SKC_SoundsExp.Stealth.Stealth-Pickup'
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.PS9M.PS9mPickup'
     Physics=PHYS_None
     DrawScale=0.150000
     CollisionHeight=4.000000
}
