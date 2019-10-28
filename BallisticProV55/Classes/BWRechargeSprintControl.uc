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
var float		SprintRechargeDelay; // Retrigger delay
var float		NextAlignmentCheckTime;

replication
{
	reliable if (Role == ROLE_Authority)
		ClientDelayRecharge;
}

//If Stamina's less than 0 or Sprint's active
//return
singular function StartSprint()
{
	if (Stamina <= 0  || Instigator.Physics != PHYS_Walking || bSprintActive || !CheckDirection())
		return;
	bSprintActive = true;
	if (Instigator != None)
	{	
		if (BallisticPawn(Instigator) != None)
			BallisticPawn(Instigator).CalcSpeedUp(SpeedFactor);
		else Instigator.GroundSpeed *= SpeedFactor;
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
	{
		if (BallisticPawn(Instigator) != None)
			BallisticPawn(Instigator).CalcSpeedUp(1);
		else Instigator.GroundSpeed *= (1/SpeedFactor);
	}
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

simulated function bool CheckDirection()
{
	if (Normal(Instigator.Velocity) Dot Vector(Instigator.Rotation) < 0.2)
		return false;
	NextAlignmentCheckTime=Level.TimeSeconds + 0.35;
	return true;	
}

simulated event Tick(float DT)
{
	// Add a check here to see if sprint can continue
	// Timed, based on dot product of rotation
	// Drain stamina while sprinting
	
	if (Instigator == None)
		Destroy();
		
	if (bSprintActive && Instigator.Physics != PHYS_Falling && VSize(Instigator.Acceleration) > 100 && VSize(Instigator.Velocity) > 50)
	{
		if (!bSprinting)
		{
			bSprinting=true;
			if (BallisticWeapon(Instigator.Weapon) != None)
				BallisticWeapon(Instigator.Weapon).PlayerSprint(true);
			if (Instigator != None && Instigator.Inventory != None)
				Instigator.Inventory.OwnerEvent('StartSprint');
		}
		
		if (Instigator.bIsCrouched)
			Stamina -= StaminaDrainRate * DT * 1.5;
		else Stamina -= StaminaDrainRate * DT;
		if (Role == ROLE_Authority)
		{
			if (Stamina <= 0 || Instigator.Physics != PHYS_Walking ||(Level.TimeSeconds >= NextAlignmentCheckTime && !CheckDirection()))
				StopSprint();
		}
	}
	// Stamina charges when not sprinting
	else// if (VSize(RV) < Instigator.default.GroundSpeed * 0.8)
	{
		if (bSprinting)
		{
			bSprinting=False;
			if (BallisticWeapon(Instigator.Weapon) != None)
				BallisticWeapon(Instigator.Weapon).PlayerSprint(false);
			if (Instigator != None && Instigator.Inventory != None)
				Instigator.Inventory.OwnerEvent('StopSprint');
		}
		if (Stamina < MaxStamina)
		{
			if (VSize(Instigator.Velocity) == 0)
				Stamina += StaminaChargeRate * DT;
			else if (Instigator.bIsCrouched)
				Stamina += StaminaChargeRate * DT/2;
			if (Level.TimeSeconds > SprintRechargeDelay)
				Stamina += StaminaChargeRate * DT;
		}
	}
	Stamina = FClamp(Stamina, 0, MaxStamina);
}

defaultproperties
{
     StaminaDrainRate=15.000000
     StaminaChargeRate=20.000000
}
