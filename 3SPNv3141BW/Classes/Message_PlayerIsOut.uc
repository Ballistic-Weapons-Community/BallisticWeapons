class Message_PlayerIsOut extends LocalMessage;

var localized string YouAreOut;
var localized string PlayerIsOut;
var localized string PlayerIsOutOpen;

static function string GetString(
	optional int SwitchNum,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject 
	)
{
    if(SwitchNum == 0)
        return default.YouAreOut;

	return (default.PlayerIsOutOpen @ RelatedPRI_1.PlayerName @ default.PlayerIsOut);
}

static simulated function ClientReceive(
	PlayerController P,
	optional int SwitchNum,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	if(RelatedPRI_1.Team == None)
	{
		default.DrawColor.R = 255;
		default.DrawColor.G = 255;
		default.DrawColor.B = 255;
	}
	else if(RelatedPRI_1.Team.TeamIndex == 0)
	{
		default.DrawColor.R = 255;
		default.DrawColor.G = 75;
		default.DrawColor.B = 75;
	}
	else
	{
		default.DrawColor.R = 75;
		default.DrawColor.G = 128;
		default.DrawColor.B = 255;
	}

    default.PosY = 0.590000 + (SwitchNum * 0.285000);

    if((P.PlayerReplicationInfo.Team != None && RelatedPRI_1.Team.TeamIndex == P.PlayerReplicationInfo.Team.TeamIndex) || (P.PlayerReplicationInfo.bOnlySpectator && Pawn(P.ViewTarget) != None && Pawn(P.ViewTarget).PlayerReplicationInfo != None && Pawn(P.ViewTarget).PlayerReplicationInfo.Team != None && Pawn(P.ViewTarget).PlayerReplicationInfo.Team.TeamIndex == RelatedPRI_1.Team.TeamIndex))
        if(class'Misc_Player'.default.SoundTMDeath != None)
            P.ClientPlaySound(class'Misc_Player'.default.SoundTMDeath);

	Super.ClientReceive(P, SwitchNum, RelatedPRI_1, RelatedPRI_2, OptionalObject);
}

defaultproperties
{
     YouAreOut="YOU ARE OUT!"
     PlayerIsOut="IS OUT!"
     bIsUnique=True
     bIsConsoleMessage=False
     bFadeMessage=True
     StackMode=SM_Down
     PosY=0.875000
}
