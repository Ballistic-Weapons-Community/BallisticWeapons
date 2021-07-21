class BallisticHealMessage extends LocalMessage;

static function string GetString(
	optional int SwitchNum,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject 
	)
{
    local string PlayerName;

    if(RelatedPRI_1 == None)
        PlayerName = class'xDeathMessage'.default.SomeoneString;
    else
        PlayerName = RelatedPRI_1.PlayerName;

    switch (SwitchNum)
    {
        case 0: return PlayerName @ "is healing you."; break;
        default: return PlayerName @ "is restoring your shields."; break;
    }
}

defaultproperties
{
     bIsUnique=True
     bIsConsoleMessage=False
     bFadeMessage=True
     Lifetime=1
     DrawColor=(B=210,G=180,R=170)
     StackMode=SM_Down
     PosY=0.775000
}
