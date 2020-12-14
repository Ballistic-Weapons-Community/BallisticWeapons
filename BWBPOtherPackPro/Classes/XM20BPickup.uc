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

#exec OBJ LOAD FILE=BWBP_SKC_TexExp.utx
#exec OBJ LOAD FILE=BWBP_SKC_StaticExp.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.XM20.XM20-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.XM20.XM20-Misc');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.XM20.XM20-ScreenBase');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_StaticExp.XM20.XM20_Pickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_StaticExp.XM20.XM20_Pickup'
     InventoryType=Class'BWBPOtherPackPro.XM20BCarbine'
     RespawnTime=20.000000
     PickupMessage="You picked up the XM-20 Laser Carbine."
     PickupSound=Sound'BWBP_SKC_Sounds.LS14.Gauss-Pickup'
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.XM20.XM20_Pickup'
     Physics=PHYS_None
     DrawScale=1.000000
     PickupDrawScale=1.000000
     CollisionHeight=3.000000
}
