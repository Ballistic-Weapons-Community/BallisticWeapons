class G5LockOnMessage extends CriticalEventPlus;

var 	Sound			WarningSound;
 
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
	return "WARNING: Incoming G5 Rocket!";
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
	P.ClientPlaySound(default.WarningSound,True,3,SLOT_Talk);
}

defaultproperties
{
     WarningSound=Sound'WeaponSounds.BaseGunTech.BSeekLost1'
     DrawColor=(B=0,G=0,R=255)
}
