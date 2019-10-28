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
	return "You can't carry any more "$default.SlotDescriptions[Switch]$".";
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
     SlotDescriptions(0)="grenades"
     SlotDescriptions(1)="melee weapons"
     SlotDescriptions(2)="sidearms"
     SlotDescriptions(3)="SMGs"
     SlotDescriptions(4)="assault rifles"
     SlotDescriptions(5)="energy weapons"
     SlotDescriptions(6)="machineguns"
     SlotDescriptions(7)="shotguns"
     SlotDescriptions(8)="ordnance"
     SlotDescriptions(9)="sniper rifles"
     SlotDescriptions(10)="special weapons"
     StackMode=SM_Down
     PosY=0.730000
}
