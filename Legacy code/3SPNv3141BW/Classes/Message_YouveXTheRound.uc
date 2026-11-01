class Message_YouveXTheRound extends LocalMessage;

//#exec AUDIO IMPORT FILE=Sounds\wonround.wav GROUP=Sounds
//#exec AUDIO IMPORT FILE=Sounds\lostround.wav GROUP=Sounds

var localized string WonTheRound;
var localized string LostTheRound;

//var Sound WonSound;
//var Sound LostSound;

static function string GetString(
	optional int SwitchNum,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject 
	)
{
    if(SwitchNum == 0)
	    return default.LostTheRound;
    else
        return default.WonTheRound;
}

static simulated function ClientReceive( 
	PlayerController P,
	optional int SwitchNum,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
    if(SwitchNum == 0)
    {
        default.DrawColor.G = 0;
        default.DrawColor.B = 0;

        //UnrealPlayer(P).ClientDelayedAnnouncement(default.LostSound, 5);
    }
    else
    {
        default.DrawColor.G = 255;
        default.DrawColor.B = 255;

        //UnrealPlayer(P).ClientDelayedAnnouncement(default.WonSound, 5);
    }
	
	Super.ClientReceive(P, SwitchNum, RelatedPRI_1, RelatedPRI_2, OptionalObject);
}

defaultproperties
{
     WonTheRound="YOU'VE WON THE ROUND!"
     LostTheRound="YOU'VE LOST THE ROUND!"
     bIsUnique=True
     bIsConsoleMessage=False
     bFadeMessage=True
     StackMode=SM_Down
     PosY=0.300000
}
