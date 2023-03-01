//=============================================================================
// Recharge delay sprint control
//
// Sprint has a recharge delay when released or emptied.
// Also some fixes for speed here.
//
// Azarael
//=============================================================================
class BWRechargeSprintControl extends BCSprintControl;

const RECHARGE_DELAY = 1.5f;

replication
{
	reliable if (Role == ROLE_Authority)
		ClientDelayRecharge, ClientDodged;
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

    if (SprintRechargeDelay < Level.TimeSeconds + RECHARGE_DELAY)
    {
        SprintRechargeDelay = Level.TimeSeconds + RECHARGE_DELAY;
        ClientDelayRecharge(RECHARGE_DELAY);
    }
}

simulated function OwnerEvent(name EventName)
{
	super(Inventory).OwnerEvent(EventName);
	
	if (EventName == 'Dodged')
	{
        SprintRechargeDelay = Level.TimeSeconds + RECHARGE_DELAY;
        ClientDelayRecharge(RECHARGE_DELAY);
	}
}

simulated function ClientDelayRecharge(float Delay)
{
	SprintRechargeDelay = Level.TimeSeconds + Delay;
}

simulated function ClientDodged()
{
	if (level.NetMode != NM_Client)
		return;

	SprintRechargeDelay = Level.TimeSeconds + RECHARGE_DELAY;
	Stamina = FMax(0, Stamina - StaminaDrainRate * 2);
}

defaultproperties
{

}
