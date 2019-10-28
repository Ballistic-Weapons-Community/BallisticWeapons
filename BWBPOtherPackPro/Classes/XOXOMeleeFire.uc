class XOXOMeleeFire extends BallisticMeleeFire;

function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
	local float				Dmg;
	local class<DamageType>	HitDT;
	local Actor				Victim;
	local bool				bWasAlive;
	local Vector			testDir;

	Dmg = GetDamage(Other, HitLocation, Dir, Victim, HitDT);
	
	if (HoldTime > 0)
		Dmg += Dmg * 1.15  * (FMin(HoldTime, MaxBonusHoldTime)/MaxBonusHoldTime);
	else if (ThisModeNum == 2 && HoldStartTime != 0)
	{
		Dmg += Dmg * 1.15 * (FMin(Level.TimeSeconds - HoldStartTime, MaxBonusHoldTime)/MaxBonusHoldTime);
		HoldStartTime = 0.0f;
	}
	
	if (bCanBackstab)
	{
		testDir = Dir;
		testDir.Z = 0;
	
		if (Vector(Victim.Rotation) Dot testDir > 0.2)
			Dmg *= 1.5;
		Dmg = Min(Dmg, 230);
	}
	
	if (xPawn(Victim) != None && Pawn(Victim).Health > 0)
	{
		if (Monster(Victim) == None || Pawn(Victim).default.Health > 275)
			bWasAlive = true;
	}
	
	if (BallisticPawn(Instigator) != None && RSNovaStaff(Instigator.Weapon) != None && Victim.bProjTarget && (Pawn(Victim).GetTeamNum() != Instigator.GetTeamNum() || Instigator.GetTeamNum() == 255))
		BallisticPawn(Instigator).GiveAttributedHealth(Dmg / 1.5, Instigator.HealthMax, Instigator, True);

	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, KickForce * Dir, HitDT);
	if (bWasAlive && Pawn(Victim).Health <= 0)
		class'XOXOLewdness'.static.DistributeLewd(HitLocation, Instigator, Pawn(Victim), Weapon);
}

defaultproperties
{
     DamageHead=75.000000
     DamageLimb=75.000000
     DamageType=Class'BWBPOtherPackPro.DTXOXOStab'
     DamageTypeHead=Class'BWBPOtherPackPro.DTXOXOStab'
     DamageTypeArm=Class'BWBPOtherPackPro.DTXOXOStab'
     KickForce=100
     HookStopFactor=1.700000
     HookPullForce=100.000000
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     bIgnoreReload=True
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=Sound'BWBPOtherPackSound.XOXO.XOXO-Stab',Radius=256.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepStab"
     FireAnim="Stab"
     FireAnimRate=1.350000
     TweenTime=0.000000
     FireRate=0.600000
     AmmoClass=Class'BWBPOtherPackPro.Ammo_XOXO'
     AmmoPerFire=0
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.700000
     WarnTargetPct=0.050000
}
