//=============================================================================
// FG50Pickup.
//=============================================================================
class FG50Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
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
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.FG50.FG50-Main');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.FG50.FG50-Misc');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.FG50.FG50-Screen');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.FSG50.FSG-Stock');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.FG50.FG50PickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.FG50.FG50AmmoPickup');
}
simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.FG50.FG50-Main');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.FG50.FG50-Misc');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.FG50.FG50-Screen');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.FSG50.FSG-Stock');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyRifleRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.FG50.FG50PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.FG50.FG50AmmoPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticPro.FG50.FG50PickupHi'
     InventoryType=Class'BWBPRecolorsPro.FG50MachineGun'
     RespawnTime=20.000000
     PickupMessage="You picked up the FG50 machinegun."
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.FG50.FG50PickupHi'
     Physics=PHYS_None
     DrawScale=1.100000
     PrePivot=(Y=-10.000000)
     CollisionHeight=4.000000
}
