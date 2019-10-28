//=============================================================================
// HVCMk9Pickup.
//=============================================================================
class HVCMk9Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP2-Tex.utx
#exec OBJ LOAD FILE=BWBP2-FX.utx
#exec OBJ LOAD FILE=BWBP2Hardware.usx

var float	HeatLevel;
var float	HeatTime;

function SetWeaponStay()
{
	bWeaponStay = false;
}

function float GetRespawnTime()
{
	return RespawnTime;
}

function InitDroppedPickupFor(Inventory Inv)
{
    Super.InitDroppedPickupFor(None);

    if (HVCMk9LightningGun(Inv) != None)
    {
    	HeatLevel = HVCMk9LightningGun(Inv).HeatLevel;
    	HeatTime = level.TimeSeconds;
    }
}

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP2-Tex.Lighter.LightGunSkin');
	L.AddPrecacheMaterial(Texture'BWBP2-Tex.Lighter.LightGlassSkin');
	L.AddPrecacheMaterial(Texture'BWBP2-Tex.Lighter.LighterPackSkin');
	L.AddPrecacheMaterial(Texture'BWBP2-Tex.Lighter.LighterAmmoSkin');
	L.AddPrecacheMaterial(Texture'BWBP2-FX.Particles.SparkA1');
	L.AddPrecacheMaterial(Texture'BWBP2-FX.Particles.FlareC2');
	L.AddPrecacheMaterial(Texture'BWBP2-FX.Particles.LightningBolt2');
	L.AddPrecacheMaterial(Texture'BWBP2-FX.Particles.LightningBoltCut2');
	
	L.AddPrecacheStaticMesh(StaticMesh'BWBP2Hardware.LightningGun.LighterPack');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP2-Tex.Lighter.LightGunSkin');
	Level.AddPrecacheMaterial(Texture'BWBP2-Tex.Lighter.LightGlassSkin');
	Level.AddPrecacheMaterial(Texture'BWBP2-Tex.Lighter.LighterPackSkin');
	Level.AddPrecacheMaterial(Texture'BWBP2-Tex.Lighter.LighterAmmoSkin');
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
     InventoryType=Class'BallisticProV55.HVCMk9LightningGun'
     RespawnTime=120.000000
     PickupMessage="You got the HVC-Mk9 lightning gun."
     PickupSound=Sound'BWBP2-Sounds.LightningGun.LG-Putaway'
     StaticMesh=StaticMesh'BWBP2Hardware.LightningGun.LighterPickupHD'
     Physics=PHYS_None
     DrawScale=0.400000
     PrePivot=(Z=-3.000000)
     CollisionHeight=4.500000
}
