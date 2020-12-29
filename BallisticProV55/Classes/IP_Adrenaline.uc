//=============================================================================
// IP_Adrenaline
//=============================================================================
class IP_Adrenaline extends TournamentPickUp;

var() float AdrenalineAmount;

/* DetourWeight()
value of this path to take a quick detour (usually 0, used when on route to distant objective, but want to grab inventory for example)
*/
function float DetourWeight(Pawn Other,float PathWeight)
{
	if ( !Other.Controller.NeedsAdrenaline() )
		return 0;
	return MaxDesireability;
}

event float BotDesireability(Pawn Bot)
{
	if ( Bot.Controller.bHuntPlayer )
		return 0;
	if ( !Bot.Controller.NeedsAdrenaline() )
		return 0;
	return MaxDesireability;
}

auto state Pickup
{
	function Touch( actor Other )
	{
        local Pawn P;

		if ( ValidTouch(Other) )
		{
            P = Pawn(Other);
    		P.Controller.AwardAdrenaline(AdrenalineAmount);
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
     AdrenalineAmount=3.000000
     MaxDesireability=0.300000
     bAmbientGlow=False
     RespawnTime=30.000000
     PickupMessage="Adrenaline +3"
     PickupSound=Sound'BW_Core_WeaponSound.Health.AdrenalinPickup'
     PickupForce="AdrenelinPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Health.A-Pod'
     DrawScale=0.150000
     TransientSoundRadius=64.000000
     CollisionRadius=8.000000
     CollisionHeight=8.500000
     Mass=10.000000
     MessageClass=Class'BCoreProV55.BallisticPickupMessage'
}
