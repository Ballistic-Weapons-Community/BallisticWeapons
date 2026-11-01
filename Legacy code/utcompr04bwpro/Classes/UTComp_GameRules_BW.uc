class UTComp_GameRules_BW extends UTComp_GameRules;

function bool IsFarming(Controller C, optional bool bAllowSentinel)
{
	local UTComp_PRI uPRI;
	
	if (!UTCompMutator.bNoVehicleFarming)
		return false;

	if (ASVehicle_Sentinel(C.Pawn) != None && UnrealPlayer(C) == None && Bot(C) == None)
		return !bAllowSentinel;

	uPRI = class'UTComp_Util'.static.GetUTCompPRIFor(C);
	
	if (uPRI != None)
		return uPRI.InAVehicle || (Level.TimeSeconds - uPRI.VehicleExitTime < 0.5);
		
	return true;
}

defaultproperties
{
}
