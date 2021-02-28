//=============================================================================
// AH104Pickup.
//=============================================================================
class BulldogPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Bulldog.Bulldog-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Bulldog.Bulldog-Spec');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Bulldog.BulldogSmokeCore');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Bulldog.BullDogAmmo');
	
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Bulldog.BOLTbrass');;
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Bulldog.Frag12BrassNew');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Bulldog.Frag12BrassUsed');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Bulldog.Frag12Proj');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Bulldog.Bulldog-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Bulldog.Bulldog-Spec');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Bulldog.BulldogSmokeCore');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Bulldog.BullDogAmmo');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Bulldog.BOLTbrass');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Bulldog.BullDogAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Bulldog.Frag12Ammo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Bulldog.BullDogPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Bulldog.BullDogPickupLow');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Bulldog.Frag12BrassNew');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Bulldog.Frag12BrassUsed');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Bulldog.Frag12Proj');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.Bulldog.BullDogPickupLow'
     PickupDrawScale=5.000000
     InventoryType=Class'BWBP_SKC_Pro.BulldogAssaultCannon'
     RespawnTime=10.000000
     PickupMessage="You picked up the Bulldog autocannon."
     PickupSound=Sound'BW_Core_WeaponSound.M806.M806Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.Bulldog.BullDogPickupHi'
     Physics=PHYS_None
     DrawScale=10.000000
     CollisionHeight=4.000000
}
