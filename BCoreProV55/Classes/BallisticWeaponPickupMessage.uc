class BallisticWeaponPickupMessage extends PickupMessagePlus;

var localized array<String> SlotDescriptions[11];

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
	return "You can't carry any more weapons.";
}

static simulated function ClientReceive( 
	PlayerController P,
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	if (BallisticWeaponPickup(OptionalObject) != None)
	{
		if (P.Level.TimeSeconds < BallisticWeaponPickup(OptionalObject).LastBlockNotificationTime + 2)
			return;
		else
			BallisticWeaponPickup(OptionalObject).LastBlockNotificationTime = P.Level.TimeSeconds;
	}

	Super.ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);
}

defaultproperties
{
     StackMode=SM_Down
     PosY=0.730000
}
