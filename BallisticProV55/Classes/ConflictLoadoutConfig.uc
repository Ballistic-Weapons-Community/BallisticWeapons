class ConflictLoadoutConfig extends Object
	DependsOn(MidGameTab_Conflict)
	config(BallisticProV55);

var globalconfig array<string> 		SavedInventory;
var	globalconfig array<int>			SavedLayout;
var	globalconfig array<int>			SavedCamo;
var globalconfig int                InitialWeaponIndex;
var globalconfig bool 				HasPrompted;

static function UpdateSavedInventory(array<MidGameTab_Conflict.Item> inventory)
{
	local int i;
	
	default.SavedInventory.length = 0;
	default.SavedLayout.length = 0;
	default.SavedCamo.length = 0;
	
	for (i = 0; i < inventory.length; i++)
	{
		default.SavedInventory[i] = inventory[i].ClassName;
		default.SavedLayout[i] = inventory[i].LayoutIndex;
		default.SavedCamo[i] = inventory[i].CamoIndex;
	}
		
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

static function string BuildSavedLayoutString()
{ 
	local string ls;
	local int i;

	for (i = 0; i < default.SavedLayout.Length; i++)
	{
		if (ls == "")
			ls = String(default.SavedLayout[i]);
		else
			ls = ls $ "|" $ String(default.SavedLayout[i]);
	}
	return ls;
}

static function string BuildSavedCamoString()
{ 
	local string cs;
	local int i;

	for (i = 0; i < default.SavedCamo.Length; i++)
	{
		if (cs == "")
			cs = String(default.SavedCamo[i]);
		else
			cs = cs $ "|" $ String(default.SavedCamo[i]);
	}
	return cs;
}

static function int GetSavedInitialWeaponIndex()
{
    return default.InitialWeaponIndex;
}

defaultproperties 
{
	SavedInventory(0)="BallisticProV55.M50AssaultRifle"
	SavedInventory(1)="BallisticProV55.XMk5SubMachinegun"
	SavedInventory(2)="BallisticProV55.X4Knife"
	SavedInventory(3)="BallisticProV55.NRP57Grenade"
	SavedLayout(0)=0
	SavedLayout(1)=0
	SavedLayout(2)=0
	SavedLayout(3)=0
	SavedCamo(0)=0
	SavedCamo(1)=0
	SavedCamo(2)=0
	SavedCamo(3)=0
    InitialWeaponIndex=0
	HasPrompted=False
}