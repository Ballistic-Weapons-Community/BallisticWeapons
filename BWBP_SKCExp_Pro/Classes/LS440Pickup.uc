//=============================================================================
// R9Pickup.
//=============================================================================
class LS440Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LS14.LS14-Main');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.LaserCarbine.LaserCarbinePickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.LaserCarbine.PlasmaMuzzleFlash');

}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.LaserCarbine.LaserCarbinePickup'
     InventoryType=Class'BWBP_SKCExp_Pro.LS440Instagib'
     RespawnTime=60.000000
     PickupMessage="You picked up the LS-440M Instagib Rifle"
     PickupSound=Sound'BWBP_SKC_Sounds.LS14.Gauss-Pickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.LaserCarbine.LaserCarbinePickup'
     Physics=PHYS_None
     DrawScale=1.400000
     PickupDrawScale=1.400000
     CollisionHeight=3.000000
     Skins(2)=Shader'BWBP_SKC_TexExp.LS440M.LS440_SD'
     Skins(4)=Shader'BWBP_SKC_TexExp.LS440M.LS440_SD'
}
