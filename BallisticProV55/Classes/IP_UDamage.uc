//=============================================================================
// IP_UDamage.
//
// UDamage that looks different...
//
//=============================================================================
class IP_UDamage extends TournamentPickUp;

auto state Pickup
{
	function Touch( actor Other )
	{
        local Pawn P;

		if ( ValidTouch(Other) )
		{
            P = Pawn(Other);
            P.EnableUDamage(30);
			AnnouncePickup(P);
            SetRespawn();
		}
	}
}

function AnnouncePickup( Pawn Receiver )
{
	Receiver.HandlePickup(self);
	PlaySound( PickupSound,SLOT_Interact,TransientSoundVolume, ,TransientSoundRadius );
}

defaultproperties
{
     MaxDesireability=2.000000
     bAmbientGlow=False
     bPredictRespawns=True
     RespawnTime=90.000000
     PickupMessage="You got the Damage Amplifier."
     PickupSound=Sound'BallisticSounds2.Udamage.UDamagePickup'
     PickupForce="UDamagePickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BallisticHardware2.Misc.U-Damage'
     DrawScale=0.600000
     TransientSoundVolume=0.600000
     TransientSoundRadius=128.000000
     CollisionRadius=16.000000
     CollisionHeight=28.000000
     Mass=10.000000
     MessageClass=Class'BCoreProV55.BallisticPickupMessage'
}
