//=============================================================================
// Damage Type Manager, allows multiple death and suicide messages.

// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005. All Rights Reserved.

// Ajusted by Logan "BlackEagle" Richert for use with the "BE Vehicle Pack".
//=============================================================================
class BE_DT_Manager extends WeaponDamageType
	placeable;

var(KillMessages) localized Array<string>	DeathStrings;					// Multiple deathstrings may be interesting...
var(KillMessages) localized Array<string>	FemaleSuicides, MaleSuicides;	// Multiple suicide messages

// Random messages

static function string DeathMessage(PlayerReplicationInfo Killer, PlayerReplicationInfo Victim)
{
	local string s;

	if (default.DeathStrings.Length > 0)
		s = default.DeathStrings[Rand(default.DeathStrings.Length)];
	else
		s = default.DeathString;
	return s;
}
static function string SuicideMessage(PlayerReplicationInfo Victim)
{
	if (Victim.bIsFemale && default.FemaleSuicides.Length < 1)
		return default.FemaleSuicide;
	if (default.MaleSuicides.Length < 1)
		return default.MaleSuicide;
	if (Victim.bIsFemale)
		return default.FemaleSuicides[Rand(default.FemaleSuicides.Length)];
	return default.MaleSuicides[Rand(default.MaleSuicides.Length)];
}

defaultproperties
{
     bDetonatesGoop=True
     bKUseTearOffMomentum=True
     bExtraMomentumZ=False
     bDirectDamage=False
     TransientSoundVolume=1.000000
     TransientSoundRadius=64.000000
}
