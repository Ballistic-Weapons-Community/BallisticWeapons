class RSDarkHealBlockMessage extends LocalMessage;

static function string GetString(
	optional int SwitchNum,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject 
	)
{
    local string EnemyName;
    local string AllyName;

    if(RelatedPRI_1 == None)
        EnemyName = class'xDeathMessage'.default.SomeoneString;
    else
        EnemyName = RelatedPRI_1.PlayerName;

    if(RelatedPRI_2 == None)
        AllyName = class'xDeathMessage'.default.SomeoneString;
    else
        AllyName = RelatedPRI_2.PlayerName;

    switch (SwitchNum)
    {
        case 1:
            return EnemyName$"'s Dark Flames blocked "$AllyName$"'s heal!";
        case 2:
            return EnemyName$"'s Dark Flames prevent you from healing "$AllyName$"!";
        default:
            return EnemyName$"'s Dark Flames blocked the heal!";
    }
}

defaultproperties
{
     bIsUnique=True
     bIsConsoleMessage=False
     bFadeMessage=True
     Lifetime=1
     DrawColor=(B=25,G=25,R=200)
     StackMode=SM_Down
     PosY=0.775000
}
