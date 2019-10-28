class EliminationMessage extends CriticalEventPlus;

var localized string GetReady, NoWin, TimeLimit;
var localized string RedMessages[6];
var localized string BlueMessages[6];

static simulated function ClientReceive(PlayerController P, optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject)
{
	Super.ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);
	if (Switch < 100)
		P.PlayBeepSound();
}
// 95  = Draw
// 96  = Timelimit
// 100 = Decimating other team
// 101 = Ahead
// 102 = Just took the lead
// 103 = Caught up
// 104 = Behind
// 105 = Far behind
// 110 = Blues
static function string GetString(optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject)
{
	if (Switch >= 110)
		return default.BlueMessages[Switch-110];
	else if (Switch >= 100)
		return default.RedMessages[Switch-100];
	else if (Switch == 95)
		return default.NoWin;
	else if (Switch == 96)
		return default.TimeLimit;
	return Default.GetReady$Switch;
}

static function bool IsConsoleMessage(int Switch)
{
	if (Switch < 100)
		return false;
    return true;
}

defaultproperties
{
     GetReady="Get ready..."
     NoWin="None are left alive on the field of battle!"
     TimeLimit="This battle has gone on long enough!"
     RedMessages(0)="The Red legion mercilessly blasted all enemies out of their way!"
     RedMessages(1)="The Red force pounded their way ahead!"
     RedMessages(2)="The Red fighters tore through enemy ranks to take the lead!"
     RedMessages(3)="The Red zealots won't let the enemy lead!"
     RedMessages(4)="The Red dogs still try to harass their enemy!"
     RedMessages(5)="The Red scum pitifully crawled away from defeat!"
     BlueMessages(0)="The Blue army effortlessly subdued their pitiful enemies!"
     BlueMessages(1)="The Blue soldiers fight their way ahead!"
     BlueMessages(2)="The Blue fighters pushed through enemy defences to take the lead!"
     BlueMessages(3)="The Blue zealots refuse to fall back!"
     BlueMessages(4)="The Blue jackals snap at the heels of their enemy!"
     BlueMessages(5)="The Blue worms shamefully snaked away from defeat!"
     Lifetime=5
     DrawColor=(G=64,R=32)
     PosY=0.200000
}
