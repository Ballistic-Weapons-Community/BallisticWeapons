//=============================================================================
// ItemDB_Deathmatch.
//
// This is where ItemEntrys are stored for Onslaught maps.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ItemDB_ONS extends ItemizerDB config(ItemDB_ONS);

static function int DBWeight (string MapName, string ItemGroup, Actor Control)
{
	if (Left(MapName, 4) ~= "ONS-")
		return 10;
	return 0;
}

defaultproperties
{
}
