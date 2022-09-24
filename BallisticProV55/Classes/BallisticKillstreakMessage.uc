class BallisticKillstreakMessage extends CriticalEventPlus;

var 	Sound			StreakSound, DonationSound;
 
static function int GetFontSize( int Switch, PlayerReplicationInfo RelatedPRI1, PlayerReplicationInfo RelatedPRI2, PlayerReplicationInfo LocalPlayer )
{
	return Default.FontSize;
}

static function string GetRelatedString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1, 
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{    
    return static.GetString(Switch,RelatedPRI_1,RelatedPRI_2,OptionalObject);
}

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	if (Switch < 0)
		return "Donation Level"@-Switch@"Received";
	return "Level"@Switch@"Killstreak Available";
}

static simulated function ClientReceive( 
	PlayerController P,
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	Super.ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);
	if (Switch < 0)
		P.ClientPlaySound(default.DonationSound,True,3,SLOT_Talk);
	else P.ClientPlaySound(default.StreakSound,True,3,SLOT_Talk);
}

defaultproperties
{
     //StreakSound=Sound'GameSounds.Fanfares.UT2K3Fanfare08'
     //DonationSound=Sound'GameSounds.OtherFanfares.LadderOpened'
     DrawColor=(B=0,G=60,R=255)
}
