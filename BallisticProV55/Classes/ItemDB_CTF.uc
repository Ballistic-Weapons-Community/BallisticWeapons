//=============================================================================
// ItemDB_CTF.
//
// This is where ItemEntrys are stored for CTF maps.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ItemDB_CTF extends ItemizerDB config(ItemDB_CTF);

static function int DBWeight (string MapName, string ItemGroup, Actor Control)
{
	if (Left(MapName, 4) ~= "CTF-")
		return 10;
	return 0;
}

defaultproperties
{
}
