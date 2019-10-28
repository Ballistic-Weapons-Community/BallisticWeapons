class Freon_ThawMessage extends LocalMessage;

var localized string YouWereThawedByPrefix;
var localized string YouWereThawedBySuffix;

var localized string YouWereThawed;

var localized string YouThawedSomeonePrefix;
var localized string YouThawedSomeoneSuffix;

var localized string SomeoneWasThawedPrefix;
var localized string SomeoneWasThawedSuffix;

var localized string SomeoneThawingYouPrefix;
var localized string SomeoneThawingYouSuffix;

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

    switch(SwitchNum)
    {
    case 0:
        if(RelatedPRI_1 != None)
            return default.YouWereThawedByPrefix $ PlayerName $ default.YouWereThawedBySuffix;
        else
            return default.YouWereThawed;

    case 1:
        return default.YouThawedSomeonePrefix $ PlayerName $ default.YouThawedSomeoneSuffix;

    case 2:
        return default.SomeoneThawingYouPrefix $ PlayerName $ default.SomeoneThawingYouSuffix;

    default:
        return default.SomeoneWasThawedPrefix $ PlayerName $ default.SomeoneWasThawedSuffix;
    }
}

static simulated function ClientReceive(
	PlayerController P,
	optional int SwitchNum,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
    if(SwitchNum == 1 || SwitchNum == 2)
        default.bIsConsoleMessage = false;
    else
        default.bIsConsoleMessage = true;

    Super.ClientReceive(P, SwitchNum, RelatedPRI_1, RelatedPRI_2, OptionalObject);
}

defaultproperties
{
     YouWereThawedByPrefix="YOU WERE THAWED BY "
     YouWereThawed="YOU WERE THAWED"
     YouThawedSomeonePrefix="YOU THAWED "
     SomeoneWasThawedSuffix=" HAS BEEN THAWED!"
     SomeoneThawingYouSuffix=" IS THAWING YOU"
     bIsUnique=True
     bIsConsoleMessage=False
     bFadeMessage=True
     Lifetime=2
     DrawColor=(B=210,G=180,R=170)
     StackMode=SM_Down
     PosY=0.725000
}
