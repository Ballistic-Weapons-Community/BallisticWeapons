//=============================================================================
// Recharge delay sprint control
//
// Sprint has a recharge delay when released or emptied.
// Also some fixes for speed here.
//
// Azarael
//=============================================================================
class BWRechargeSprintControl extends BCSprintControl;

const SHORT_RECHARGE_DELAY = 0.5f;
const LONG_RECHARGE_DELAY = 2f;

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

    if (SprintRechargeDelay < Level.TimeSeconds + SHORT_RECHARGE_DELAY)
    {
        SprintRechargeDelay = Level.TimeSeconds + SHORT_RECHARGE_DELAY;
        ClientDelayRecharge(SHORT_RECHARGE_DELAY);
    }
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
			SprintRechargeDelay = Level.TimeSeconds + LONG_RECHARGE_DELAY;
		}
		else
		{
			SprintRechargeDelay = Level.TimeSeconds + LONG_RECHARGE_DELAY;
			ClientDelayRecharge(LONG_RECHARGE_DELAY);
		}
	}
	else if (EventName == 'Jumped')
	{
		SprintRechargeDelay = Level.TimeSeconds + LONG_RECHARGE_DELAY;
		ClientDelayRecharge(LONG_RECHARGE_DELAY);
	}
}

simulated function ClientDelayRecharge(float Delay)
{
	SprintRechargeDelay = Level.TimeSeconds + Delay;
}

simulated function ClientJumped()
{
	if (level.NetMode != NM_Client)
		return;

	SprintRechargeDelay = Level.TimeSeconds + LONG_RECHARGE_DELAY;
	Stamina = FMax(0, Stamina - StaminaDrainRate * 2);
}

defaultproperties
{

}
