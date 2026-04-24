//=============================================================================
// BallisticAvoidMarker.
//
// Behavior:
//   - Instigator (OwnerController): always avoids
//   - Same-team bot, FriendlyFire off: does NOT avoid (team-stamp handles it)
//   - Same-team bot, FriendlyFire on : avoids (team-stamp not applied)
//   - Enemy bot                      : always avoids >:(
//=============================================================================
class BallisticAvoidMarker extends AvoidMarker;

var Controller OwnerController;

function bool RelevantTo(Pawn P)
{
	if (AIController(P.Controller) == None)
		return false;

	// Instigator always fears their own fear :)
	if (OwnerController != None && P.Controller == OwnerController)
		return true;

	return Super.RelevantTo(P);
}

defaultproperties
{
}
