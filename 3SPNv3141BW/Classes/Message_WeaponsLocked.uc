class Message_WeaponsLocked extends LocalMessage;

static function string GetString(
	optional int SwitchNum,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject 
	)
{
    if(SwitchNum > 0)
	    return "..."$SwitchNum$"...";
    else
        return "WEAPONS UNLOCKED";
}

static simulated function ClientReceive( 
	PlayerController P,
	optional int SwitchNum,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
    if(SwitchNum > 0)
    {
        P.PlayStatusAnnouncement(HudCDeathMatch(P.myHUD).CountDownName[SwitchNum - 1], 1, true);

        default.DrawColor.G = 255;
        default.DrawColor.B = 255;
    }
    else
    {
        default.DrawColor.G = 0;
        default.DrawColor.B = 0;
        
        if(Misc_Player(P) != None)
            P.ClientPlaySound(Misc_Player(P).SoundUnlock);
    }
	
	Super.ClientReceive(P, SwitchNum, RelatedPRI_1, RelatedPRI_2, OptionalObject);
}

defaultproperties
{
     bIsUnique=True
     bIsConsoleMessage=False
     bFadeMessage=True
     Lifetime=1
     StackMode=SM_Down
     PosY=0.875000
}
