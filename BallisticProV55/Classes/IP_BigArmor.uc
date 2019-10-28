//=============================================================================
// IP_BigArmor
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IP_BigArmor extends BallisticArmorPickup;

defaultproperties
{
     MaxDesireability=1.500000
     InventoryType=Class'BallisticProV55.BallisticArmor'
     RespawnTime=55.000000
     PickupMessage="You picked up heavy combat armor."
     PickupSound=Sound'BallisticSounds2.Armor.BigArmorPickup'
     PickupForce="LargeShieldPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BallisticHardware2.Armor.BigArmor'
     DrawScale=0.500000
     TransientSoundVolume=0.500000
     TransientSoundRadius=64.000000
     CollisionRadius=16.000000
     CollisionHeight=20.000000
     MessageClass=Class'BCoreProV55.BallisticPickupMessage'
}
