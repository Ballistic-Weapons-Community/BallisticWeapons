class ConflictLoadoutConfig extends Object
	DependsOn(BallisticTab_ConflictLoadoutPro)
	config(BallisticProV55);

var config array<string> 		SavedInventory;

static function UpdateSavedInventory(array<BallisticTab_ConflictLoadoutPro.Item> inventory)
{
	local int i;
	
	default.SavedInventory.length = 0;
	
	for (i = 0; i < inventory.length; i++)
		default.SavedInventory[i] = inventory[i].ClassName;
		
	StaticSaveConfig();
}

static function string BuildSavedInventoryString()
{ 
	local string s;
	local int i;

	for (i=0; i < default.SavedInventory.Length; i++)
	{
		if (s == "")
			s = default.SavedInventory[i];
		else
			s = s $ "|" $ default.SavedInventory[i];
	}
	return s;
}

defaultproperties 
{
	SavedInventory(0)="BallisticProV55.M50AssaultRifle"
	SavedInventory(1)="BallisticProV55.M806Pistol"
	SavedInventory(2)="BallisticProV55.X3Knife"
	SavedInventory(3)="BallisticProV55.NRP57Grenade"
}