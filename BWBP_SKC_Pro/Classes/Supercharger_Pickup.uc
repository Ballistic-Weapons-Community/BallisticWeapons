//=============================================================================
// M50Pickup.
//=============================================================================
class Supercharger_Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

var float	HeatLevel;
var float	HeatTime;

simulated function UpdatePrecacheMaterials()
{
}
simulated function UpdatePrecacheStaticMeshes()
{
}

function InitDroppedPickupFor(Inventory Inv)
{
    Super.InitDroppedPickupFor(Inv);

    if (Supercharger_AssaultWeapon(Inv) != None)
    {
    	HeatLevel = Supercharger_AssaultWeapon(Inv).HeatLevel;
    	HeatTime = level.TimeSeconds;
    }
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.LightningGun.LighterPickupLD'
     InventoryType=Class'BWBP_SKC_Pro.Supercharger_AssaultWeapon'
     RespawnTime=20.000000
     PickupMessage="You picked up something"
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.LightningGun.LighterPickupHD'
     Physics=PHYS_None
     DrawScale=2.350000
     CollisionHeight=4.000000
}
