//===========================================================================
// UTComp PlayerChatManager
//
// Filters certain chat bullshit if so configured.
//===========================================================================
class UTComp_PlayerChatManager extends UnrealPlayerChatManager
	config(UTCompChatRestrictions);

/* chat filtering */
var bool					bFilterChat;
var int   				CapsCheckThreshold; 		// Messages longer than this will be checked for CAPS LOCK abuse.
var InterpCurve		MaxCapsCurve;				// 0-1 - proportion of caps in message required for Locs() call
var int					MaxCharRunLength;			// For stretching of chat. This many of the same character in a row will be trimmed to 2 of said character.
var float				ColorUsageThreshold;		// Length of message over number of attempts to use color.

// Returns whether we should receive text messages from Sender
function bool AcceptText( PlayerReplicationInfo Sender, out string Msg, optional name Type )
{
	local int i, RunLength;
	local string LastChar;
	local float CapitalsFound, TotalFound;
	local float CaratsFound;
	
	if (Super.AcceptText(Sender, Msg, Type))
	{
		if (!bFilterChat)
			return true;
		//Guard for caps lock abuse.
		if (CapsCheckThreshold != 0 && Len(Msg)>= CapsCheckThreshold)
		{
			//Counts the proportion of caps. If it's above CapsProportionThreshold, the message is put into Locs().
			//Also check for run length.
			for (i=0; i<Len(Msg); i++)
			{
				if (Asc(Mid(Msg,i,1)) > 64 && Asc(Mid(Msg,i,1)) < 91) //it's a capital
					CapitalsFound += 1;
				if (Mid(Msg,i,1) == "^")
					CaratsFound += 1;
				TotalFound += 1;
				//Detect and neutralise character runs over length 2.
				if (LastChar ~= Mid(Msg,i,1))
					RunLength++;
				else
				{
					if (RunLength > MaxCharRunLength)
					{
						Msg = Left(Msg,i-(RunLength-2)) $ Mid(Msg, i);
						i -= RunLength - 2;
					}
					RunLength = 1;
					LastChar = Mid(Msg,i,1);
				}
			}
			
			if (CaratsFound > 2 && TotalFound/CaratsFound < ColorUsageThreshold)
				return false;
			if (RunLength > MaxCharRunLength)
				Msg = Left(Msg,i-(RunLength-2));

			if (CapitalsFound/TotalFound >= InterpCurveEval(MaxCapsCurve, Len(Msg)))
				Msg = Locs(Msg);
		}
		return true;
	}
	return false;
}

defaultproperties
{
     CapsCheckThreshold=5
     MaxCapsCurve=(Points=((OutVal=1.000000),(InVal=5.000000,OutVal=1.000000),(InVal=6.000000,OutVal=0.800000),(InVal=25.000000,OutVal=0.350000),(InVal=1000.000000,OutVal=0.200000)))
     MaxCharRunLength=4
     ColorUsageThreshold=6.000000
}
