class LDGBWCTFMutator extends DMMutator
	HideDropDown
	CacheExempt;

function bool IsRelevant(Actor Other, out byte bSuperRelevant)
{
	if (LDGBallisticCTF(Level.Game) != None)
	{		
		if (Other.IsA('LDGUserFlagsServer'))
		{
			LDGBallisticCTF(Level.Game).FlagsServer = LDGUserFlagsServer(Other);
			LDGUserFlagsServer(Other).RcvdFor = LDGBallisticCTF(Level.Game).ReceivedPlayerFlags;
		}
		else if (Other.IsA('LDGAbstractBalancer'))
			LDGBallisticCTF(Level.Game).TeamBalancer = LDGAbstractBalancer(Other);
	}
	
	return Super.IsRelevant(Other, bSuperRelevant);
}

defaultproperties
{
}
