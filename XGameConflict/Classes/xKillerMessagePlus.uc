class xKillerMessagePlus extends LocalMessage;

var(Message) localized string YouKilled;
var(Message) localized string YouKilledTrailer;

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject 
	)
{
	if (RelatedPRI_1 == None)
		return "";
	if (RelatedPRI_2 == None)
		return "";

	if (RelatedPRI_2.PlayerName != "")
		return Default.YouKilled@RelatedPRI_2.PlayerName@Default.YouKilledTrailer;
}

defaultproperties
{
	bFadeMessage=True
	bIsUnique=True

	DrawColor=(R=0,G=160,B=255,A=255)
	FontSize=0

	StackMode=SM_Down
    PosY=0.10

	YouKilled="You killed"
	YouKilledTrailer=""
}
