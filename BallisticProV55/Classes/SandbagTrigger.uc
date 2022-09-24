class SandbagTrigger extends Trigger;
/*
var Sandbag Bags;

event Touch(actor Other)
{
	if (Bags == None)
		return;
	if(Monster(Other) != None)
	{
		Bags.TakeDamage(100, Monster(Other), Location, vect(0,0,0), class'Fell');
		if (Bags == None)
			Destroy();
	}
	
	else if (BallisticPawn(Other) != None)
		BallisticPawn(Other).CoverAnchors[BallisticPawn(Other).CoverAnchors.Length] = Bags;
}

event UnTouch(actor Other)
{
	if (BallisticPawn(Other) != None)
		BallisticPawn(Other).RemoveCoverAnchor(Bags);
}

function RemoveCoverAnchors()
{
	local BallisticPawn P;
	foreach TouchingActors(class'BallisticPawn', P)
		P.RemoveCoverAnchor(Bags);
}

event UsedBy(Pawn User)
{
	local Pawn P;

	foreach TouchingActors(class'Pawn', P)
	{
		if (P.GetTeamNum () != User.GetTeamNum()) //can't dismantle bags being actively used as defense
			return;
	}
	Bags.TakeBag(User);

	if (Bags == None)
		Destroy();
}

defaultproperties
{
     CollisionRadius=72.000000
     CollisionHeight=48.000000
}
*/