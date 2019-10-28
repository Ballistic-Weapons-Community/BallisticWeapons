//=============================================================================
// red bullets.
//=============================================================================
class LK05Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticRecolors4TexPro.utx
#exec OBJ LOAD FILE=BallisticRecolors4StaticProExp.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M30A2.M30A2-Laser');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LK05.LK05-EOTech-RDS');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LK05.LK05-Grip');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LK05.LK05-LAM');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LK05.LK05-Mag');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LK05.LK05-Receiver');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LK05.LK05-Silencer');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LK05.LK05-Stock');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LK05.LK05-VertFlash');
}


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.M30A2.M30A2-Laser');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LK05.LK05-EOTech-RDS');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LK05.LK05-Grip');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LK05.LK05-LAM');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LK05.LK05-Mag');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LK05.LK05-Receiver');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LK05.LK05-Silencer');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LK05.LK05-Stock');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LK05.LK05-VertFlash');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.LK05.LK05Pickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.LK05.LK05PickupLow');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticProExp.LK05.LK05PickupLow'
     InventoryType=Class'BWBPRecolorsPro.LK05Carbine'
     RespawnTime=20.000000
     PickupMessage="You picked up the LK-05 advanced carbine."
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.LK05.LK05Pickup'
     Physics=PHYS_None
     CollisionHeight=4.000000
}
