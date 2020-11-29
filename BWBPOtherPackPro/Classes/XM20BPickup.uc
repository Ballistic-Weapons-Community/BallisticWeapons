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
class XM20BPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBPSomeOtherPackTex.utx
#exec OBJ LOAD FILE=BWBPSomeOtherPackStatic.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBPSomeOtherPackTex.XM20B.XM20-Main');
	Level.AddPrecacheMaterial(Texture'BWBPSomeOtherPackTex.XM20B.XM20-Misc');
	Level.AddPrecacheMaterial(Texture'BWBPSomeOtherPackTex.XM20B.XM20-ScreenBase');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPSomeOtherPackStatic.XM20B.XM20_Pickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPSomeOtherPackStatic.XM20B.XM20_Pickup'
     InventoryType=Class'BWBPOtherPackPro.XM20BCarbine'
     RespawnTime=20.000000
     PickupMessage="You picked up the XM-20 Laser Carbine."
     PickupSound=Sound'PackageSounds4Pro.LS14.Gauss-Pickup'
     StaticMesh=StaticMesh'BWBPSomeOtherPackStatic.XM20B.XM20_Pickup'
     Physics=PHYS_None
     DrawScale=1.000000
     PickupDrawScale=1.000000
     CollisionHeight=3.000000
}
