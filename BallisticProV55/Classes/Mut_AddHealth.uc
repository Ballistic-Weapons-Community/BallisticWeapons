class Mut_AddHealth extends Mutator
config(BallisticProV55);

var() config int NewHP, NewHealthMax, NewSHealthMax;

function ModifyPlayer(Pawn Other)
{
	Other.Health = NewHP;
	Other.HealthMax = NewHealthMax;
	Other.SuperHealthMax = NewSHealthMax;
	Super.ModifyPlayer(Other);
}

defaultproperties
{
     NewHP=175
     NewHealthMax=175
     NewSHealthMax=218
     FriendlyName="BallisticPro: Starting Health"
     Description="Gives a configurable amount of health to players on spawn."
}
