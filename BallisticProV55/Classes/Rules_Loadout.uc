class Rules_Loadout extends GameRules;

var array<int>		PlayerDamage;
var array<float>	SniperKills;
var array<float>	ShotgunKills;
var array<float>	HazardKills;

var array<int>		DeathsHoldingSniper;
var array<int>		DeathsHoldingShotgun;
var array<int>		DeathsHoldingHazard;

var class<DamageType>			LastDT;

function int GetPlayerDamage (int Index)
{
	if (Index < 0)
		return 0;
	if (Index >= PlayerDamage.length)
		PlayerDamage.length = Index + 1;
	return PlayerDamage[Index];
}
function float GetSniperEff (int Index)
{
	if (Index < 0)
		return 0;
	if (Index >= SniperKills.length)
		SniperKills.length = Index + 1;
	return SniperKills[Index];
}
function float GetShotgunEff (int Index)
{
	if (Index < 0)
		return 0;
	if (Index >= ShotgunKills.length)
		ShotgunKills.length = Index + 1;
	return ShotgunKills[Index];
}
function float GetHazardEff (int Index)
{
	if (Index < 0)
		return 0;
	if (Index >= HazardKills.length)
		HazardKills.length = Index + 1;
	return HazardKills[Index];
}

function float GetDeathsHoldingSniper (int Index)
{
	if (Index < 0)
		return 0;
	if (Index >= DeathsHoldingSniper.length)
		DeathsHoldingSniper.length = Index + 1;
	return DeathsHoldingSniper[Index];
}
function float GetDeathsHoldingShotgun (int Index)
{
	if (Index < 0)
		return 0;
	if (Index >= DeathsHoldingShotgun.length)
		DeathsHoldingShotgun.length = Index + 1;
	return DeathsHoldingShotgun[Index];
}
function float GetDeathsHoldingHazard (int Index)
{
	if (Index < 0)
		return 0;
	if (Index >= DeathsHoldingHazard.length)
		DeathsHoldingHazard.length = Index + 1;
	return DeathsHoldingHazard[Index];
}

// Count damage dealt by each player
function int NetDamage( int OriginalDamage, int Damage, pawn Injured, pawn instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType )
{
	local int Dmg;

	Dmg = super.NetDamage( OriginalDamage,Damage,Injured,instigatedBy,HitLocation,Momentum,DamageType );

	if (Injured != None && instigatedBy != None && instigatedBy != Injured && instigatedBy.PlayerReplicationInfo != None)
	{
		if (PlayerDamage.length <= instigatedBy.PlayerReplicationInfo.PlayerID)
			PlayerDamage.length = instigatedBy.PlayerReplicationInfo.PlayerID + 1;
		PlayerDamage[instigatedBy.PlayerReplicationInfo.PlayerID] += Dmg;
	}

	return Dmg;
}

