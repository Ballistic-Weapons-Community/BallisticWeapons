class Ballistic_DeathMessage extends xDeathMessage;

var color TextColor, DMColor;

var string Red;
var string Blue;
var string Text;
var string DMC;

static function color GetConsoleColor( PlayerReplicationInfo RelatedPRI_1 )
{
    return default.TextColor;
}

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject 
	)
{
	local string KillerName, VictimName;

    if(class<DamageType>(OptionalObject) == None)
        return "";

    if(default.Red == "")
    {
        default.Red = class'DMStatsScreen'.static.MakeColorCode(class'SayMessagePlus'.default.RedTeamColor);
        default.Blue = class'DMStatsScreen'.static.MakeColorCode(class'SayMessagePlus'.default.BlueTeamColor);
        default.Text = class'DMStatsScreen'.static.MakeColorCode(default.TextColor);
		default.DMC = class'DMStatsScreen'.static.MakeColorCode(default.DMColor);
    }
    if(RelatedPRI_2 == None)
        VictimName = default.DMC $ default.SomeoneString $ default.Text;
    else
    {
        if(RelatedPRI_2.Team == None)
            VictimName = default.DMC $ RelatedPRI_2.PlayerName $ default.Text;
        else if(RelatedPRI_2.Team.TeamIndex == 0)
            VictimName = default.Red $ RelatedPRI_2.PlayerName $ default.Text;
        else
            VictimName = default.Blue $ RelatedPRI_2.PlayerName $ default.Text;
    }

    if(Switch == 1)
        return class'GameInfo'.static.ParseKillMessage(KillerName, VictimName, class<DamageType>(OptionalObject).static.SuicideMessage(RelatedPRI_2));

    if(RelatedPRI_1 == None)
        KillerName = default.DMC $ default.SomeoneString $ default.Text;
    else
    {
        if(RelatedPRI_2.Team == None)
            KillerName = default.DMC $ RelatedPRI_1.PlayerName $ default.Text;
        else if(RelatedPRI_1.Team.TeamIndex == 0)
            KillerName = default.Red $ RelatedPRI_1.PlayerName $ default.Text;
        else
            KillerName = default.Blue $ RelatedPRI_1.PlayerName $ default.Text;
    }

	if (Switch == 2 && class<BallisticDamageType>(OptionalObject) != None && class'BallisticDamageType'.default.bSimpleDeathMessages)
		return class'GameInfo'.static.ParseKillMessage(KillerName, VictimName, default.Text $ class<BallisticDamageType>(OptionalObject).static.ScopedDeathMessage(RelatedPRI_1, RelatedPRI_2));
    return class'GameInfo'.static.ParseKillMessage(KillerName, VictimName, default.Text $ class<DamageType>(OptionalObject).static.DeathMessage(RelatedPRI_1, RelatedPRI_2));
}

defaultproperties
{
     TextColor=(B=210,G=210,R=210,A=255)
     DMColor=(G=255,R=255,A=255)
}
