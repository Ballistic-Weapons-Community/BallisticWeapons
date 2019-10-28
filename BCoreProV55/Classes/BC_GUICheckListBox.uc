//=============================================================================
// BC_GUICheckListBox.
//
// List box for the GUICheckList
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BC_GUICheckListBox extends GUIListBox;

var	BC_GUICheckList CheckList;

function InitBaseList(GUIListBase LocalList)
{
	if ((CheckList == None || CheckList != LocalList) && BC_GUICheckList(LocalList) != None)
		CheckList = BC_GUICheckList(LocalList);

	Super.InitBaseList(LocalList);
}

defaultproperties
{
     DefaultListClass="BCoreProV55.BC_GUICheckList"
}
