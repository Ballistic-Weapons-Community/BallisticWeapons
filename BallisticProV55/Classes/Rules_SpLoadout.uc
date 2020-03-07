class Rules_SpLoadout extends GameRules;

var class<DamageType>			LastDT;

// Count damage dealt by each player
function int NetDamage( int OriginalDamage, int Damage, pawn Injured, pawn instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType )
{
	local int Dmg;

	Dmg = super.NetDamage( OriginalDamage,Damage,Injured,instigatedBy,HitLocation,Momentum,DamageType );

	if (Injured != None && instigatedBy != None && instigatedBy != Injured && instigatedBy.PlayerReplicationInfo != None)
		ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(instigatedBy.PlayerReplicationInfo)).PlayerDamage += Dmg;

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
		// Somehow managed to suicide while using a sniper weapons
		if ((LastDT.default.bSpecial || Killed.Pawn.Weapon.bSniping) && ClassIsChildOf(Killed.Pawn.Weapon.Class, class<WeaponDamageType>(LastDT).default.WeaponClass))
			ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(Killed.PlayerReplicationInfo)).SniperKills -= 1;
		else
			ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(Killed.PlayerReplicationInfo)).SniperKills -= 0.2;
			
		// Suicided by Hazard damage. This is pretty likely...
		if (BDT != None && BDT.static.IsDamage(",Hazard,"))
			ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(Killed.PlayerReplicationInfo)).HazardKills -= 1;
		else
			ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(Killed.PlayerReplicationInfo)).HazardKills -= 0.2;
			
		// Suicide with shotgun, somehow...
		if (BallisticWeapon(Killed.Pawn.Weapon) != None && BallisticWeapon(Killed.Pawn.Weapon).bWT_Shotgun && ClassIsChildOf(Killed.Pawn.Weapon.Class, class<WeaponDamageType>(LastDT).default.WeaponClass))
			ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(Killed.PlayerReplicationInfo)).ShotgunKills -= 1;
		else
			ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(Killed.PlayerReplicationInfo)).ShotgunKills -= 0.2;
	}
	// Reward for killing
	if (Killer != None && Killer.PlayerReplicationInfo!=None)
	{
		// Try figure out how far apart killer and killed are
		if (Killed != None && Killer.Pawn != None && Killer.Pawn != None)
			Dist = VSize(Killer.Pawn.location - Killed.Pawn.location);
		else if (Killed != None)
			Dist = VSize(Killer.location - Killed.location);
		else
			Dist = 1000;
		// Some sniper skill for a headshot
		if (LastDT.default.bSpecial)
			ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(Killer.PlayerReplicationInfo)).SniperKills += 1;
		// Sniper bonus for killing from long range
		if (Dist > 1000 && (LastDT.default.bLocationalHit || LastDT.default.bInstantHit) && (BDT==None || !BDT.static.IsDamage(",NonSniper,")))
			ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(Killer.PlayerReplicationInfo)).SniperKills += (Dist-1000) / 8000;
			
		// Shotgun skill for killing close up with a bullet weapon or known BW shotgun
		if (LastDT.default.bBulletHit || (Killer.pawn != None && Killer.Pawn.Weapon != None && BallisticWeapon(Killed.Pawn.Weapon) != None && BallisticWeapon(Killed.Pawn.Weapon).bWT_Shotgun))
		{
			if (Dist <= 150)
				ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(Killer.PlayerReplicationInfo)).ShotgunKills += 1;
			if (Dist <= 1200)
				ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(Killer.PlayerReplicationInfo)).ShotgunKills += 1 - FMax(0, (Dist-150)/1050);
		}
		
		// Hazard skill reward for killing people with Hazardous weapons
		if (BDT != None && BDT.static.IsDamage(",Hazard,"))
			ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(Killer.PlayerReplicationInfo)).HazardKills += 1;
	}
	// Punish death
	if (Killed != None && Killed.Pawn != None && Killed.Pawn.Weapon != None)
	{	
		// Died holding a sniper weapon
		if (Killed.Pawn.Weapon.bSniping)
			ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(Killed.PlayerReplicationInfo)).DeathsHoldingSniper += 1;
		if (BallisticWeapon(Killed.Pawn.Weapon) != None)
		{	// Holding a shotgun
			if (BallisticWeapon(Killed.Pawn.Weapon).bWT_Shotgun)
				ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(Killed.PlayerReplicationInfo)).DeathsHoldingShotgun += 1;
			else if (BallisticWeapon(Killed.Pawn.Weapon).bWT_Bullet && !BallisticWeapon(Killed.Pawn.Weapon).bSniping)
				ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(Killed.PlayerReplicationInfo)).DeathsHoldingShotgun+= 0.25;
			// Holding a hazardous weapon. These dudes are well known for their short, violent lives...
			if (BallisticWeapon(Killed.Pawn.Weapon).bWT_Hazardous)
				ConflictLoadoutLRI(class'Mut_Ballistic'.static.GetBPRI(Killed.PlayerReplicationInfo)).DeathsHoldingHazard += 1;
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
