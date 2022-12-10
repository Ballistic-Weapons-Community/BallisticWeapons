class ConflictLoadoutConfig extends Object
	DependsOn(BallisticTab_ConflictLoadoutPro)
	config(BallisticProV55);

var globalconfig array<string> 		SavedInventory;
var globalconfig int                InitialWeaponIndex;
var globalconfig bool 				HasPrompted;

static function UpdateSavedInventory(array<BallisticTab_ConflictLoadoutPro.Item> inventory)
{
	local int i;
	
	default.SavedInventory.length = 0;
	
	for (i = 0; i < inventory.length; i++)
		default.SavedInventory[i] = inventory[i].ClassName;
		
	StaticSaveConfig();
}

static function UpdateSavedInitialIndex(int index)
{
    default.InitialWeaponIndex = index;

    StaticSaveConfig();
}

static function NotifyPrompted()
{
	default.HasPrompted = true;
	StaticSaveConfig();
}

static function string BuildSavedInventoryString()
{ 
	local string s;
	local int i;

	for (i = 0; i < default.SavedInventory.Length; i++)
	{
		if (s == "")
			s = default.SavedInventory[i];
		else
			s = s $ "|" $ default.SavedInventory[i];
	}
	return s;
}

static function int GetSavedInitialWeaponIndex()
{
    return default.InitialWeaponIndex;
}

defaultproperties 
{
	SavedInventory(0)="BallisticProV55.A73SkrithRifle"
	SavedInventory(1)="BallisticProV55.M806Pistol"
	SavedInventory(2)="BallisticProV55.X3Knife"
	SavedInventory(3)="BallisticProV55.NRP57Grenade"
    InitialWeaponIndex=0
	HasPrompted=False
}