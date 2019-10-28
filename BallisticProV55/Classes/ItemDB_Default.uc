//=============================================================================
// ItemDB_Default.
//
// The default itemizer database, where items go to die... Sorry, I mean this
// is where item entrys are stored if the Itemizer system could not find a
// proper database for them
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ItemDB_Default extends ItemizerDB;

static function int DBWeight (string MapName, string ItemGroup, Actor Control)
{
	return 1;
}

defaultproperties
{
}
