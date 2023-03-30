//====================================================
// Transient actor spawned when a player dismounts a turret.
// Spawns the turret's weapon for the player after a short delay.
// Explicit ack now to fix this crap once and for all.
//====================================================
class BallisticTurretIntermediary extends Actor;

var Pawn myPawn;
var class<BallisticWeapon> GunClass;
var BallisticWeapon BW;
var int MagAmmo;
var byte LayoutIndex;
var byte CamoIndex;
var int TurretAmmoAmount;
var int WeaponMode;

replication
{
	reliable if (Role == ROLE_Authority)
		GunClass, ClientConfirmWeaponReceived;
	reliable if (Role < ROLE_Authority)
		ServerAcknowledgeWepReceive;
}

function PostBeginPlay()
{
	SetTimer(0.2, False);
}

//===========================================================================
// Timer
//
// On server, continually sends the gun to the client until acknowledgement of its reception.
// On client, acks after a short delay if the gun was received.
//===========================================================================
simulated function Timer()
{	
	if (Role == ROLE_Authority)
	{
		if (myPawn == None || myPawn.Health == 0)
		{
			Destroy();
			return;
		}
		
		if (BW != None)
			BW.Destroy();
		
		//wait for client ack before trying to spawn the gun
		//bots don't undeploy
		if (myPawn.Controller != None && PlayerController(myPawn.Controller).AcknowledgedPawn == myPawn)
		{
			BW = spawn(GunClass,myPawn,,, rot(0,0,0));
		
			if (BW != None)
			{
				BW.GiveTo(myPawn);
				BW.MagAmmo = MagAmmo;
				BW.LayoutIndex = LayoutIndex;
				BW.CamoIndex = CamoIndex;
				BW.SetAmmoTo(TurretAmmoAmount, 0);
				BW.CurrentWeaponMode = WeaponMode;
			}
			
			ClientConfirmWeaponReceived();
		}
		
		SetTimer(1, False);
	}
	
	else	if (Controller(Owner).Pawn.FindInventoryType(GunClass) != None)
		ServerAcknowledgeWepReceive();
}

simulated function ClientConfirmWeaponReceived()
{
	SetTimer(0.1, false);
}

function ServerAcknowledgeWepReceive()
{
	SetTimer(0.0, false);
	Destroy();
}

defaultproperties
{
     bHidden=True
     bOnlyRelevantToOwner=True
     RemoteRole=ROLE_SimulatedProxy
}
