//=============================================================================
// IP_BigArmor
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IP_BigArmor extends ShieldPickup;

defaultproperties
{
     MaxDesireability=1.500000
     InventoryType=Class'BallisticProV55.BallisticArmor'
	 ShieldAmount=150
     RespawnTime=60.000000
	 bPredictRespawns=True
     PickupMessage="You picked up heavy combat armor +"
     PickupSound=Sound'BW_Core_WeaponSound.Armor.BigArmorPickup'
     PickupForce="LargeShieldPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Armor.BigArmor'
     DrawScale=0.500000
     TransientSoundVolume=0.500000
     TransientSoundRadius=64.000000
     CollisionRadius=16.000000
     CollisionHeight=20.000000
     MessageClass=Class'BCoreProV55.BallisticPickupMessage'
}
