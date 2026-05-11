//=============================================================================
// Bandage.
//
// A Bandage worth 5 health.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IP_Bandage extends TournamentHealth;

function AnnouncePickup( Pawn Receiver )
{
	Receiver.HandlePickup(self);
	PlaySound( PickupSound,SLOT_Interact,TransientSoundVolume, ,TransientSoundRadius );
}

defaultproperties
{
     HealingAmount=5
     bSuperHeal=True
     MaxDesireability=0.300000
     bAmbientGlow=False
     PickupMessage="You picked up an N-TOV Bandage +"
     PickupSound=Sound'BW_Core_WeaponSound.Health.NTovPickup'
     PickupForce="HealthPack"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Health.Bandage'
     AmbientGlow=0
     ScaleGlow=0.600000
     TransientSoundRadius=64.000000
     PrePivot=(Z=20.500000)
     CollisionRadius=10.000000
     CollisionHeight=20.000000
     MessageClass=Class'BCoreProV55.BallisticPickupMessage'
}
