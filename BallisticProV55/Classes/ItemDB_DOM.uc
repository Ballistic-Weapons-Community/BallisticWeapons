//=============================================================================
// ItemDB_Deathmatch.
//
// This is where ItemEntrys are stored for Domination maps.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ItemDB_DOM extends ItemizerDB config(ItemDB_DOM);

static function int DBWeight (string MapName, string ItemGroup, Actor Control)
{
	if (Left(MapName, 4) ~= "DOM-")
		return 10;
	return 0;
}

defaultproperties
{
}
