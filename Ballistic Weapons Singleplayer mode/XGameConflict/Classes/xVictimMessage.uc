class xVictimMessage extends LocalMessage;

var(Message) localized string YouWereKilledBy, KilledByTrailer;

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject 
	)
{
	if (RelatedPRI_1 == None)
		return "";

	if (RelatedPRI_1.PlayerName != "")
		return Default.YouWereKilledBy@RelatedPRI_1.PlayerName$Default.KilledByTrailer;
}

defaultproperties
{
	bFadeMessage=True
	bIsUnique=True
	Lifetime=6

	DrawColor=(R=255,G=0,B=0,A=255)
	FontSize=0

	YouWereKilledBy="You were killed by"
	KilledByTrailer="!"

	StackMode=SM_Down
    PosY=0.10
}
