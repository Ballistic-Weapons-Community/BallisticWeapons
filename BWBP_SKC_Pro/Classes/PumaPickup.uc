//=============================================================================
// PumaPickup.
//[1:25:41 AM] Marc Moylan: I HATE POSELIB
//[1:25:43 AM] Captain Xavious: lol
//[1:25:44 AM] Marc Moylan: TOO MUCH MOVEMENT
//[1:25:50 AM] Captain Xavious: noooooooo
//=============================================================================
class PumaPickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.PUMA.PUMA2-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.PUMA.PUMA2-Back');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.PUMA.PUMA-MainSpec');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.PUMA.PUMA-BackSpec');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.PUMA.PUMA-ScreenBasic');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.PUMA.PUMA-Shield');
	
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.PUMA.PumaShield');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.PUMA.ShieldShard');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Bulldog.Frag12Proj');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.PUMA.PUMA2-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.PUMA.PUMA2-Back');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.PUMA.PUMA-MainSpec');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.PUMA.PUMA-BackSpec');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.PUMA.PUMA-ScreenBasic');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.PUMA.PUMA-Shield');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Puma.PumaPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Puma.PumaPickupLo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Puma.Puma_SM_Ammo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Puma.PumaShield');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Puma.ShieldShard');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Bulldog.Frag12Proj');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.PUMA.PumaPickupLo'
     PickupDrawScale=0.200000
     InventoryType=Class'BWBP_SKC_Pro.PumaRepeater'
     RespawnTime=20.000000
     PickupMessage="You picked up the PUMA-77 Repeater"
     PickupSound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-Pickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.PUMA.PumaPickupHi'
     Physics=PHYS_None
     DrawScale=0.220000
     CollisionHeight=4.000000
}
