class LDGBWDMMutator extends DMMutator
	HideDropDown
	CacheExempt;

function bool IsRelevant(Actor Other, out byte bSuperRelevant)
{
	if (LDGBallisticDM(Level.Game) != None)
	{		
		if (Other.IsA('LDGUserFlagsServer'))
		{
			LDGBallisticDM(Level.Game).FlagsServer = LDGUserFlagsServer(Other);
			LDGUserFlagsServer(Other).RcvdFor = LDGBallisticDM(Level.Game).ReceivedPlayerFlags;
		}
		else if (Other.IsA('LDGAbstractBalancer'))
			LDGBallisticDM(Level.Game).TeamBalancer = LDGAbstractBalancer(Other);
	}
	
	return Super.IsRelevant(Other, bSuperRelevant);
}

defaultproperties
{
}
