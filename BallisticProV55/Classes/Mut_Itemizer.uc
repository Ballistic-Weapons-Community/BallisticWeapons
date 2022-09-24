//=============================================================================
// Mut_Itemizer.
//
// A basic mutator that can be used to spawn Itemizer Items
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Mut_Itemizer extends Mutator
	transient
	HideDropDown
	CacheExempt;

var() config string ItemGroup;
var() string GroupDisplayText, GroupDescText;

function PostBeginPlay()
{
	super.PostBeginPlay();
	class'ItemizerDB'.static.SpawnItems(class'ItemizerDB'.static.GetMap(self), ItemGroup, self, true);
}
static function FillPlayInfo(PlayInfo PlayInfo)
{
	Super.FillPlayInfo(PlayInfo);
	PlayInfo.AddSetting(default.RulesGroup, "ItemGroup", default.GroupDisplayText, 0, 1, "Text", "20");
}

static event string GetDescriptionText(string PropName)
{
	if (PropName == "ItemGroup")
		return default.GroupDescText;

	return Super.GetDescriptionText(PropName);
}

defaultproperties
{
     GroupDisplayText="Itemizer Group"
     GroupDescText="The name of the item layout you want to use."
     GroupName="Itemizer"
     FriendlyName="Itemizer Pro"
     Description="Adds in items that have been manually placed with the Itemizer Tool"
}
