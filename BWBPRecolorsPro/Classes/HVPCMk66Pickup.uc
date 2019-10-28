//=============================================================================
// HVCMk9Pickup.
//=============================================================================
class HVPCMk66Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP2-Tex.utx
#exec OBJ LOAD FILE=BWBP2-FX.utx
#exec OBJ LOAD FILE=BWBP2Hardware.usx


var float	HeatLevel;
var float	HeatTime;

function InitDroppedPickupFor(Inventory Inv)
{
    Super.InitDroppedPickupFor(None);

    if (HVPCMk66PlasmaCannon(Inv) != None)
    {
    	HeatLevel = HVPCMk66PlasmaCannon(Inv).HeatLevel;
    	HeatTime = level.TimeSeconds;
    }
}



simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.BFG.BFG-Skin');
	Level.AddPrecacheMaterial(Texture'BWBP2-Tex.Lighter.LightGlassSkin');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.XavPlasCannon.XavPackSkin');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.XavPlasCannon.XavAmmoSkin');
	Level.AddPrecacheMaterial(Texture'BWBP2-FX.Particles.SparkA1');
	Level.AddPrecacheMaterial(Texture'BWBP2-FX.Particles.FlareC2');
	Level.AddPrecacheMaterial(Texture'BWBP2-FX.Particles.LightningBolt2');
	Level.AddPrecacheMaterial(Texture'BWBP2-FX.Particles.LightningBoltCut2');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP2Hardware.LightningGun.LighterAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP2Hardware.LightningGun.LighterPack');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP2Hardware.LightningGun.LighterPickupHD');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP2Hardware.LightningGun.LighterPickupLD');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP2Hardware.LightningGun.LighterPickupLD'
     PickupDrawScale=0.250000
     InventoryType=Class'BWBPRecolorsPro.HVPCMk66PlasmaCannon'
     RespawnTime=180.000000
     PickupMessage="You got the Extreme-Voltage Hyper Plasma Cannon 9000."
     PickupSound=Sound'BWBP2-Sounds.LightningGun.LG-Putaway'
     StaticMesh=StaticMesh'BWBP2Hardware.LightningGun.LighterPickupHD'
     Physics=PHYS_None
     DrawScale=0.400000
     PrePivot=(Z=-3.000000)
     Skins(0)=Texture'BallisticRecolors3TexPro.BFG.BFG-Skin'
     Skins(1)=FinalBlend'BWBP2-Tex.Lighter.LightGlassFinal'
     Skins(2)=Texture'BallisticRecolors3TexPro.XavPlasCannon.XavPackSkin'
     CollisionHeight=4.500000
}
