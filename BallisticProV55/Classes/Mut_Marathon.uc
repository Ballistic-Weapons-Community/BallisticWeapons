class Mut_Marathon extends Mut_Sprinter
	HideDropDown
	CacheExempt;

function ModifyPlayer(Pawn Other)
{
	local BCSprintControl SC;

	Super(Mutator).ModifyPlayer(Other);

	if (xPawn(Other) != none && GetSprintControl(PlayerController(Other.Controller)) == None)
	{
		SC = Spawn(class'BWMarathonSprintControl',Other);
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

	super(Mutator).Mutate(MutateString, Sender);
}

defaultproperties
{
     FriendlyName="BallisticPro: Marathon"
     Description="Infinite sprint. Designed primarily for Assault and Onslaught use."
}
