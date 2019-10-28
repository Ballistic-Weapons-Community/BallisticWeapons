//=============================================================================
// ItemGameRules.
//
// Prevents picking up of items when using Itemizer Tool.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ItemGameRules extends GameRules;

function bool OverridePickupQuery(Pawn Other, Pickup item, out byte bAllowPickup)
{
	bAllowPickup = 0;
	return true;
}

defaultproperties
{
}
