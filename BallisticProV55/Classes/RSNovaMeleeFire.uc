//=============================================================================
// RSNovaMeleeFire.
//
// Melee attack for NovaStaff.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RSNovaMeleeFire extends BallisticMeleeFire;

var() Pawn		HookedVictim;
var() float		HookTime;

simulated function bool HasAmmo()
{
	return true;
}

event ModeTick(float DT)
{
	local Vector ForceDir;
	super.ModeTick(DT);

	if (Weapon.Role == ROLE_Authority && HookedVictim != None && vector(Instigator.GetViewRotation()) Dot Normal(HookedVictim.Location - Instigator.Location) > 0.8)
	{
		ForceDir = (Instigator.Location + vector(Instigator.GetViewRotation()) * 192) - HookedVictim.Location;
		if (Instigator.Physics == PHYS_Falling)
			ForceDir.Z = 0;

		ForceDir *= 400;
		HookedVictim.AddVelocity(HookedVictim.Velocity*-0.7 + (ForceDir/HookedVictim.Mass) * DT);
//		HookedVictim.AddVelocity(Normal(ForceDir) * DT * FMin(600, VSize(ForceDir) * 25));
		if (level.TimeSeconds - HookTime > 0.5)
			HookedVictim = None;
	}
}

function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
	local float				Dmg;
	local class<DamageType>	HitDT;
	local Actor				Victim;
	local bool				bWasAlive;
	local Vector			BoneTestLocation, ClosestLocation, testDir;

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

	if (RSNovaStaff(Weapon).bOnRampage)
		Dmg *= 2.0;
		
	if (xPawn(Victim) != None && Pawn(Victim).Health > 0)
	{
		if (Monster(Victim) == None || Pawn(Victim).default.Health > 275)
			bWasAlive = true;
	}
		
	if (BallisticPawn(Instigator) != None && RSNovaStaff(Instigator.Weapon) != None && Victim.bProjTarget && (Pawn(Victim).GetTeamNum() != Instigator.GetTeamNum() || Instigator.GetTeamNum() == 255))
		BallisticPawn(Instigator).GiveAttributedHealth(Dmg / 3, Instigator.SuperHealthMax, Instigator, True);

	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, KickForce * Dir, HitDT);
	if (bWasAlive && Pawn(Victim).health <= 0)
		class'RSNovaSoul'.static.SpawnSoul(HitLocation, Instigator, Pawn(Victim), Weapon);

	if (Pawn(Other) != None && Pawn(Other).Health > 0)
	{
		HookedVictim = Pawn(Other);
		HookTime = level.TimeSeconds;
	}
}

defaultproperties
{
     SwipePoints(0)=(offset=(Pitch=1000,Yaw=1000))
     SwipePoints(1)=(Weight=2,offset=(Yaw=0))
     SwipePoints(2)=(Weight=1,offset=(Pitch=-1000,Yaw=-1000))
     WallHitPoint=1
     NumSwipePoints=3
     DamageHead=75.000000
     DamageLimb=75.000000
     DamageType=Class'BallisticProV55.DT_RSNovaStab'
     DamageTypeHead=Class'BallisticProV55.DT_RSNovaStabHead'
     DamageTypeArm=Class'BallisticProV55.DT_RSNovaStab'
     KickForce=100
     HookStopFactor=1.700000
     HookPullForce=150.000000
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     bIgnoreReload=True
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=SoundGroup'BWBP4-Sounds.NovaStaff.Nova-Melee',Radius=256.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepSwipe"
     FireAnim="Swipe"
     AmmoClass=Class'BallisticProV55.Ammo_NovaCrystal'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=384.000000)
     ShakeRotRate=(X=3500.000000,Y=3500.000000,Z=3500.000000)
     ShakeRotTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.050000
}
