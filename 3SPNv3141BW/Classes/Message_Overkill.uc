class Message_Overkill extends LocalMessage;

#exec AUDIO IMPORT FILE=Sounds\Overkill.wav     	    GROUP=Sounds

var Sound OverkillSound;
var localized string Overkill;

static function string GetString(
	optional int SwitchNum,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject 
	)
{
	return default.Overkill;
}

static simulated function ClientReceive(
	PlayerController P,
	optional int SwitchNum,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	Super.ClientReceive(P, SwitchNum, RelatedPRI_1, RelatedPRI_2, OptionalObject);
    
    if(Misc_Player(P) != None && Misc_Player(P).bAnnounceOverkill)
        Misc_Player(P).PlayCustomRewardAnnouncement(default.OverkillSound, 1);
}

defaultproperties
{
     OverkillSound=Sound'3SPNv3141BW.Sounds.Overkill'
     Overkill="OVERKILL!"
     bIsUnique=True
     bFadeMessage=True
     DrawColor=(B=0)
     StackMode=SM_Down
     PosY=0.100000
}
