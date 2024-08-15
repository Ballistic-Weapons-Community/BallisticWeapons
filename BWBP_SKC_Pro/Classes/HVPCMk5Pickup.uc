//=============================================================================
// HVCMk9Pickup.
//=============================================================================
class HVPCMk5Pickup extends BallisticWeaponPickup
	placeable;

var float	HeatLevel;
var float	HeatTime;

function InitDroppedPickupFor(Inventory Inv)
{
    Super.InitDroppedPickupFor(Inv);

    if (HVPCMk5PlasmaCannon(Inv) != None)
    {
    	HeatLevel = HVPCMk5PlasmaCannon(Inv).HeatLevel;
    	HeatTime = level.TimeSeconds;
    }
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.HVPC.HVPCPickupLo'
     PickupDrawScale=0.100000
     InventoryType=Class'BWBP_SKC_Pro.HVPCMk5PlasmaCannon'
     RespawnTime=20.000000
     PickupMessage="You got the High-Voltage Plasma Cannon Mk5"
     PickupSound=Sound'BW_Core_WeaponSound.LightningGun.LG-Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.HVPC.HVPCPickupHi'
     Physics=PHYS_None
     DrawScale=0.100000
     PrePivot=(Z=-3.000000)
     CollisionHeight=4.500000
}
