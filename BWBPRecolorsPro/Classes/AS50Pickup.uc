//=============================================================================
// AS50Pickup.
//=============================================================================
class AS50Pickup extends BallisticWeaponPickup
	placeable;


#exec OBJ LOAD FILE=BallisticRecolors3TexPro.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx
#exec OBJ LOAD FILE=BallisticRecolors4StaticPro.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.FSG50.FSG-Main');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.FSG50.FSG-Misc');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.FSG50.FSG-Scope');	
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.FSG50.FSG-Stock');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyRifleRound');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.FSG50.FSG-Main');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.FSG50.FSG-Misc');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.FSG50.FSG-Scope');	
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.FSG50.FSG-Stock');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyRifleRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.FSSG50.FSSG50PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.FSSG50.FSSG50AmmoPickup');

}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticPro.FSSG50.FSSG50PickupHi'
     PickupDrawScale=0.750000
     MaxDesireability=0.750000
     InventoryType=Class'BWBPRecolorsPro.AS50Rifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the FSSG-50 marksman rifle."
     PickupSound=Sound'BWBP4-Sounds.MRL.MRL-BigOn'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.FSSG50.FSSG50PickupHi'
     Physics=PHYS_None
     DrawScale=0.400000
     PrePivot=(Y=-15.000000)
     CollisionHeight=3.000000
}
