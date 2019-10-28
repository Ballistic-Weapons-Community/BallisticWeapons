//=============================================================================
// KarmaTopSpeedLimitVolume.
//=============================================================================
class KarmaTopSpeedLimitVolume extends PhysicsVolume;

var() float KMaxSpeed;

simulated event PawnEnteredVolume(Pawn Other)
{
	if (Other.IsA('SVehicle') && Other.KParams != None && Other.KParams.IsA('KarmaParams'))
		KarmaParams(Other.KParams).KMaxSpeed = KMaxSpeed;
}

simulated event PawnLeavingVolume(Pawn Other)
{
	if (Other.IsA('SVehicle') && Other.KParams != None && Other.KParams.IsA('KarmaParamsRBFull'))
		KarmaParams(Other.KParams).KMaxSpeed = KarmaParamsRBFull(Other.default.KParams).KMaxSpeed;
}

simulated event PlayerPawnDiedInVolume(Pawn Other)
{
	if (Other.IsA('SVehicle') && Other.KParams != None && Other.KParams.IsA('KarmaParamsRBFull'))
		KarmaParams(Other.KParams).KMaxSpeed = KarmaParams(Other.default.KParams).KMaxSpeed;
}

defaultproperties
{
     KMaxSpeed=2500.000000
}
