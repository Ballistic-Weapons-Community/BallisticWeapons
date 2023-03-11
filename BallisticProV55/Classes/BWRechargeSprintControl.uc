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

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    if (Role == ROLE_Authority)
    {
        if (class'BallisticReplicationInfo'.static.IsArena())
        {
            StaminaDrainRate = 5;
            StaminaChargeRate = 5;
            SpeedFactor = 1.35;
            JumpDrainFactor = 0;
        }

        else if (class'BallisticReplicationInfo'.static.IsTactical())
        {
            StaminaDrainRate = 25;
            StaminaChargeRate = 35;
            SpeedFactor = 1.5;
            JumpDrainFactor = 0;
        }

        else
        {
            StaminaDrainRate = class'Mut_Ballistic'.default.InitStaminaDrainRate;
            StaminaChargeRate = class'Mut_Ballistic'.default.InitStaminaChargeRate;
            SpeedFactor = class'Mut_Ballistic'.default.InitSpeedFactor;
            JumpDrainFactor = class'Mut_Ballistic'.default.JumpDrainFactor;
        }
    }
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
