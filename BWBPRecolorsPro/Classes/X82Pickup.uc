//=============================================================================
// X82Pickup.
//=============================================================================
class X82Pickup extends BallisticWeaponPickup
	placeable;


#exec OBJ LOAD FILE=BallisticRecolors3TexPro.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx
#exec OBJ LOAD FILE=BallisticRecolors4StaticPro.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.X82.X82Skin');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.X82.X82Spec');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.X82.X83SmokeCore');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.X82.X82Skin');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.X82.X82Spec');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.X82.X83SmokeCore');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyRifleRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.X83.X82A2Mag');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.X83.X83A1_ST');

}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticPro.X83.X83A1_ST'
     PickupDrawScale=0.400000
     MaxDesireability=0.750000
     InventoryType=Class'BWBPRecolorsPro.X82Rifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the X-83 A1 sniper rifle."
     PickupSound=Sound'BWBP4-Sounds.MRL.MRL-BigOn'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.X83.X83A1_ST'
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=3.000000
}
