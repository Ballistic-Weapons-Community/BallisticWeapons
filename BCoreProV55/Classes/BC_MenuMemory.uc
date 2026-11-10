//=============================================================================
// BC_MenuMemory
//
// Where the player was in the Ballistic menus, so they reopen there: the
// last tab of each menu (by the menu's class name and the tab's caption),
// the in-game tab last used, and the loadout slot and team being edited.
// Kept with the other preferences in BallisticPreferences.ini.
//=============================================================================
class BC_MenuMemory extends Object
	abstract
	config(BallisticPreferences);

struct MenuTab
{
	var config string	Menu;
	var config string	Tab;
};
var config array<MenuTab>	LastTabs;
var config string			LastInGameTab;		// caption of the Ballistic in-game tab last shown, "" when another tab was
var config int				LoadoutSlot, LoadoutTeam, EvolutionSlot;

static function string GetLastTab(string Menu)
{
	local int i;

	for (i = 0; i < default.LastTabs.Length; i++)
		if (default.LastTabs[i].Menu ~= Menu)
			return default.LastTabs[i].Tab;
	return "";
}

static function SetLastTab(string Menu, string Tab)
{
	local int i;

	for (i = 0; i < default.LastTabs.Length; i++)
		if (default.LastTabs[i].Menu ~= Menu)
			break;
	if (i < default.LastTabs.Length && default.LastTabs[i].Tab == Tab)
		return;
	default.LastTabs.Length = Max(default.LastTabs.Length, i + 1);
	default.LastTabs[i].Menu = Menu;
	default.LastTabs[i].Tab = Tab;
	StaticSaveConfig();
}

static function SetLastInGameTab(string Tab)
{
	if (default.LastInGameTab == Tab)
		return;
	default.LastInGameTab = Tab;
	StaticSaveConfig();
}

static function SetLoadout(int Slot, int Team)
{
	if (default.LoadoutSlot == Slot && default.LoadoutTeam == Team)
		return;
	default.LoadoutSlot = Slot;
	default.LoadoutTeam = Team;
	StaticSaveConfig();
}

static function SetEvolutionSlot(int Slot)
{
	if (default.EvolutionSlot == Slot)
		return;
	default.EvolutionSlot = Slot;
	StaticSaveConfig();
}
