//=============================================================================
// IP_SmallArmor
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IP_SmallArmor extends ShieldPickup;

var() StaticMesh AlternateMesh;

// Two different appearances
simulated function PostBeginplay()
{
	if (FRand() > 0.5)
		SetStaticMesh(AlternateMesh);

	super.PostBeginPlay();
}

defaultproperties
{
     AlternateMesh=StaticMesh'BW_Core_WeaponStatic.Armor.SmallArmor2'
     ShieldAmount=75
     MaxDesireability=1.000000
     InventoryType=Class'BallisticProV55.BallisticArmor'
     RespawnTime=30.000000
	 bPredictRespawns=True
     PickupMessage="You picked up a vest and helmet +"
     PickupSound=Sound'BW_Core_WeaponSound.Armor.LightArmorPickup'
     PickupForce="ShieldPack"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Armor.SmallArmor'
     DrawScale=0.500000
     TransientSoundVolume=0.500000
     TransientSoundRadius=64.000000
     CollisionRadius=16.000000
     CollisionHeight=18.000000
     MessageClass=Class'BCoreProV55.BallisticPickupMessage'
}
