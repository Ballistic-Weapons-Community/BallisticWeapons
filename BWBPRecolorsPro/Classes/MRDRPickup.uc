//=============================================================================
// MRDRPickup.
//=============================================================================
class MRDRPickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
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
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.MRDR.MRDR-Main');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.MRDR.MRDR-Spec');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.MRDR.MRDRMuzzleFlash');
}


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.MRDR.MRDR-Main');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.MRDR.MRDR-Spec');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.MRDR.MRDRMuzzleFlash');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.MRDR.MRDR88AmmoPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.MRDR.MRDR88Pickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticPro.MRDR.MRDR88Pickup'
     PickupDrawScale=0.250000
     InventoryType=Class'BWBPRecolorsPro.MRDRMachinePistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the MR-DR88 machine pistol."
     PickupSound=Sound'BallisticSounds2.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.MRDR.MRDR88Pickup'
     Physics=PHYS_None
     DrawScale=0.500000
     PrePivot=(Y=-16.000000)
     CollisionHeight=4.000000
}
