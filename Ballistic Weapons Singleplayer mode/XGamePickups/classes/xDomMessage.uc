//=============================================================================
// xDomMessage.
//=============================================================================
class xDomMessage extends LocalMessage;

var(Message) localized string YouControlBothPointsString;
var(Message) localized string EnemyControlsBothPointsString;
var(Message) color RedColor, BlueColor;

static function color GetColor(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2
	)
{
	if (Switch == 0)
		return Default.RedColor;
	else
		return Default.BlueColor;
}

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	switch (Switch)
	{
		case 0:
			return Default.YouControlBothPointsString;
			break;

		case 1:
			return Default.EnemyControlsBothPointsString;
			break;
	}
	return "";
}

defaultproperties
{
	YouControlBothPointsString="Your team controls both points!"
	EnemyControlsBothPointsString="The enemy controls both points!"

	bFadeMessage=True
	bIsUnique=true
	bIsConsoleMessage=False

	Lifetime=1
	
    //RedColor=(R=255,G=0,B=0,A=255)
    //BlueColor=(R=0,G=0,B=255,A=255)
    RedColor=(R=255,G=255,B=0,A=255)	
	BlueColor=(R=255,G=255,B=0,A=255)
    
    DrawColor=(R=0,G=160,B=255,A=255)
	FontSize=1

	StackMode=SM_Down
    PosY=0.10
}
