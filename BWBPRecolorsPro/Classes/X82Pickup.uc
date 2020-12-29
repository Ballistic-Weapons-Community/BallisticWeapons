//=============================================================================
// X82Pickup.
//=============================================================================
class X82Pickup extends BallisticWeaponPickup
	placeable;


#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.X82.X82Skin');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.X82.X82Spec');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.X82.X83SmokeCore');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.X82.X82Skin');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.X82.X82Spec');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.X82.X83SmokeCore');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyRifleRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.X83.X82A2Mag');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.X83.X83A1_ST');

}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.X83.X83A1_ST'
     PickupDrawScale=0.400000
     MaxDesireability=0.750000
     InventoryType=Class'BWBPRecolorsPro.X82Rifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the X-83 A1 sniper rifle."
     PickupSound=Sound'BW_Core_WeaponSound.MRL.MRL-BigOn'
     StaticMesh=StaticMesh'BWBP_SKC_Static.X83.X83A1_ST'
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=3.000000
}
