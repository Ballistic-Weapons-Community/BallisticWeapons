class LDGUserFlagsServer extends Actor
	abstract;

function string GetFor(PlayerController PC);
function OnS(LDGUserFlag f);
delegate RcvdFor(PlayerController PC, string f)
{
}

defaultproperties
{
}
