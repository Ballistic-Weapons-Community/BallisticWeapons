class ThawWhileProtectedMessage extends LocalMessage;

var localized string CannotThawProtMessage;
var localized string CannotThawRecMessage;

static function string GetString(
	optional int SwitchNum,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject 
	)
{
	if (SwitchNum == 0)
		return default.CannotThawProtMessage;
	else
		return default.CannotThawRecMessage;
}

defaultproperties
{
     CannotThawProtMessage="CANNOT THAW WHEN PROTECTED!"
     CannotThawRecMessage="CANNOT THAW - YOU HAVE RECENTLY THAWED!"
     bIsUnique=True
     bIsConsoleMessage=False
     bFadeMessage=True
     Lifetime=2
     DrawColor=(B=0,G=0)
     StackMode=SM_Down
     PosY=0.725000
}
