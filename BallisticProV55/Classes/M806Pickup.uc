//=============================================================================
// M806Pickup.
//=============================================================================
class M806Pickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.M806.M806_Main');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyPistolRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M806.PistolMuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Ammo.M806Clip');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.M806.M806PickupLo'
     PickupDrawScale=0.070000
     InventoryType=Class'BallisticProV55.M806Pistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the M806A2 pistol."
     PickupSound=Sound'BallisticSounds2.M806.M806Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.M806.M806PickupHi'
     Physics=PHYS_None
     DrawScale=0.120000
     CollisionHeight=4.000000
}
