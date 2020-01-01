//=============================================================================
// CYLOSecondaryFire.
//
// A semi-auto shotgun that uses its own magazine.
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XM20SecondaryFire extends BallisticProShotgunFire;

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
		
	if (Monster(Other) != None)
	{
		class'BallisticDamageType'.static.GenericHurt (Victim, 45, Instigator, HitLocation, KickForce * Dir, HitDT);
		return;
	}

	if (Pawn(Other) != None && Pawn(Other).bProjTarget)
		Bonus = XM20AutoLas(BW).ManageHeatInteraction(Pawn(Other), HeatPerShot);
		
	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg + Bonus, Instigator, HitLocation, KickForce * Dir, HitDT);
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	XM20Attachment(Weapon.ThirdPersonActor).XM20UpdateHit(Other, HitLocation, HitNormal, Surf);
}

defaultproperties
{
	 HeatPerShot=2.000000
     CutOffDistance=1536.000000
     CutOffStartRange=1024.000000
     TraceCount=9
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=5000.000000,Max=5000.000000)
     Damage=6.000000
     DamageHead=9.000000
     DamageLimb=6.000000
     RangeAtten=0.750000
     DamageType=Class'BWBPRecolorsPro.DTCYLOShotgun'
     DamageTypeHead=Class'BWBPRecolorsPro.DTCYLOShotgunHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DTCYLOShotgun'
     KickForce=10000
     PenetrateForce=100
     bPenetrate=True
     MuzzleFlashClass=Class'BWBPSomeOtherPack.XM20FlashEmitter'
     BrassOffset=(X=-30.000000,Y=-5.000000,Z=5.000000)
     RecoilPerShot=512.000000
     VelocityRecoil=200.000000
     FireChaos=0.500000
     XInaccuracy=350.000000
     YInaccuracy=350.000000
     JamSound=(Sound=Sound'BallisticSounds3.Misc.ClipEnd-1',Volume=0.900000)
     BallisticFireSound=(Sound=SoundGroup'PackageSounds4Pro.LS14.Gauss-Fire',Volume=0.900000)
     bWaitForRelease=True
     FireAnim="FireCocking"
	 AimedFireAnim="SightFire"
     FireEndAnim=
     FireRate=0.700000
     AmmoClass=Class'BWBPSomeOtherPack.Ammo_XM20Laser'
     AmmoPerFire=5
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.700000
     WarnTargetPct=0.500000
}
