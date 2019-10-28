//=============================================================================
// ItemDB_Deathmatch.
//
// This is where ItemEntrys are stored for Assault maps.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ItemDB_AS extends ItemizerDB config(ItemDB_AS);

static function int DBWeight (string MapName, string ItemGroup, Actor Control)
{
	if (Left(MapName, 3) ~= "AS-")
		return 10;
	return 0;
}

defaultproperties
{
}
