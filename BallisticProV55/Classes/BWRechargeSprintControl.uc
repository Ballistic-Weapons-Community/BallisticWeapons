//=============================================================================
// Recharge delay sprint control
//
// Sprint has a recharge delay when released or emptied.
// Also some fixes for speed here.
//
// Azarael
//=============================================================================
class BWRechargeSprintControl extends BCSprintControl;

const SPRINT_INTERVAL = 2.25;

replication
{
	reliable if (Role == ROLE_Authority)
		ClientDelayRecharge;
}

// If Sprint not active, return
// Sprint not active
// Multiply groundspeed
singular function StopSprint()
{
	if (!bSprintActive)
		return;

	bSprintActive=False;

	if (Instigator != None)
		UpdateSpeed();

	SprintRechargeDelay = Level.TimeSeconds + SPRINT_INTERVAL;
	ClientDelayRecharge(SPRINT_INTERVAL);
}

simulated function OwnerEvent(name EventName)
{
	super(Inventory).OwnerEvent(EventName);
	
	if (EventName == 'Dodged')
	{
		if (bSprintActive)
		{
			ClientJumped();
			Stamina = FMax(0, Stamina - StaminaDrainRate * 2);
			SprintRechargeDelay = Level.TimeSeconds + SPRINT_INTERVAL;
		}
		else
		{
			SprintRechargeDelay = Level.TimeSeconds + SPRINT_INTERVAL;
			ClientDelayRecharge(SPRINT_INTERVAL);
		}
	}
	else if (EventName == 'Jumped')
	{
		SprintRechargeDelay = Level.TimeSeconds + SPRINT_INTERVAL;
		ClientDelayRecharge(SPRINT_INTERVAL);
	}
}

simulated function ClientDelayRecharge(float Delay)
{
	SprintRechargeDelay = Level.TimeSeconds + SPRINT_INTERVAL;
}

simulated function ClientJumped()
{
	if (level.NetMode != NM_Client)
		return;
	SprintRechargeDelay = Level.TimeSeconds + SPRINT_INTERVAL;
	Stamina = FMax(0, Stamina - StaminaDrainRate * 2);
}



defaultproperties
{

}
