class DefMut_Jailbreak extends DMMutator
	HideDropDown
	CacheExempt;
	
function bool IsRelevant(Actor Other, out byte bSuperRelevant)
{
	if ( Controller(Other) != None && MessagingSpectator(Other) == None )
		Controller(Other).PlayerReplicationInfoClass = class'LDGJBPlayerReplicationInfo';

	if (Game_Jailbreak(Level.Game) != None)
	{		
		if (Other.IsA('LDGUserFlagsServer'))
		{
			Game_Jailbreak(Level.Game).FlagsServer = LDGUserFlagsServer(Other);
			LDGUserFlagsServer(Other).RcvdFor = Game_Jailbreak(Level.Game).ReceivedPlayerFlags;
		}
		else if (Other.IsA('LDGAbstractBalancer'))
			Game_Jailbreak(Level.Game).TeamBalancer = LDGAbstractBalancer(Other);
	}
	
	return Super.IsRelevant(Other, bSuperRelevant);
}

defaultproperties
{
}
