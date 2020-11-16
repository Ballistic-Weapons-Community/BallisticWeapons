class Message_ThawReady extends LocalMessage;

static function string GetString(
    optional int SwitchNum,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject 
	)
{
    return "Press FIRE to thaw!";
}

defaultproperties
{
    bIsUnique=True
    bFadeMessage=True
    StackMode=SM_Down
    PosY=0.590000
}
