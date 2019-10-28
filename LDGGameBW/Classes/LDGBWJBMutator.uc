class LDGBWJBMutator extends DMMutator
	HideDropDown
	CacheExempt;

function bool IsRelevant(Actor Other, out byte bSuperRelevant)
{
	if (LDGBallisticJB(Level.Game) != None)
	{		
		if (Other.IsA('LDGUserFlagsServer'))
		{
			LDGBallisticJB(Level.Game).FlagsServer = LDGUserFlagsServer(Other);
			LDGUserFlagsServer(Other).RcvdFor = LDGBallisticJB(Level.Game).ReceivedPlayerFlags;
		}
		else if (Other.IsA('LDGAbstractBalancer'))
			LDGBallisticJB(Level.Game).TeamBalancer = LDGAbstractBalancer(Other);
	}
	
	return Super.IsRelevant(Other, bSuperRelevant);
}

defaultproperties
{
}
