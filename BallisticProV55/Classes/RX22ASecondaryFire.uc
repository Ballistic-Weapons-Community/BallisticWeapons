//=============================================================================
// RX22ASecondaryFire.
//
// Unignited fuel spray. Creates different kinds of fuel deposits depending
// on what it hits. These can be ignited later on.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RX22ASecondaryFire extends BallisticFire;

function RX22AFireControl GetFireControl()
{
	return RX22AFlamer(Weapon).GetFireControl();
}

function float MaxRange()	{	return 800;	}

function bool HookFire(Vector Start, Vector Dir, float Dist, out Vector HitLoc)
{
	local int i;
	local bool bFoundFire;
	local float NodeDist, DR;
	local vector HL;
	Hl = HitLoc;
	for (i=0;i<GetFireControl().GasNodes.Length;i++)
	{
		if (GetFireControl().GasNodes[i] == None)
			continue;
		if (RX22AGasCloud(GetFireControl().GasNodes[i]) != None || RX22AGasPatch(GetFireControl().GasNodes[i]) != None || RX22AGasSoak(GetFireControl().GasNodes[i]) != None)
			continue;
		NodeDist = VSize(GetFireControl().GasNodes[i].Location-Start);
		if (NodeDist > Dist)
			continue;
		DR = Dir Dot Normal(GetFireControl().GasNodes[i].Location-Start);
		if (DR < 0.75)
			continue;
		HL = Start + Dir * NodeDist;
		NodeDist = VSize(GetFireControl().GasNodes[i].Location - (Start + Dir * (DR * NodeDist)));
//		if (Dir Dot Normal(GetFireControl().GasNodes[i].Location-Start) < 0.75 + (NodeDist/MaxRange())*0.2)
		if (NodeDist > 96)
			continue;
		HitLoc = Start + Dir * NodeDist;
		GetFireControl().GasNodes[i].AddFuel(1);
		bFoundFire = true;
	}
	HitLoc = HL;
	return bFoundFire;
}

function DoFireEffect()
{
    local Vector Start, Dir, End, HitLoc, HitNorm;
	local Actor T;
	local int i;

    Start = Instigator.Location + Instigator.EyePosition();
    Dir = Vector(Rotator(GetFireSpread() >> GetFireAim(Start)));
	End = Start + Dir * MaxRange();

	Weapon.bTraceWater=true;
	for (i=0;i<20;i++)
	{
		T = Trace(HitLoc, HitNorm, End, Start, true);
		if (T==None || (T != Instigator && T.Base != Instigator))
			break;
		Start = HitLoc + Dir * FMax(32, T.CollisionRadius*2 + 4);
	}
	Weapon.bTraceWater=false;
	if (T == None)
	{
		HitLoc = End;
		if (!HookFire(Start, Dir, MaxRange() + 128, HitLoc))
			GetFireControl().SprayAir(HitLoc, Instigator);
	}
	else if (Pawn(T) != None)
	{
		if (!HookFire(Start, Dir, VSize(HitLoc - Start), HitLoc))
			GetFireControl().SpraySoak(T, Instigator);
	}
	else
	{
		if (!HookFire(Start, Dir, VSize(HitLoc - Start), HitLoc))
			GetFireControl().SprayWall(HitLoc, HitNorm, Instigator, T);
	}

	SendFireEffect(T, HitLoc, HitNorm, 0);

//	GetFireControl().StartSpray(Start, HitLoc, VSize(HitLoc-Start), T != None, HitNorm);
}

function PlayFiring()
{
	BW.SafeLoopAnim(FireLoopAnim, FireAnimRate, TweenTime, ,"FIRE");
//	BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;

	Weapon.AmbientSound = BallisticFireSound.Sound;
}
function ServerPlayFiring()
{
	Weapon.AmbientSound = BallisticFireSound.Sound;
//	Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
}

function StopFiring()
{
//	if (Weapon.GetFireMode(0).NextFireTime > NextFireTime)
//		Weapon.GetFireMode(0).StopFiring();
	RX22AFlamer(Weapon).AmbientSound = None;
}

simulated function bool AllowFire()
{
	if (!super.AllowFire() || Instigator.HeadVolume.bWaterVolume || Weapon.GetFireMode(0).NextFireTime > level.TimeSeconds - 0.2)
	{
		if (IsFiring())
			StopFiring();
		return false;
	}
	return true;
}

defaultproperties
{
     FireRecoil=32.000000
     XInaccuracy=128.000000
     YInaccuracy=128.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds3.RX22A.RX22A-FuelLoop',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
     EffectString="Spray gas"
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.100000
     AmmoClass=Class'BallisticProV55.Ammo_FlamerGas'
     ShakeRotMag=(X=64.000000,Y=64.000000,Z=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-10.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     WarnTargetPct=0.500000
}
