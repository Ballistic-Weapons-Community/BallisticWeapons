//=============================================================================
// HealthKit.
//
// A HealthKit worth 35 health.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IP_Healthkit extends TournamentHealth;

function AnnouncePickup( Pawn Receiver )
{
	Receiver.HandlePickup(self);
	PlaySound( PickupSound,SLOT_Interact,TransientSoundVolume, ,TransientSoundRadius );
}

defaultproperties
{
     HealingAmount=35
     bAmbientGlow=False
     PickupMessage="You picked up a Health Kit +"
     PickupSound=Sound'BallisticSounds2.Health.HealthKitPickup'
     PickupForce="HealthPack"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BallisticHardware2.Health.HealthKit'
     AmbientGlow=0
     ScaleGlow=0.600000
     TransientSoundVolume=0.700000
     TransientSoundRadius=64.000000
     CollisionRadius=16.000000
     CollisionHeight=6.000000
     MessageClass=Class'BCoreProV55.BallisticPickupMessage'
}
