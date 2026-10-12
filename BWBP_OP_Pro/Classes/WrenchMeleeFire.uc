class WrenchMeleeFire extends BallisticMeleeFire;	// XAVEDIT

#exec OBJ LOAD File=BWBP_OP_Sounds.uax

var	float	RepairAmount;	// XAVEDIT

// The wrench mends what is its team's or its holder's instead of striking it: objectives, vehicles and his own
// deployables. (That was in DoDamage, which nothing has called since OnTraceHit took its place: the wrench struck
// them like anything else.)
function OnTraceHit (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, int WallPenForce, optional vector WaterHitLocation)
{
	local DestroyableObjective HealObjective;
	local Vehicle HealVehicle;
	local int AdjustedRepair;

	if (Instigator != None && Other != None)
	{
		AdjustedRepair = RepairAmount * Instigator.DamageScaling;	// XAVEDIT
		if (Instigator.HasUDamage())
			AdjustedRepair *= 2;

		HealObjective = DestroyableObjective(Other);
		if ( HealObjective == None )
			HealObjective = DestroyableObjective(Other.Owner);
		if ( HealObjective != None && HealObjective.TeamLink(Instigator.GetTeamNum()) )
		{
			HealObjective.HealDamage(AdjustedRepair, Instigator.Controller, DamageType);	// XAVEDIT
			return;
		}

		HealVehicle = Vehicle(Other);
		if ( HealVehicle != None && HealVehicle.TeamLink(Instigator.GetTeamNum()) )
		{
			HealVehicle.HealDamage(AdjustedRepair, Instigator.Controller, DamageType);	// XAVEDIT
			return;
		}

		if (WrenchDeployable(Other) != None && Other.Instigator == Instigator)
		{
			WrenchDeployable(Other).AddHealth(AdjustedRepair);	// XAVEDIT
			return;
		}
	}

	Super.OnTraceHit(Other, HitLocation, TraceStart, Dir, PenetrateCount, WallCount, WallPenForce, WaterHitLocation);
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
     BallisticFireSound=(Sound=SoundGroup'BWBP_OP_Sounds.Wrench.Wrench-Swing',Radius=24.000000,batten=false)
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
