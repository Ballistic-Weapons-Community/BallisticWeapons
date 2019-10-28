class LDGBWAMMutator extends TAM_Mutator
	HideDropDown
	CacheExempt;

function bool IsRelevant(Actor Other, out byte bSuperRelevant)
{
	if (LDGBallisticFR(Level.Game) != None)
	{
		if (Other.IsA('LDGUserFlagsServer'))
		{
			LDGBallisticAM(Level.Game).FlagsServer = LDGUserFlagsServer(Other);
			LDGUserFlagsServer(Other).RcvdFor = LDGBallisticAM(Level.Game).ReceivedPlayerFlags;
		}
		else if (Other.IsA('LDGAbstractBalancer'))
		{
			LDGBallisticAM(Level.Game).TeamBalancer = LDGAbstractBalancer(Other);
		}
	}
	
	return Super.IsRelevant(Other, bSuperRelevant);
}

defaultproperties
{
}
