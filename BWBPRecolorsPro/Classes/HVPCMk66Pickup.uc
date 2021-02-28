//=============================================================================
// HVCMk9Pickup.
//=============================================================================
class HVPCMk66Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx


var float	HeatLevel;
var float	HeatTime;

function InitDroppedPickupFor(Inventory Inv)
{
    Super.InitDroppedPickupFor(Inv);

    if (HVPCMk66PlasmaCannon(Inv) != None)
    {
    	HeatLevel = HVPCMk66PlasmaCannon(Inv).HeatLevel;
    	HeatTime = level.TimeSeconds;
    }
}



simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.BFG.BFG-Skin');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Lighter.LightGlassSkin');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.XavPlasCannon.XavPackSkin');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.XavPlasCannon.XavAmmoSkin');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.SparkA1');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.FlareC2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.LightningBolt2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.LightningBoltCut2');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.LightningGun.LighterAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.LightningGun.LighterPack');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.LightningGun.LighterPickupHD');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.LightningGun.LighterPickupLD');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.LightningGun.LighterPickupLD'
     PickupDrawScale=0.250000
     InventoryType=Class'BWBPRecolorsPro.HVPCMk66PlasmaCannon'
     RespawnTime=180.000000
     PickupMessage="You got the Extreme-Voltage Hyper Plasma Cannon 9000."
     PickupSound=Sound'BW_Core_WeaponSound.LightningGun.LG-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.LightningGun.LighterPickupHD'
     Physics=PHYS_None
     DrawScale=0.400000
     PrePivot=(Z=-3.000000)
     Skins(0)=Texture'BWBP_SKC_Tex.BFG.BFG-Skin'
     Skins(1)=FinalBlend'BW_Core_WeaponTex.Lighter.LightGlassFinal'
     Skins(2)=Texture'BWBP_SKC_Tex.XavPlasCannon.XavPackSkin'
     CollisionHeight=4.500000
}
