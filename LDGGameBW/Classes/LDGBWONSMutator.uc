class LDGBWONSMutator extends ONSDefaultMut
	HideDropDown
	CacheExempt;

function bool IsRelevant(Actor Other, out byte bSuperRelevant)
{
	if (LDGBallisticONS(Level.Game) != None)
	{		
		if (Other.IsA('LDGUserFlagsServer'))
		{
			LDGBallisticONS(Level.Game).FlagsServer = LDGUserFlagsServer(Other);
			LDGUserFlagsServer(Other).RcvdFor = LDGBallisticONS(Level.Game).ReceivedPlayerFlags;
		}
		else if (Other.IsA('LDGAbstractBalancer'))
			LDGBallisticONS(Level.Game).TeamBalancer = LDGAbstractBalancer(Other);
	}
	
	return Super.IsRelevant(Other, bSuperRelevant);
}

defaultproperties
{
}
