class BallisticRangeAttenFire extends BallisticProInstantFire;

var() float CutOffDistance;
var() float CutOffStartRange;

function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
	local float				Dmg;
	local class<DamageType>	HitDT;
	local Actor				Victim;
	local Vector			RelativeVelocity, ForceDir, BoneTestLocation, ClosestLocation;
	
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
	//End locational damage code test
	
	if (RangeAtten != 1.0 && VSize(HitLocation - TraceStart) > CutOffStartRange)
		{
		//Range = VSize(HitLocation-TraceStart);
                //Range -= CutOffStartRange;
                //Range = FClamp(Range, 0, CutOffDistance)/CutOffDistance;
		//Dmg *= Lerp(Range, 1, RangeAtten);
		Dmg *= Lerp (FClamp(VSize(HitLocation - TraceStart) - CutOffStartRange, 0, CutOffDistance)/CutOffDistance, 1, RangeAtten);
		}
	//if (WaterRangeAtten != 1.0 && WaterHitLocation != vect(0,0,0) && !((VSize(HitLocation-TraceStart)-CutOffStartRange) < 0))
		Dmg *= Lerp (FClamp(VSize(HitLocation - TraceStart) - CutOffStartRange, 0, CutOffDistance)/CutOffDistance, 1, WaterRangeAtten);
	if (PenetrateCount > 0)
		Dmg *= PDamageFactor ** PenetrateCount;
	if (WallCount > 0)
		Dmg *= WallPDamageFactor ** WallCount;
	if (bUseRunningDamage)
	{
		RelativeVelocity = Instigator.Velocity - Other.Velocity;
		Dmg += Dmg * (VSize(RelativeVelocity) / RunningSpeedThresh) * (Normal(RelativeVelocity) Dot Normal(Other.Location-Instigator.Location));
	}
	if (HookStopFactor != 0 && HookPullForce != 0 && Pawn(Victim) != None)
	{
		ForceDir = Normal(Other.Location-TraceStart);
		ForceDir.Z *= 0.3;

		Pawn(Victim).AddVelocity( Normal(Victim.Acceleration) * HookStopFactor * -FMin(Pawn(Victim).GroundSpeed, VSize(Victim.Velocity)) - ForceDir * HookPullForce );
	}

	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, KickForce * Dir, HitDT);
//	Victim.TakeDamage(Dmg, Instigator, HitLocation, KickForce * Dir, HitDT);
}

defaultproperties
{
}
