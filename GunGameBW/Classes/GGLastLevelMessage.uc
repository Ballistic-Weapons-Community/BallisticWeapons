//=============================================================================
// GGLastLevelMessage.
//
// Told to everyone when a player (or in Team GunGame, a team) gets to the last
// weapon of the list.
// Switch 0: RelatedPRI_1 is on the last weapon. Switch 1: RelatedPRI_1's team is.
// OptionalObject is the weapon's class.
//=============================================================================
class GGLastLevelMessage extends CriticalEventPlus;

var localized string PlayerLastWeapon, TeamLastWeapon;

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
	local string S, Who;

	if (RelatedPRI_1 == None)
		return "";
	if (Switch == 1 && RelatedPRI_1.Team != None)
	{
		Who = RelatedPRI_1.Team.GetHumanReadableName();
		S = default.TeamLastWeapon;
	}
	else
	{
		Who = RelatedPRI_1.PlayerName;
		S = default.PlayerLastWeapon;
	}
	S = Repl(S, "%p", Who);
	if (class<Weapon>(OptionalObject) != None)
		S = S $ ":" @ class<Weapon>(OptionalObject).default.ItemName;
	return S;
}

defaultproperties
{
	PlayerLastWeapon="%p is on the last weapon"
	TeamLastWeapon="%p is on the last weapon"
	bIsConsoleMessage=True
	Lifetime=4
	DrawColor=(B=0,G=160,R=255)
	StackMode=SM_Down
	PosY=0.180000
	FontSize=0
}
