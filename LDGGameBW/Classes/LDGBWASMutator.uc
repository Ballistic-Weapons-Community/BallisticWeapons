class LDGBWASMutator extends ASMutator
	HideDropDown
	CacheExempt;

function bool IsRelevant(Actor Other, out byte bSuperRelevant)
{
	if (LDGBallisticAS(Level.Game) != None)
	{		
		if (Other.IsA('LDGUserFlagsServer'))
		{
			LDGBallisticAS(Level.Game).FlagsServer = LDGUserFlagsServer(Other);
			LDGUserFlagsServer(Other).RcvdFor = LDGBallisticAS(Level.Game).ReceivedPlayerFlags;
		}
		else if (Other.IsA('LDGAbstractBalancer'))
			LDGBallisticAS(Level.Game).TeamBalancer = LDGAbstractBalancer(Other);
	}
	
	return Super.IsRelevant(Other, bSuperRelevant);
}

defaultproperties
{
}
