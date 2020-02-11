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
class FlameSwordPrimaryFire extends BallisticMeleeFire;

var() Array<name> SliceAnims;
var int SliceAnim;

var()	float			HeatPerShot;

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

//The LS-14 deals increased damage to targets which have already been heated up by a previous strike.
function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
	local float							Dmg;
	local class<DamageType>	HitDT;
	local Actor							Victim;
	local Vector						BoneTestLocation, ClosestLocation;
	local	int								Bonus;
	
	//Locational damage code from Mr Evil under test here
	if(Other.IsA('xPawn'))
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

	if (RangeAtten != 1.0)
		Dmg *= Lerp(VSize(HitLocation-TraceStart)/TraceRange.Max, 1, RangeAtten);
	if (WaterRangeAtten != 1.0 && WaterHitLocation != vect(0,0,0))
		Dmg *= Lerp(VSize(HitLocation-WaterHitLocation) / (TraceRange.Max*WaterRangeFactor), 1, WaterRangeAtten);
	if (PenetrateCount > 0)
		Dmg *= PDamageFactor ** PenetrateCount;
	if (WallCount > 0)
		Dmg *= WallPDamageFactor ** WallCount;
		
	/*if (Monster(Other) != None)
	{
		class'BallisticDamageType'.static.GenericHurt (Victim, 45, Instigator, HitLocation, KickForce * Dir, HitDT);
		return;
	}*/

	if (Pawn(Other) != None && Pawn(Other).bProjTarget)
		Bonus = FlameSword(BW).ManageHeatInteraction(Pawn(Other), HeatPerShot);
		
	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg + Bonus, Instigator, HitLocation, KickForce * Dir, HitDT);
}
defaultproperties
{
	 HeatPerShot=35.000000
     SliceAnims(0)="Swing1"
     SliceAnims(1)="Swing2"
     SliceAnims(2)="Swing3"
     SwipePoints(0)=(Weight=3,offset=(Yaw=2560))
     SwipePoints(1)=(Weight=5,offset=(Yaw=1280))
     SwipePoints(2)=(Weight=6)
     SwipePoints(3)=(Weight=4,offset=(Yaw=-1280))
     SwipePoints(4)=(Weight=2,offset=(Yaw=-2560))
     WallHitPoint=2
     NumSwipePoints=5
     FatiguePerStrike=0.100000
     bCanBackstab=False
     TraceRange=(Min=150.000000,Max=150.000000)
     Damage=65.000000
     DamageHead=65.000000
     DamageLimb=65.000000
     DamageType=Class'BWBPSomeOtherPack.DT_FlameSwordChest'
     DamageTypeHead=Class'BWBPSomeOtherPack.DT_FlameSwordHead'
     DamageTypeArm=Class'BWBPSomeOtherPack.DT_FlameSwordChest'
     KickForce=100
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.DTS.DragonsTooth-Swipe',Volume=4.100000,Radius=256.000000,bAtten=True)
     bAISilent=True
     FireAnim="Slash1"
	 FireRate=0.80
     AmmoClass=Class'BallisticProV55.Ammo_Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=256.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.800000
}
