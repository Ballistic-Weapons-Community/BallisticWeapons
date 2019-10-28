//=============================================================================
// AH104Pickup.
//=============================================================================
class BulldogPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors3TexPro.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.Bulldog.Bulldog-Main');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.Bulldog.Bulldog-Spec');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.Bulldog.BulldogSmokeCore');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.Bulldog.BullDogAmmo');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.Bulldog.BOLTbrass');;
	L.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.Bulldog.Frag12BrassNew');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.Bulldog.Frag12BrassUsed');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.Bulldog.Frag12Proj');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.Bulldog.Bulldog-Main');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.Bulldog.Bulldog-Spec');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.Bulldog.BulldogSmokeCore');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.Bulldog.BullDogAmmo');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.Bulldog.BOLTbrass');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.Bulldog.BullDogAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.Bulldog.BullDogAmmoGL');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.Bulldog.BullDogPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.Bulldog.BullDogPickupLow');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.Bulldog.Frag12BrassNew');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.Bulldog.Frag12BrassUsed');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.Bulldog.Frag12Proj');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticPro.Bulldog.BullDogPickupLow'
     PickupDrawScale=5.000000
     InventoryType=Class'BWBPRecolorsPro.BulldogAssaultCannon'
     RespawnTime=10.000000
     PickupMessage="You picked up the Bulldog autocannon."
     PickupSound=Sound'BallisticSounds2.M806.M806Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.Bulldog.BullDogPickupHi'
     Physics=PHYS_None
     DrawScale=10.000000
     CollisionHeight=4.000000
}
