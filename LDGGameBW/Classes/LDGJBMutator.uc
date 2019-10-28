class LDGJBMutator extends DMMutator
	HideDropDown
	CacheExempt;
	
function bool IsRelevant(Actor Other, out byte bSuperRelevant)
{
	if ( Controller(Other) != None && MessagingSpectator(Other) == None )
		Controller(Other).PlayerReplicationInfoClass = class'LDGJBPlayerReplicationInfo';

	return Super.IsRelevant(Other, bSuperRelevant);
}

defaultproperties
{
}
