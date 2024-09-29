//=============================================================================
// XM20Pickup.
//
//Azarael: " A U T O   L A S "
//Azarael: It's a rifle
//Azarael: It shoots lasers
//Azarael: Therefore, it's a laser rifle
//TheXavious: Its not a fucking rifle
//Jiffy: More like "Auto Lad" for the the rite lads in this server
//
//=============================================================================
class XM20Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.XM20.XM20-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.XM20.XM20-Misc');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.XM20.XM20-ScreenBase');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.XM20.XM20PickupHi');
     Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.XM20.XM20PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.XM20.XM20PickupLo'
     InventoryType=Class'BWBP_SKC_Pro.XM20Carbine'
     RespawnTime=20.000000
     PickupMessage="You picked up the XM-20 Laser Carbine."
     PickupSound=Sound'BWBP_SKC_Sounds.LS14.Gauss-Pickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.XM20.XM20PickupHi'
     Physics=PHYS_None
     DrawScale=1.100000
     PickupDrawScale=1.000000
     CollisionHeight=3.000000
}
