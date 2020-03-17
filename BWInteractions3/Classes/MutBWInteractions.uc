class MutBWInteractions extends xMutator 
	transient;

simulated function ClientSideInitialization(PlayerController PC)
{
	AddAnInteraction(PC, string( class'BallisticProInteractions' ));
}

defaultproperties
{
     FriendlyName="Ballistic Bind Menu V3"
     Description="Adds bind support to Ballistic."
}
