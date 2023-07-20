//=============================================================================
// The XMB500's pickup.
//=============================================================================
class XMV500Pickup extends XMV850Pickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx

simulated function UpdatePrecacheMaterials()
{
//	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.XMV500.XMV500_Main');
//	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.XMV500.XMV500_Barrels');
//	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.XMV500.XMV500_BackPack');
}

defaultproperties
{
     InventoryType=Class'BWBP_SKC_Pro.XMV500Minigun'
     PickupMessage="You picked up the XMB-500 Smart Minigun"
     //Skins(0)=Texture'BWBP_SKC_Tex.XMV500.XMV500_Main'
     //Skins(1)=Shader'BWBP_SKC_Tex.XMV500.XMV500_Barrels_SD'
     //Skins(2)=Texture'BWBP_SKC_Tex.XMV500.XMV500_BackPack'
}
