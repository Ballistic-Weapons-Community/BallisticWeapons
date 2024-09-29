//=============================================================================
// HVCMk9Pickup.
//=============================================================================
class HVCMk9Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

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
    Super.InitDroppedPickupFor(Inv);

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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Lighter.LightGunSkin');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Lighter.LightGlassSkin');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Lighter.LighterPackSkin');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Lighter.LighterAmmoSkin');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.SparkA1');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.FlareC2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.LightningBolt2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.LightningBoltCut2');
	
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.LightningGun.LighterPack');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Lighter.LightGunSkin');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Lighter.LightGlassSkin');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Lighter.LighterPackSkin');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Lighter.LighterAmmoSkin');
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
     InventoryType=Class'BallisticProV55.HVCMk9LightningGun'
     RespawnTime=120.000000
     PickupMessage="You got the HVC-Mk9 lightning gun."
     PickupSound=Sound'BW_Core_WeaponSound.LightningGun.LG-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.LightningGun.LighterPickupHD'
     Physics=PHYS_None
     DrawScale=0.280000
     PrePivot=(Z=-3.000000)
     CollisionHeight=4.500000
}
