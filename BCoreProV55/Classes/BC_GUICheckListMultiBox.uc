//=============================================================================
// BC_GUICheckListBox.
//
// List box for the GUICheckList
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BC_GUICheckListMultiBox extends GUIListBox;

var	BC_GUICheckListMulti CheckList;

function InitBaseList(GUIListBase LocalList)
{
	if ((CheckList == None || CheckList != LocalList) && BC_GUICheckListMulti(LocalList) != None)
		CheckList = BC_GUICheckListMulti(LocalList);

	Super.InitBaseList(LocalList);
}

defaultproperties
{
     DefaultListClass="BCoreProV55.BC_GUICheckListMulti"
}
