class Message_Darkhorse extends LocalMessage;

#exec AUDIO IMPORT FILE=Sounds\Darkhorse.wav     	    GROUP=Sounds

var Sound DarkhorseSound;

var localized string YouAreADarkHorse;
var localized string PlayerIsDarkHorseOpen;
var localized string PlayerIsDarkHorse;

static function string GetString(
	optional int SwitchNum,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject 
	)
{
    if(SwitchNum == 1)
	    return default.YouAreADarkHorse;
    else
        return default.PlayerIsDarkHorseOpen@RelatedPRI_1.PlayerName@default.PlayerIsDarkHorse;
}

static simulated function ClientReceive(
	PlayerController P,
	optional int SwitchNum,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
    UnrealPlayer(P).ClientDelayedAnnouncement(default.DarkhorseSound, 18);

	Super.ClientReceive(P, SwitchNum, RelatedPRI_1, RelatedPRI_2, OptionalObject);
}

defaultproperties
{
     DarkhorseSound=Sound'3SPNv3141BW.Sounds.DarkHorse'
     YouAreADarkHorse="DARK HORSE!"
     PlayerIsDarkHorse="IS A DARK HORSE!"
     bIsUnique=True
     bFadeMessage=True
     Lifetime=5
     DrawColor=(B=150,G=0,R=50)
     StackMode=SM_Down
     PosY=0.675000
}
