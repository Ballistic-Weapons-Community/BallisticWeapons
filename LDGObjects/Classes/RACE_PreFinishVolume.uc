class RACE_PreFinishVolume extends Volume;

var(RACE_PreFinishVolume) int TimeExtensionsMinutes;

var bool bTriggered;

delegate bool OnTouch(PlayerController PC);

function Touch(Actor Other)
{
	if (!bTriggered && ONSVehicle(Other) != None && ONSVehicle(Other).bDriving && !ONSVehicle(Other).bCanFly && PlayerController(ONSVehicle(Other).Controller) != None)
		if (OnTouch(PlayerController(ONSVehicle(Other).Controller)))
			bTriggered=True;
}

defaultproperties
{
}
