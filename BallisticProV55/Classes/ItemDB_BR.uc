//=============================================================================
// ItemDB_Deathmatch.
//
// This is where ItemEntrys are stored for Bombing Run maps.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ItemDB_BR extends ItemizerDB config(ItemDB_BR);

static function int DBWeight (string MapName, string ItemGroup, Actor Control)
{
	if (Left(MapName, 3) ~= "BR-")
		return 10;
	return 0;
}

defaultproperties
{
}
