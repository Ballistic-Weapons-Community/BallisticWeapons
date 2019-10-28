//=============================================================================
// ItemDB_Ballistic.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ItemDB_Ballistic extends ItemizerDB config(ItemDB_Ballistic);

static function int DBWeight (string MapName, string ItemGroup, Actor Control)
{
	if (ItemGroup ~= "Ballistic")
		return 20;
	return 0;
}

defaultproperties
{
}
