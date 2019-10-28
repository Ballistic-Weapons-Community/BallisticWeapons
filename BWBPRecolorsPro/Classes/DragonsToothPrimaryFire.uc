//=============================================================================
// DragonsToothPrimaryFire.
//
// Horizontalish swipe attack for the EKS43. Uses melee swpie system to do
// horizontal swipes. When the swipe traces find a player, the trace closest to
// the aim will be used to do the damage.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DragonsToothPrimaryFire extends BallisticMeleeFire;

var() Array<name> SliceAnims;
var int SliceAnim;

simulated event ModeDoFire()
{
	FireAnim = SliceAnims[SliceAnim];
	SliceAnim++;
	if (SliceAnim >= SliceAnims.Length)
		SliceAnim = 0;

	Super.ModeDoFire();
}

simulated function bool HasAmmo()
{
	return true;
}

// This is called to DoDamage to an actor found by this fire.
// Adjsuts damage based on Range, Penetrates, WallPenetrates, relative velocities and runs Hurt() to do the deed...
function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
	local float				Dmg;
	local class<DamageType>	HitDT;
	local Actor				Victim;
	local Vector			RelativeVelocity, ForceDir, BoneTestLocation, ClosestLocation, testDir;
	
	if (Other.IsA('Monster'))
		Dmg = GetDamage(Other, HitLocation, Dir, Victim, HitDT);
	
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
		
		Dmg = GetDamage(Other, BoneTestLocation, Dir, Victim, HitDT);
	}
	
	else Dmg = GetDamage(Other, HitLocation, Dir, Victim, HitDT);
	//End locational damage code test
	
	if (RangeAtten != 1.0)
		Dmg *= Lerp(VSize(HitLocation-TraceStart)/TraceRange.Max, 1, RangeAtten);
	if (WaterRangeAtten != 1.0 && WaterHitLocation != vect(0,0,0))
		Dmg *= Lerp(VSize(HitLocation-WaterHitLocation) / (TraceRange.Max*WaterRangeFactor), 1, WaterRangeAtten);
	if (PenetrateCount > 0)
		Dmg *= PDamageFactor ** PenetrateCount;
	if (WallCount > 0)
		Dmg *= WallPDamageFactor ** WallCount;
	if (bUseRunningDamage)
	{
		RelativeVelocity = Instigator.Velocity - Other.Velocity;
		Dmg += Dmg * (VSize(RelativeVelocity) / RunningSpeedThresh) * (Normal(RelativeVelocity) Dot Normal(Other.Location-Instigator.Location));
	}
	
	if (HoldTime > 0)
		Dmg += Dmg * 1.15  * (FMin(HoldTime, MaxBonusHoldTime)/MaxBonusHoldTime);
	
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
	
	//Prevent abuse of speed / minime on this weapon
	if(xPawn(Instigator).CurrentCombo != None && ComboDefensive(xPawn(Instigator).CurrentCombo) == None)
		Damage *= 0.5;

	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, KickForce * Dir, HitDT);
}

defaultproperties
{
     SliceAnims(0)="Swing1"
     SliceAnims(1)="Swing2"
     SliceAnims(2)="Swing3"
     SwipePoints(0)=(offset=(Yaw=768))
     SwipePoints(1)=(offset=(Yaw=0))
     SwipePoints(2)=(offset=(Yaw=-768))
     WallHitPoint=1
     NumSwipePoints=3
     FatiguePerStrike=0.100000
     bCanBackstab=False
     TraceRange=(Min=160.000000,Max=160.000000)
     Damage=140.000000
     DamageHead=140.000000
     DamageLimb=140.000000
     DamageType=Class'BWBPRecolorsPro.DT_DTSChest'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_DTSHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_DTSLimb'
     KickForce=100
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.DTS.DragonsTooth-Swipe',Volume=4.100000,Radius=256.000000,bAtten=True)
     bAISilent=True
     FireAnim="Slash1"
     AmmoClass=Class'BallisticProV55.Ammo_Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=256.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.100000
}
