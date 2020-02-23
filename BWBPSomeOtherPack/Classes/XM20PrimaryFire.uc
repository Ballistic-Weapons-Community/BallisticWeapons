//=============================================================================
// LS-14 Primary Fire.
//
// Laser weapon with overheating mechanism. Deals more damage the lower the weapon's heat level is.
// Does not cut out if maximum heat is reached.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class XM20PrimaryFire extends BallisticRangeAttenFire;

var()	float			HeatPerShot;

simulated function bool AllowFire()
{
	if (XM20AutoLas(BW).bShieldUp)
		return false;
	return Super.AllowFire();
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
		
	if (Monster(Other) != None)
	{
		class'BallisticDamageType'.static.GenericHurt (Victim, 45, Instigator, HitLocation, KickForce * Dir, HitDT);
		return;
	}

	if (Pawn(Other) != None && Pawn(Other).bProjTarget)
		Bonus = XM20AutoLas(BW).ManageHeatInteraction(Pawn(Other), HeatPerShot);
		
	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg + Bonus, Instigator, HitLocation, KickForce * Dir, HitDT);
}

defaultproperties
{
     HeatPerShot=10.000000
     CutOffDistance=3072.000000
     CutOffStartRange=1536.000000
     TraceRange=(Min=11000.000000,Max=12000.000000)
     MaxWallSize=64.000000
     MaxWalls=3
     Damage=10.000000
     DamageHead=15.000000
     DamageLimb=10.000000
     DamageType=Class'BWBPSomeOtherPack.DTXM20Body'
     DamageTypeHead=Class'BWBPSomeOtherPack.DTXM20Head'
     DamageTypeArm=Class'BWBPSomeOtherPack.DTXM20Body'
     PenetrateForce=500
     bPenetrate=True
     ClipFinishSound=(Sound=Sound'PackageSounds4Pro.LS14.Gauss-LastShot',Volume=1.000000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'PackageSounds4Pro.LS14.Gauss-Empty',Volume=1.200000)
     MuzzleFlashClass=Class'BWBPSomeOtherPack.XM20FlashEmitter'
     FlashScaleFactor=0.400000
     RecoilPerShot=230.000000
     FireChaos=0.045000
	 FireAnim="Fire"
	 AimedFireAnim="SightFire"
     BallisticFireSound=(Sound=SoundGroup'PackageSounds4Pro.XM20.XM20-PulseFire',Volume=1.500000)
     FireEndAnim=
     FireRate=0.110000
     AmmoClass=Class'BWBPSomeOtherPack.Ammo_XM20Laser'
     ShakeRotMag=(X=200.000000,Y=16.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=-2.500000)
     ShakeOffsetRate=(X=-500.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.99
     WarnTargetPct=0.30000
     aimerror=800.000000
}
