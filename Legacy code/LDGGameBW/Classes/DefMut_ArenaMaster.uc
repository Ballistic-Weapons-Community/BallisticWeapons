class DefMut_ArenaMaster extends TAM_Mutator
	HideDropDown
	CacheExempt;

function bool IsRelevant(Actor Other, out byte bSuperRelevant)
{
	if (Game_ArenaMaster(Level.Game) != None)
	{
		if (Other.IsA('LDGUserFlagsServer'))
		{
			Game_ArenaMaster(Level.Game).FlagsServer = LDGUserFlagsServer(Other);
			LDGUserFlagsServer(Other).RcvdFor = Game_ArenaMaster(Level.Game).ReceivedPlayerFlags;
		}
		else if (Other.IsA('LDGAbstractBalancer'))
		{
			Game_ArenaMaster(Level.Game).TeamBalancer = LDGAbstractBalancer(Other);
		}
	}
	
	return Super.IsRelevant(Other, bSuperRelevant);
}

defaultproperties
{
}
