//=============================================================================
// CItem_JS_TrashLid.
//
// FIXME
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class CItem_JS_TrashLid extends ConflictItem;

// Add some health
static function bool Applyitem(Pawn Other)
{
	local Inventory Inv;
	local class<Inventory>	InvClass;

	InvClass = class<Inventory>(DynamicLoadObject("BWBP_JWC_Pro.JS_TrashLid",class'class'));
	if (InvClass != None)
	{
	    Inv = Other.FindInventoryType(InvClass);
    	if (Inv == None)
	    {
			Inv = Other.Spawn(InvClass, Other);
			if (Inv != None)
			{
				Inv.GiveTo(Other);
				return true;
			}
		}
	}
	return false;
}

defaultproperties
{
     ItemName="Trash Can Lid"
     Description="Trash Can Lid.|Gives you a JunkWar Trash Can Lid."
     Icon=Texture'BWBP_JW_Tex.Icons.Icon_JWTrash'
}
