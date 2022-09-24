//=============================================================================
// BWBloodSetHunter.
//
// Ballistic systems call this hunter.
// It understands BallisticPawns and knows the default ballistic blood sets
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BWBloodSetHunter extends BloodSetHunter;

// Optimization: BallisticPawn has a BloodSet var. If its set, we can use that
static function class<BallisticBloodSet> GetBloodSetFor (Pawn Victim)
{
	if (BallisticPawn(Victim)!= None && BallisticPawn(Victim).BloodSet != None)
		return BallisticPawn(Victim).BloodSet;

	return super.GetBloodSetFor(Victim);
}
// Decide which standard ballistic bloodset to use
static function class<BallisticBloodSet> PickBloodSet (Pawn Victim, out int Weight)
{
	if (BallisticPawn(Victim)!= None && BallisticPawn(Victim).BloodSet != None)
	{
		Weight = 10;
		return BallisticPawn(Victim).BloodSet;
	}
	if (Weight > 1)
		return None;
	Weight = 1;
	if (Victim != None)
	{
		if (xPawn(Victim) != None)
		{
		//	if (xPawn(Victim)!=None && class<xAlienGibGroup>(xPawn(Victim).GibGroupClass) != None)
		//		return class'BloodSetGreen';
		//	else if (xPawn(Victim)!=None && class<xBotGibGroup>(xPawn(Victim).GibGroupClass) != None)
		//		return class'BloodSetPurple';
		//	else if (xPawn(Victim)!=None && class<SPECIES_Jugg>(xPawn(Victim).Species) != None)
		//		return class'BloodSet_Jugg';
		//	else if (Victim.bIsFemale)
				return class'BloodSet_DefaultFemale';
		}
		if (Victim.PlayerReplicationInfo != None && Victim.PlayerReplicationInfo.CharacterName == "Abaddon")
			return class'BloodSet_Abaddon';
	}
	return class'BloodSetDefault';
}

defaultproperties
{
}
