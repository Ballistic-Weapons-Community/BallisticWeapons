class DefMut_Freon extends TAM_Mutator
	HideDropDown
	CacheExempt;

function bool IsRelevant(Actor Other, out byte bSuperRelevant)
{
	if (Game_Freon(Level.Game) != None)
	{
		if (Other.IsA('LDGUserFlagsServer'))
		{
			Game_Freon(Level.Game).FlagsServer = LDGUserFlagsServer(Other);
			LDGUserFlagsServer(Other).RcvdFor = Game_Freon(Level.Game).ReceivedPlayerFlags;
		}
		else if (Other.IsA('LDGAbstractBalancer'))
		{
			Game_Freon(Level.Game).TeamBalancer = LDGAbstractBalancer(Other);
			
			if (Game_Freon_Tracked(Level.Game) != None)
				LDGAbstractBalancer(Other).RequestPlayerVariable = Game_Freon_Tracked(Level.Game).TeamBalancerPlayerVariable;
		}
	}
	
	return Super.IsRelevant(Other, bSuperRelevant);
}

function Mutate(string MutateString, PlayerController Sender)
{
	local array<string> args;
	local int i, Pos, NotFound;
	
	Super.Mutate(MutateString,Sender);
	
	if (Level.NetMode == NM_Standalone || (Sender != None && Sender.PlayerReplicationInfo != None && Sender.PlayerReplicationInfo.bAdmin))
	{
		Split(MutateString, " ", args);
	
		i = 0;
		while(i < args.Length)
		{
			if (args[i] == "")
				args.Remove(i, 1);
			else
				i++;
		}
		
		if (Game_Freon_Tracked(Level.Game) != None)
		{
			if (args.Length == 4 && args[0] ~= "LDGGameBW" && args[1] ~= "Merge")
			{
				class'LDGBWFreonDataTracking'.static.AddMerge(args[2], args[3]);
				Sender.ClientMessage("Setting up merge: " $ args[2] $ " -> " $ args[3] $ ".");
			}
			else if (args.Length == 4 && args[0] ~= "LDGGameBW" && args[1] ~= "SetDerank")
			{
				Pos = class'LDGBWFreonDataTracking'.static.BinarySearch(args[2], false, NotFound);
				if (NotFound == 0)
				{
					class'LDGBWFreonDataTracking'.default.Database[Pos].Deranked = (args[3] ~= "true") || (args[3] ~= "1");
					Sender.ClientMessage("User " $ args[2] $ " derank status: " $ class'LDGBWFreonDataTracking'.default.Database[Pos].Deranked $ ".");
				}
				else
					Sender.ClientMessage("User " $ args[2] $ " doesn't exist!");
				
			}
			else if (args.Length == 4 && args[0] ~= "LDGGameBW" && args[1] ~= "AddPenalty")
			{
				Pos = class'LDGBWFreonDataTracking'.static.BinarySearch(args[2], false, NotFound);
				if (NotFound == 0)
				{
					class'LDGBWFreonDataTracking'.default.Database[Pos].Penalty += int(args[3]);
					Sender.ClientMessage("User " $ args[2] $ " penalty status: " $ class'LDGBWFreonDataTracking'.default.Database[Pos].Penalty $ ".");
				}
				else
					Sender.ClientMessage("User " $ args[2] $ " doesn't exist!");
				
			}
			else if (args.Length == 2 && args[0] ~= "LDGGameBW" && args[1] ~= "CancelMerges")
			{
				class'LDGBWFreonDataTracking'.default.Merges.Remove(0, class'LDGBWFreonDataTracking'.default.Merges.Length);
				Sender.ClientMessage("Cancelled all merges!");
			}
		}
	}
}

defaultproperties
{
}
