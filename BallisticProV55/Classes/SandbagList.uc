//===========================================================================
// As the turret list, but for sandbags.
//===========================================================================
class SandbagList extends Info config(BallisticProV55);

var   array<Sandbag>			Bags;
var() globalconfig int			MaxBags;

// Find current BCTurretList or make one if needed
static function SandbagList InitSandbagList (actor A)
{
	local SandbagList SL;

	if (A != None)
		foreach A.DynamicActors (class'SandbagList', SL)
			return SL;
	SL = A.Spawn(class'SandbagList');
	return SL;
}
// Quick easy way to initialize a new turret, get it listed and init the list itself if needed
static function bool AutoInitBag (Sandbag S)
{
	if (S == None)
		return false;
	S.BagList = InitSandbagList(S.level);
	if (S.BagList == None)
		return false;
	S.BagList.AddBag(S);
	S.BagList.TrimBags();
	return true;
}

//Maintain the bag maximum
function TrimBags()
{
	local Sandbag S;

	// Off the list before it goes. Its Destroyed takes it off the list too (RemoveBag), and removing index 0 after
	// that dropped the next bag from the list while it stayed in the world
	while (Bags.Length > MaxBags)
	{
		S = Bags[0];
		Bags.Remove(0, 1);
		if (S != None)
			S.Destroy();
	}
}
function AddBag(Sandbag S)
{
	Bags[Bags.length] = S;
}

function bool RemoveBag(Sandbag S)
{
	local int i;
	if (S == None)
		return false;
	for (i=0;i<Bags.length;i++)
		if (Bags[i] == S)
		{
			Bags.Remove(i, 1);
			return true;
		}
	return false;
}

defaultproperties
{
     MaxBags=30
}
