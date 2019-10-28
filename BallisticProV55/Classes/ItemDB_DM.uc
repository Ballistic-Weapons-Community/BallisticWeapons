//=============================================================================
// ItemDB_DM.
//
// This is where ItemEntrys are stored for Deathmatch maps.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ItemDB_DM extends ItemizerDB config(ItemDB_DM);

static function int DBWeight (string MapName, string ItemGroup, Actor Control)
{
	if (Left(MapName, 3) ~= "DM-")
		return 10;
	return 0;
}

defaultproperties
{
}
