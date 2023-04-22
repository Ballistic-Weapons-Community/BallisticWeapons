//=============================================================================
// FP7SecondaryFire.
// 
// FP7 Grenade rolled underhand
// 
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class L8GISecondaryFire extends BallisticMeleeFire;


event ModeDoFire()
{

    super.ModeDoFire();
}

function NotifiedDoFireEffect()
{
	local Vector StartTrace;
    	local Rotator Aim, PointAim;
	local int i;

	//log("In NotifiedDoFireEffect");
	
	Aim = GetFireAim(StartTrace);
	Aim = Rotator(GetFireSpread() >> Aim);

	// Do trace for each point
	for (i=0;i<NumSwipePoints;i++)
	{
		if (SwipePoints[i].Weight < 0)
			continue;
		PointAim = Rotator(Vector(SwipePoints[i].Offset) >> Aim);
		MeleeDoTrace(StartTrace, PointAim, i==WallHitPoint, SwipePoints[i].Weight);
	}
	//log("A");
	// Do damage for each victim
	//log(SwipeHits.length);
	for (i=0;i<SwipeHits.length;i++)
	{
		//log("In NotifiedDoFireEffect - SwipeHits loop");
		//GiveAmmo(SwipeHits[i].Victim, SwipeHits[i].HitLoc, StartTrace, SwipeHits[i].HitDir, 0, 0);
		//log(SWipeHits[i].Victim);
	}
	SwipeHits.Length = 0;
	//log("B");
}



	
function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
	/*local float				Dmg;
	local class<DamageType>	HitDT;
	local Actor				Victim;
	local Vector			RelativeVelocity, ForceDir;

	//log("At start of GiveAdrenaline");

	Dmg = GetDamage(Other, HitLocation, Dir, Victim, HitDT);
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
	if (HookStopFactor != 0 && HookPullForce != 0 && Pawn(Victim) != None)
	{
		ForceDir = Normal(Other.Location-TraceStart);
		ForceDir.Z *= 0.3;

		//Pawn(Victim).AddVelocity( Normal(Victim.Acceleration) * HookStopFactor * -FMin(Pawn(Victim).GroundSpeed, VSize(Victim.Velocity)) - ForceDir * HookPullForce );
	}

	if (xPawn(Victim) == None)
	{
		//log("GIve adrenaline to self");
		Instigator.Controller.AwardAdrenaline(APodCapsule(BW).AdrenalineAmount);
	}
	else
	{
		//log("Victim adrenaline before: "$xPawn(Victim).Controller.Adrenaline);
		xPawn(Victim).Controller.AwardAdrenaline(APodCapsule(BW).AdrenalineAmount);
		//log("Victim adrenaline after: "$xPawn(Victim).Controller.Adrenaline);
	}*/
}

defaultproperties
{
     bAISilent=True
     FireAnim="UseOnSelf"
     FireRate=2.850000
     AmmoClass=Class'BWBP_OP_Pro.Ammo_L8GI'
     AmmoPerFire=0
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-8.00)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
}
