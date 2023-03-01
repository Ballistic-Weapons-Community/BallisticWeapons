class WrenchMeleeFire extends BallisticMeleeFire;	// XAVEDIT

#exec OBJ LOAD File=BWBP_OP_Sounds.uax

var	float	RepairAmount;	// XAVEDIT

// This is called to DoDamage to an actor found by this fire.
// Adjsuts damage based on Range, Penetrates, WallPenetrates, relative velocities and runs Hurt() to do the deed...
function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
	local float				Dmg;
	local class<DamageType>	HitDT;
	local Actor				Victim;
	local Vector			ForceDir, BoneTestLocation, ClosestLocation, testDir;
	local DestroyableObjective HealObjective;
	local Vehicle HealVehicle;
	local int AdjustedDamage, AdjustedRepair;
	
	if (Other.IsA('Monster'))
		Dmg = GetDamage(Other, HitLocation, TraceStart, Dir, Victim, HitDT);
	
	//Locational damage code from Mr Evil under test here
	else if(Other.IsA('xPawn'))
	{
		//Find a point on the victim's Z axis at the same height as the HitLocation.
		ClosestLocation = Other.Location;
		ClosestLocation.Z += (HitLocation - Other.Location).Z;
		
		//Extend the shot along its direction to a point where it is closest to the victim's Z axis.
		BoneTestLocation = Dir;
		BoneTestLocation *= VSize(ClosestLocation - HitLocation);
		BoneTestLocation *= normal(ClosestLocation - HitLocation) dot normal(HitLocation - TraceStart);
		BoneTestLocation += HitLocation;
		
		Dmg = GetDamage(Other, BoneTestLocation, TraceStart, Dir, Victim, HitDT);
	}
	
	else Dmg = GetDamage(Other, HitLocation, TraceStart, Dir, Victim, HitDT);
	//End locational damage code test
		
	if (Instigator != None)
	{
		AdjustedDamage = Dmg * Instigator.DamageScaling * DamageType.default.VehicleDamageScaling;
		AdjustedRepair = RepairAmount * Instigator.DamageScaling;	// XAVEDIT
		if (Instigator.HasUDamage())
		{
			AdjustedDamage *= 2;
			AdjustedRepair *= 2;
		}	
	}
	
	HealObjective = DestroyableObjective(Other);
	if ( HealObjective == None )
		HealObjective = DestroyableObjective(Other.Owner);
	if ( HealObjective != None && HealObjective.TeamLink(Instigator.GetTeamNum()) )
	{
		HealObjective.HealDamage(AdjustedRepair, Instigator.Controller, HitDT);	// XAVEDIT
		return;
	}

	HealVehicle = Vehicle(Other);
	if ( HealVehicle != None && HealVehicle.TeamLink(Instigator.GetTeamNum()) )
	{
		HealVehicle.HealDamage(AdjustedRepair, Instigator.Controller, HitDT);	// XAVEDIT
		return;
	}
	
	if (WrenchDeployable(Other) != None && Other.Instigator == Instigator)
	{
		WrenchDeployable(Other).AddHealth(AdjustedRepair);	// XAVEDIT
		return;
	}
	
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
	if (HookStopFactor != 0 && HookPullForce != 0 && Pawn(Victim) != None && Pawn(Victim).bProjTarget)
	{
		ForceDir = Normal(Other.Location-TraceStart);
		ForceDir.Z *= 0.3;

		Pawn(Victim).AddVelocity( Normal(Victim.Acceleration) * HookStopFactor * -FMin(Pawn(Victim).GroundSpeed, VSize(Victim.Velocity)) - ForceDir * HookPullForce );
	}

	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, KickForce * Dir, HitDT);
}

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
     RepairAmount=75.000000
     SwipePoints(0)=(offset=(Yaw=-1536))
     SwipePoints(1)=(offset=(Yaw=0))
     SwipePoints(2)=(offset=(Yaw=1536))
     WallHitPoint=1
     NumSwipePoints=3
     FatiguePerStrike=0.250000
     TraceRange=(Min=150.000000,Max=150.000000)
     Damage=80.000000
     DamageType=Class'BWBP_OP_Pro.DTWrenchHit'
     DamageTypeHead=Class'BWBP_OP_Pro.DTWrenchHitHead'
     DamageTypeArm=Class'BWBP_OP_Pro.DTWrenchHit'
     KickForce=100
     HookStopFactor=1.700000
     HookPullForce=100.000000
     bReleaseFireOnDie=False
     BallisticFireSound=(Sound=SoundGroup'BWBP_OP_Sounds.Wrench.Wrench-Swing',Radius=378.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepSmash"
     FireAnim="Smash"
     FireRate=1.250000
     AmmoClass=Class'BWBP_OP_Pro.Ammo_Wrench'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=128.000000)
     ShakeRotRate=(X=2500.000000,Y=2500.000000,Z=2500.000000)
     ShakeRotTime=2.500000
     BotRefireRate=0.800000
     WarnTargetPct=0.050000
}
