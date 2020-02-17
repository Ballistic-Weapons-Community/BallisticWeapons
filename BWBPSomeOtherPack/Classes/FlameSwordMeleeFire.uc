class FlameSwordMeleeFire extends BallisticMeleeFire;

var()	float			HeatPerShot;

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
     SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
     SwipePoints(1)=(offset=(Pitch=4500,Yaw=3000))
     SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
     SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
     SwipePoints(4)=(offset=(Yaw=0))
     SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
     SwipePoints(6)=(offset=(Pitch=-3000))
	 TraceRange=(Min=150.000000,Max=150.000000)
     WallHitPoint=4
	 HeatPerShot=50.00
     Damage=80.000000
     DamageHead=80.000000
     DamageLimb=80.000000
     DamageType=Class'BWBPSomeOtherPack.DT_FlameSwordChest'
     DamageTypeHead=Class'BWBPSomeOtherPack.DT_FlameSwordHead'
     DamageTypeArm=Class'BWBPSomeOtherPack.DT_FlameSwordChest'
     KickForce=2000
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=Sound'BWBPSomeOtherPackSounds.FlameSword.FlameSword-Swing',Volume=4.000000,Radius=256.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepSwing"
     FireAnim="Swing3"
     PreFireAnimRate=2.000000
     TweenTime=0.000000
     FireRate=0.700000
     AmmoClass=Class'BallisticProV55.Ammo_Knife'
     AmmoPerFire=0
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.050000
}
