class GGMessages extends CriticalEventPlus;

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
     if ( Switch == 2 )
          return "New round in...";
}

static function ClientReceive(
    PlayerController P,
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
     Super.ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);

     if ( (P.GameReplicationInfo != None) && (P.GameReplicationInfo.Winner == None)
		&& ((P.GameReplicationInfo.RemainingTime > 10) || (P.GameReplicationInfo.RemainingTime == 0)) )
     {
          if ( Switch == 0 )
               P.QueueAnnouncement( 'Red_team_round', 1, AP_InstantOrQueueSwitch, 1 );
          else if ( Switch == 1 )
               P.QueueAnnouncement( 'Blue_team_round', 1, AP_InstantOrQueueSwitch, 1 );
          else if ( Switch == 2 )
               P.QueueAnnouncement( 'NewRoundIn', 1, AP_InstantOrQueueSwitch, 1 );
     }
}

defaultproperties
{
     bIsConsoleMessage=False
     Lifetime=2
     DrawColor=(B=0,G=255,R=255)
     StackMode=SM_Down
     PosY=0.100000
     FontSize=0
}
