//=============================================================================
// BloodSetHunter.
//
// This is a great part of the system and adds scope for all kinds of cool blood mods!
// It takes the job of actually picking the right bloodsets to give to the demanding gore system.
//
// These are special static classes used to:
// - match up BloodSets to victims
// - get quick access to the right bloodsets
// - store a list of matches for quick rereference
// - add a great deal of flexability and modability to the system
//
// Gore systems can simply call GetBloodSetFor() to get the right bloodset for a given victim
// This function can be subclassed and called on that class for more power and optimization
//
// To make custom BloodSet mods, and int system has been added that allows int files to
// reference custom BloodSetHunter sub-classes. These classes can use the PickBloodSet()
// function to recommend their own BloodSets along with a weight
//
// Once GetBloodSetFor() has found a bloodset for a new type of victim, it will add a
// match to the Matches array which will be used for quick access next time.
//
// A special static class used to keep track and find the right bloodset for a
// specific victim.
// The hunter uses several ways to match up a character and a bloodset.
// A list of matches is stored in this base class for quick reference once the
// matches have been found.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BloodSetHunter extends Object;

// ----------------------------------------------------------------------------
struct BloodSetMatch
{
	var() string					CharacterName;
	var() class<BallisticBloodSet>	BloodSet;
};
var   array<BloodSetMatch>			Matches;
var   array<class<BloodSetHunter> >	Hunters;
var   bool							bHuntersLoaded;
// ----------------------------------------------------------------------------

// This returns a bloodset for the given victim
static function class<BallisticBloodSet> GetBloodSetFor (Pawn Victim)
{
	local int i, BestWeight;
	local class<BallisticBloodSet>	BS, BestBS;

	if (Victim == None || Victim.PlayerReplicationInfo == None)
		return None;
	// Check our matches and see if we've already figured out the bloodset for this character
	for (i=0;i<class'BloodSetHunter'.default.Matches.length;i++)
		if (class'BloodSetHunter'.default.Matches[i].CharacterName ~= Victim.PlayerReplicationInfo.CharacterName)
			return class'BloodSetHunter'.default.Matches[i].BloodSet;
	// Load all the custom hunters for int files if not already done
	if (!class'BloodSetHunter'.default.bHuntersLoaded)
		LoadHunters(Victim);
	// Go through all custom hunters and see if they can come up with the right set
	for(i=0;i<class'BloodSetHunter'.default.Hunters.length;i++)
	{
		BS = class'BloodSetHunter'.default.Hunters[i].static.PickBloodSet(Victim, BestWeight);
		if (BS != None)
			BestBS = BS;
	}
	if (BestBS != None)
		BS = BestBS;
	else
	{
		Bs = PickBloodSet(Victim, BestWeight);
	}
	// Add our finding to the matches list for future reference
	class'BloodSetHunter'.default.Matches.length = i+1;
	class'BloodSetHunter'.default.Matches[i].CharacterName = Victim.PlayerReplicationInfo.CharacterName;
	class'BloodSetHunter'.default.Matches[i].BloodSet = BS;

	return BS;
}
// Good mods would never end up here...
static function class<BallisticBloodSet> PickBloodSet (Pawn Victim, out int Weight)
{
	return class'BallisticBloodSet';
}
// Load all hunters from int
static function LoadHunters (Pawn Victim)
{
	local int i;
	local array<string>	HunterList;
	local class<BloodSetHunter> HC;

	Victim.GetAllInt("BloodSetHunter", HunterList);
	for(i=0;i<HunterList.length;i++)
	{
		HC = class<BloodSetHunter>(DynamicLoadObject(HunterList[i], class'Class'));
		if (HC != None)
			class'BloodSetHunter'.default.Hunters[class'BloodSetHunter'.default.Hunters.length] = HC;
	}
	class'BloodSetHunter'.default.bHuntersLoaded = true;
}

defaultproperties
{
}
