//=============================================================================
// Mut_Sprinter.
//
// This mutator gives each player a sprint control to let them sprint and is
// also used to send key events to the sprint controls.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Mut_ChargeSprinter extends Mutator
	HideDropDown
	CacheExempt;

var   Array<BCSprintControl> Sprinters;

function ModifyPlayer(Pawn Other)
{
	local BCSprintControl SC;

	Super.ModifyPlayer(Other);

	if (xPawn(Other) != none && GetSprintControl(PlayerController(Other.Controller)) == None)
	{
		SC = Other.Spawn(class'BWRechargeSprintControl',Other);
		SC.GiveTo(Other);
		Sprinters[Sprinters.length] = SC;
	}
}

function BCSprintControl GetSprintControl(PlayerController Sender)
{
	local int i;

	for (i=0;i<Sprinters.length;i++)
		if (Sprinters[i] != None && Sprinters[i].Instigator != None && Sprinters[i].Instigator.Controller == Sender)
			return Sprinters[i];
	return None;
}

function Mutate(string MutateString, PlayerController Sender)
{
	local BCSprintControl SC;

	if (MutateString ~= "BStartSprint")
	{
		SC = GetSprintControl(Sender);
		if (SC != None)
			SC.StartSprint();
	}
	else if (MutateString ~= "BStopSprint")
	{
		SC = GetSprintControl(Sender);
		if (SC != None)
			SC.StopSprint();
	}

	super.Mutate(MutateString, Sender);
}

defaultproperties
{
     FriendlyName="BallisticPro: Recharge Delay Sprint"
     Description="This mutator gives players the ability to sprint for a short period of time. This mutator will not allow you to sprint if your level is below 20%, to prevent dodge abuse. Sprint key can be set in the controls configuration menu. It is recommended that you use this when playing with Ballistic Weapons as the weapons have integrated support for player sprinting."
}
