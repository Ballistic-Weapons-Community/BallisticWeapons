//=============================================================================
// HealthKit.
//
// A HealthKit worth 100 health.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IP_SuperHealthkit extends TournamentHealth;

function AnnouncePickup( Pawn Receiver )
{
	Receiver.HandlePickup(self);
	PlaySound( PickupSound,SLOT_Interact,TransientSoundVolume, ,TransientSoundRadius );
}

defaultproperties
{
     HealingAmount=200
     bSuperHeal=True
     bAmbientGlow=False
     RespawnTime=60.000000
	 bPredictRespawns=True
     PickupMessage="You picked up a Super Health Kit +"
     PickupSound=Sound'BW_Core_WeaponSound.Health.SuperHealthPickup'
     PickupForce="LargeHealthPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Health.SuperHealth'
     DrawScale=0.800000
     AmbientGlow=0
     ScaleGlow=0.600000
     TransientSoundVolume=0.600000
     TransientSoundRadius=64.000000
     CollisionRadius=16.000000
     CollisionHeight=22.000000
     MessageClass=Class'BCoreProV55.BallisticPickupMessage'
}
