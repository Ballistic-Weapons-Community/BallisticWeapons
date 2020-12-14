class XOXOMeleeFire extends BallisticMeleeFire;

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	local bool  bWasAlive;

	if (BallisticPawn(Instigator) != None && XOXOStaff(Instigator.Weapon) != None && Victim.bProjTarget && (Pawn(Victim).GetTeamNum() != Instigator.GetTeamNum() || Instigator.GetTeamNum() == 255))
		BallisticPawn(Instigator).GiveAttributedHealth(Damage * 0.66, Instigator.HealthMax, Instigator, True);

	if (xPawn(Victim) != None && Pawn(Victim).Health > 0)
	{
		if (Monster(Victim) == None || Pawn(Victim).default.Health > 275)
			bWasAlive = true;
	}

	super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (bWasAlive && Pawn(Victim).Health <= 0)
		class'XOXOLewdness'.static.DistributeLewd(HitLocation, Instigator, Pawn(Victim), Weapon);
}

defaultproperties
{
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
     BallisticFireSound=(Sound=Sound'BWBP_OP_Sounds.XOXO.XOXO-Stab',Volume=0.5,Radius=32.000000,bAtten=True)
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
