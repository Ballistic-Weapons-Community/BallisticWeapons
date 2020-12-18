//=============================================================================
// SKASPickup.
//=============================================================================
class SKASPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors3TexPro.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticRecolors4StaticPro.usx
#exec OBJ LOAD FILE=BallisticHardware2.usx


auto state Pickup
{
	function BeginState()
	{
		if (!bDropped && class<BallisticWeapon>(InventoryType) != None)
			MagAmmo = class<BallisticWeapon>(InventoryType).default.MagAmmo;
		Super.BeginState();
	}
}

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.SKAS.SKAS-CamoU');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Concrete');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Metal');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Wood');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M763.M763MuzzleFlash');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M763.M763Flash1');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyShell');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.SKAS.SKAS-CamoU');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Concrete');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Metal');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Wood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M763.M763MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M763.M763Flash1');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyShell');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.SKAS.SKASShotgunAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.SKAS.SKASShotgunPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.SKAS.SKASShotgunPickupLow');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticPro.SKAS.SKASShotgunPickupLow'
     PickupDrawScale=0.600000
     InventoryType=Class'BWBPRecolorsPro.SKASShotgun'
     RespawnTime=90.000000
     PickupMessage="You picked up the SKAS-21 automatic shotgun."
     PickupSound=Sound'BallisticSounds2.M763.M763Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.SKAS.SKASShotgunPickupHi'
     Physics=PHYS_None
     DrawScale=0.600000
     CollisionHeight=3.000000
}
