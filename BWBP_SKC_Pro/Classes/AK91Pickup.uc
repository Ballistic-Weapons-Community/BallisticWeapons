//=============================================================================
//[6/18/2013 5:48:03 PM] Marc Moylan: HUNGRY and ANGRY are SIMILAR WORDS
//[6/18/2013 5:48:08 PM] Marc Moylan: THAT ANGERS ME
//[6/18/2013 5:48:20 PM] Captain Xavious: RAAAAAGH MUST EAT IT
//[6/18/2013 5:48:33 PM] Marc Moylan: GRAAAGH TOO MANY SYLLABLES
//[6/18/2013 5:48:51 PM] Captain Xavious: RRAHGAHRAJG
//[6/18/2013 5:49:02 PM] Marc Moylan: GRAAARAGRAHGHGH
//[6/18/2013 5:49:10 PM] Marc Moylan: *FLEX*
//[6/18/2013 5:50:22 PM] Captain Xavious: (flex)
//=============================================================================
class AK91Pickup extends BallisticWeaponPickup
	placeable;

var float	HeatLevel;
var float	HeatTime;

function InitDroppedPickupFor(Inventory Inv)
{
    Super.InitDroppedPickupFor(None);

    if (AK91ChargeRifle(Inv) != None)
    {
    	HeatLevel = AK91ChargeRifle(Inv).HeatLevel;
    	HeatTime = level.TimeSeconds;
    }
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.AK490.AK490Pickup'
     InventoryType=Class'BWBP_SKC_Pro.AK91ChargeRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the AK-91 Charge Rifle"
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.AK490.AK490Pickup'
     Physics=PHYS_None
     DrawScale=0.250000
     PickupDrawScale=0.180000
     CollisionHeight=4.000000
}
