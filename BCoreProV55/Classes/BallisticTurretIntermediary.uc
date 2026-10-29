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
var int WeaponData;
var bool bGaveGun;			// given once, then the client is only asked again whether it has it

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
// On server, gives the gun once and asks the client again until acknowledgement of its reception.
// On client, brings the gun up and acks after a short delay if the gun was received.
//===========================================================================
simulated function Timer()
{	
	local Weapon W;

	if (Role == ROLE_Authority)
	{
		if (myPawn == None || myPawn.Health == 0)
		{
			Destroy();
			return;
		}
		
		//wait for client ack before trying to spawn the gun
		//bots don't undeploy
		if (myPawn.Controller != None && PlayerController(myPawn.Controller).AcknowledgedPawn == myPawn)
		{
			// Given once. The gun was destroyed and a new one given every second until the client answered: when
			// the answer took longer (a round trip over a second, or a busy server), the gun went out of the
			// client's hands and its magazine and ammo back to what they were at the undeploy
			if (!bGaveGun)
			{
				BW = spawn(GunClass,myPawn,,, rot(0,0,0));
			
				if (BW != None)
				{
					bGaveGun = true;
					BW.GenerateLayout(LayoutIndex);
					BW.GenerateCamo(CamoIndex);
					BW.GiveTo(myPawn);
					// GiveTo destroys the new weapon if the pawn has picked up one of this type in the meantime
					if (BW != None)
					{
						BW.MagAmmo = MagAmmo;
						BW.SetAmmoTo(TurretAmmoAmount, 0);
						BW.CurrentWeaponMode = WeaponMode;
						BW.SetTurretData(WeaponData);
					}
				}
			}
			W = Weapon(myPawn.FindInventoryType(GunClass));
			// thrown away before the client answered
			if (bGaveGun && W == None)
			{
				Destroy();
				return;
			}

			// A listen server's own player has the gun now and never acknowledges it: this timer gave it a new one
			// every second, magazine and ammo back to what they were at the undeploy
			if (myPawn.IsLocallyControlled())
			{
				BringUpGun(W);
				Destroy();
				return;
			}
			ClientConfirmWeaponReceived();
		}
		
		SetTimer(1, False);
	}
	
	else
	{
		W = Weapon(Controller(Owner).Pawn.FindInventoryType(GunClass));
		if (W == None)
			return;
		// its ammo or params are still on their way: brought up now, it would come up without them
		if (W.IsInState('PendingClientWeaponSet'))
		{
			SetTimer(0.1, false);
			return;
		}
		BringUpGun(W);
		ServerAcknowledgeWepReceive();
	}
}

// The undeployed gun goes into the hands. GiveTo switches only to a weapon that rates higher than the one held, and
// never with switching on pickup off, so it often stayed away and the player was left holding something else
simulated function BringUpGun(Weapon W)
{
	local Pawn P;

	if (W == None || Controller(Owner) == None)
		return;
	P = Controller(Owner).Pawn;
	if (P == None || P.Weapon == W || P.PendingWeapon == W)
		return;
	Controller(Owner).ClientSetWeapon(GunClass);
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
