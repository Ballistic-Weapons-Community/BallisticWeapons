//=============================================================================
// Mk781Pickup.
//=============================================================================
class Mk781Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M1014.M1014-Main');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M1014.M1014-Misc');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M1014.M1014-SpecMap');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyShell');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M1014.M1014-Main');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M1014.M1014-Misc');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Concrete');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.M1014.M1014Pickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.M1014.M1014PickupLow');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M763.M763MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M763.M763Flash1');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyShell');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Ammo.M763ShellBox');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticProExp.M1014.M1014PickupLow'
     PickupDrawScale=1.000000
     InventoryType=Class'BWBPRecolorsPro.MK781Shotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the MK781 combat shotgun."
     PickupSound=Sound'BallisticSounds2.M763.M763Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.M1014.M1014Pickup'
     Physics=PHYS_None
     CollisionHeight=3.000000
}
