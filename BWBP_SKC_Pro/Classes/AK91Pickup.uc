//=============================================================================
//[6/18/2013 5:48:03 PM] Sgt Kelly: HUNGRY and ANGRY are SIMILAR WORDS
//[6/18/2013 5:48:08 PM] Sgt Kelly: THAT ANGERS ME
//[6/18/2013 5:48:20 PM] Captain Xavious: RAAAAAGH MUST EAT IT
//[6/18/2013 5:48:33 PM] Sgt Kelly: GRAAAGH TOO MANY SYLLABLES
//[6/18/2013 5:48:51 PM] Captain Xavious: RRAHGAHRAJG
//[6/18/2013 5:49:02 PM] Sgt Kelly: GRAAARAGRAHGHGH
//[6/18/2013 5:49:10 PM] Sgt Kelly: *FLEX*
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
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.AK91.AK91PickupLo'
     InventoryType=Class'BWBP_SKC_Pro.AK91ChargeRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the AK-91 Charge Rifle"
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.AK91.AK91PickupHi'
     Physics=PHYS_None
     DrawScale=0.250000
     PickupDrawScale=0.250000
     CollisionHeight=4.000000
}
