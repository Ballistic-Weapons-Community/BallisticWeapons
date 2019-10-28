//=============================================================================
// Marathon
//
// Infinite sprint
//=============================================================================
class BWMarathonSprintControl extends BWRechargeSprintControl;

singular function StartSprint()
{
	if (Instigator.Physics != PHYS_Walking || bSprintActive || !CheckDirection())
		return;
	bSprintActive = true;
	if (Instigator != None)
	{	
		if (BallisticPawn(Instigator) != None)
			BallisticPawn(Instigator).CalcSpeedUp(SpeedFactor);
		else Instigator.GroundSpeed *= SpeedFactor;
	}
}

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
}

defaultproperties
{
     StaminaDrainRate=0.000000
}
