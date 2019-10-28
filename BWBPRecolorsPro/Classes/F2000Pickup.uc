class F2000Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors4TexPro.utx
#exec OBJ LOAD FILE=BallisticRecolors4StaticProExp.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MARS.F2000-IronArctic');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MARS.F2000-MiscIce');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MARS.LK05-EOTech-Ice');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M900.M900Grenade');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M900.M900MuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MARS.F2000-IronArctic');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MARS.F2000-MiscIce');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.MARS.LK05-EOTech-Ice');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M900.M900Grenade');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M900.M900MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyRifleRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.F2000Pickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticProExp.F2000.F2000Pickup'
     InventoryType=Class'BWBPRecolorsPro.F2000AssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the MARS-3 'Snowstorm' XII."
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.F2000.F2000Pickup'
     Physics=PHYS_None
     DrawScale=0.750000
     CollisionHeight=4.000000
}
