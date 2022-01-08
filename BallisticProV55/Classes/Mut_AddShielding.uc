class Mut_AddShielding extends Mutator
	HideDropDown
	CacheExempt
	config(BallisticProV55);

var() config int NewSS;

function ModifyPlayer(Pawn Other)
{
	Other.AddShieldStrength(NewSS);
	Super.ModifyPlayer(Other);
}

defaultproperties
{
     NewSS=75
     FriendlyName="BallisticPro: Starting Shield"
     Description="Gives a configurable amount of shield to players on spawn."
}
