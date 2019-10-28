//=============================================================================
// Damage type for teleport lamer scum.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_TeleportLamer extends DT_BWMiscDamage;

// Random messages
static function string DeathMessage(PlayerReplicationInfo Killer, PlayerReplicationInfo Victim)
{
	local string s;
	
	if (default.bSimpleDeathMessages)
		s = "%k [Teleport Camper Reversal] %o";

	else if (default.DeathStrings.Length > 0)
		s = default.DeathStrings[Rand(default.DeathStrings.Length)];
	else
		s = default.DeathString;
	return static.Detag(s, Victim, Killer);
}

static function string SuicideMessage(PlayerReplicationInfo Victim)
{
	if (default.bSimpleDeathMessages)
	{
			return "%o [Teleport Camper Suicide]";
	}
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
     bDetonatesBombs=False
     DamageIdent="Grenade"
     DeathString="%o tried to cheese %k with a mined teleporter, and ate the damage %vs."
     FemaleSuicide="%o tried to cheese by mining a teleporter."
     MaleSuicide="%o tried to cheese by mining a teleporter."
     bArmorStops=False
     bLocationalHit=False
     bSkeletize=True
     bCausesBlood=False
     bDelayedDamage=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
     VehicleDamageScaling=0.000000
}