// Update death and efficiency counters for killer and vic depending on the weapons involved
Function ScoreKill(Controller Killer, Controller Killed)
{
	local float Dist;
	local class<BallisticDamageType> BDT;

	super.scoreKill(Killer, Killed);

	BDT = class<BallisticDamageType>(LastDT);
	// Punish suicide
	if ((Killer == None || Killer == Killed) && Killed != None && Killed.PlayerReplicationInfo!= None && class<WeaponDamageType>(LastDT) != None)
	{
		if (SniperKills.length <= Killed.PlayerReplicationInfo.PlayerID)
			SniperKills.length  = Killed.PlayerReplicationInfo.PlayerID + 1;
		if (HazardKills.length <= Killed.PlayerReplicationInfo.PlayerID)
			HazardKills.length  = Killed.PlayerReplicationInfo.PlayerID + 1;
		if (ShotgunKills.length <= Killed.PlayerReplicationInfo.PlayerID)
			ShotgunKills.length  = Killed.PlayerReplicationInfo.PlayerID + 1;
		// Somehow managed to suicide while using a sniper weapons
		if ((LastDT.default.bSpecial || Killed.Pawn.Weapon.bSniping) && ClassIsChildOf(Killed.Pawn.Weapon.Class, class<WeaponDamageType>(LastDT).default.WeaponClass))
			SniperKills[Killed.PlayerReplicationInfo.PlayerID] -= 1;
		else
			SniperKills[Killed.PlayerReplicationInfo.PlayerID] -= 0.2;
		// Suicided by Hazard damage. This is pretty likely...
		if (BDT != None && BDT.static.IsDamage(",Hazard,"))
			HazardKills[Killed.PlayerReplicationInfo.PlayerID] -= 1;
		else
			HazardKills[Killed.PlayerReplicationInfo.PlayerID] -= 0.2;
		// Suicide with shotgun, somehow...
		if (BallisticWeapon(Killed.Pawn.Weapon) != None && BallisticWeapon(Killed.Pawn.Weapon).bWT_Shotgun && ClassIsChildOf(Killed.Pawn.Weapon.Class, class<WeaponDamageType>(LastDT).default.WeaponClass))
			ShotgunKills[Killed.PlayerReplicationInfo.PlayerID] -= 1;
		else
			ShotgunKills[Killed.PlayerReplicationInfo.PlayerID] -= 0.2;
	}
	// Reward for killing
	if (Killer != None && Killer.PlayerReplicationInfo!=None)
	{
		if (SniperKills.length <= Killer.PlayerReplicationInfo.PlayerID)
			SniperKills.length  = Killer.PlayerReplicationInfo.PlayerID + 1;
		if (HazardKills.length <= Killer.PlayerReplicationInfo.PlayerID)
			HazardKills.length  = Killer.PlayerReplicationInfo.PlayerID + 1;
		if (ShotgunKills.length <= Killer.PlayerReplicationInfo.PlayerID)
			ShotgunKills.length  = Killer.PlayerReplicationInfo.PlayerID + 1;

		// Try figure out how far apart killer and killed are
		if (Killed != None && Killer.Pawn != None && Killer.Pawn != None)
			Dist = VSize(Killer.Pawn.location - Killed.Pawn.location);
		else if (Killed != None)
			Dist = VSize(Killer.location - Killed.location);
		else
			Dist = 1000;
		// Some sniper skill for a headshot
		if (LastDT.default.bSpecial)
			SniperKills[Killer.PlayerReplicationInfo.PlayerID] += 1;
		// Sniper bonus for killing from long range
		if (Dist > 1000 && (LastDT.default.bLocationalHit || LastDT.default.bInstantHit) && (BDT==None || !BDT.static.IsDamage(",NonSniper,")))
			SniperKills[Killer.PlayerReplicationInfo.PlayerID] += (Dist-1000) / 8000;
		// Shotgun skill for killing close up with a bullet weapon or known BW shotgun
		if (LastDT.default.bBulletHit || (Killer.pawn != None && Killer.Pawn.Weapon != None && BallisticWeapon(Killed.Pawn.Weapon) != None && BallisticWeapon(Killed.Pawn.Weapon).bWT_Shotgun))
		{
			if (Dist <= 150)
				ShotgunKills[Killer.PlayerReplicationInfo.PlayerID] += 1;
			if (Dist <= 1200)
				ShotgunKills[Killer.PlayerReplicationInfo.PlayerID] += 1 - FMax(0, (Dist-150)/1050);
		}
		// Hazard skill reward for killing people with Hazardous weapons
		if (BDT != None && BDT.static.IsDamage(",Hazard,"))
			HazardKills[Killer.PlayerReplicationInfo.PlayerID] += 1;
	}
	// Punish death
	if (Killed != None && Killed.Pawn != None && Killed.Pawn.Weapon != None)
	{	// Died holding a sniper weapon
		if (Killed.Pawn.Weapon.bSniping)
			DeathsHoldingSniper[Killed.PlayerReplicationInfo.PlayerID] += 1;
		if (BallisticWeapon(Killed.Pawn.Weapon) != None)
		{	// Holding a shotgun
			if (BallisticWeapon(Killed.Pawn.Weapon).bWT_Shotgun)
				DeathsHoldingShotgun[Killed.PlayerReplicationInfo.PlayerID] += 1;
			else if (BallisticWeapon(Killed.Pawn.Weapon).bWT_Bullet && !BallisticWeapon(Killed.Pawn.Weapon).bSniping)
				DeathsHoldingShotgun[Killed.PlayerReplicationInfo.PlayerID] += 0.25;
			// Holding a hazardous weapon. These dudes are well known for their short, violent lives...
			if (BallisticWeapon(Killed.Pawn.Weapon).bWT_Hazardous)
				DeathsHoldingHazard[Killed.PlayerReplicationInfo.PlayerID] += 1;
		}
	}
}

function bool PreventDeath(Pawn Killed, Controller Killer, class<DamageType> DT, vector HitLocation)
{
	LastDT = DT;
	if (super.PreventDeath(Killed,Killer, DT, HitLocation))
		return true;
	return false;
}

defaultproperties
{
}
