class Message_TimeOut extends LocalMessage;

static function string GetString(
    optional int SwitchNum,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject 
	)
{
	if(SwitchNum == 0)
		return "Timeout is ending...";

	return "Timeout ends in... "$SwitchNum;
}

defaultproperties
{
     bIsUnique=True
     bFadeMessage=True
     StackMode=SM_Down
     PosY=0.875000
}
