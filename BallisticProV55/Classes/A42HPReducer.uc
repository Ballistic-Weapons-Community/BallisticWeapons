class A42HPReducer extends Inventory;

var int baseHealthMax;
var int baseSuperHealthMax;
var int stackCount;

function GiveTo(Pawn Other, optional Pickup Pickup)
{
	Super.GiveTo(Other, Pickup);
	
	baseHealthMax = Other.HealthMax;
	baseSuperHealthMax = Other.SuperHealthMax;
}

function AddStack(int count)
{
	stackCount += count;
	
	Instigator.HealthMax = Max(50, baseHealthMax - (stackCount * 5));	
	Instigator.SuperHealthMax = Max(75, baseHealthMax - (stackCount * 5));	
	SetTimer(5, false);
}

function Timer()
{
	if (stackCount > 0)
	{
		--stackCount;
		Instigator.HealthMax = Max(50, baseHealthMax - (stackCount * 5));	
		Instigator.SuperHealthMax = Max(75, baseSuperHealthMax - (stackCount * 5));	
		SetTimer(0.5, false);
	}
	
	if (stackCount == 0)
		Destroy();
}

defaultproperties
{
}
