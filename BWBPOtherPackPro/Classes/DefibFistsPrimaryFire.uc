//=============================================================================
// Defib Fists Primary.
//
// Rapid, two handed jabs with reasonable range. Everything is timed by notifys
// from the anims
//
// by Casey "Xavious" Johnson and Azarael
//=============================================================================
class DefibFistsPrimaryFire extends BallisticMeleeFire;

var bool bPunchLeft;
var BUtil.FullSound DischargedFireSound;

event ModeDoFire()
{
	local float f;

	Super.ModeDoFire();

	f = FRand();
	if (f > 0.50)
	{
		if (bPunchLeft)
			FireAnim = 'PunchL1';
		else
			FireAnim = 'PunchR1';		
	}
	else
	{
		if (bPunchLeft)
			FireAnim = 'PunchL2';
		else
			FireAnim = 'PunchR2';	
	}

	if (bPunchLeft)
		bPunchLeft=False;
	else
		bPunchLeft=True;	
}

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (DefibFists(BW).bDischarged)
		Weapon.PlayOwnedSound(DischargedFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();

	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
}

//Do the spread on the client side
function PlayFiring()
{		
	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (DefibFists(BW).bDischarged)
			Weapon.PlayOwnedSound(DischargedFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

simulated function bool HasAmmo()
{
	return true;
}

function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
	local float				Dmg;
	local class<DamageType>	HitDT;
	local Actor				Victim;
	local Vector			RelativeVelocity, ForceDir, BoneTestLocation, ClosestLocation, testDir;
	local BallisticPawn Target;
	local int PrevHealth;
	Target=BallisticPawn(Other);
		
	if(IsValidHealTarget(Target))
	{
		if (DefibFists(BW).ElectroCharge >= 30)
		{
			PrevHealth = Target.Health;
			Target.GiveAttributedHealth(15, Target.HealthMax, Instigator);
			DefibFists(Weapon).PointsHealed += Target.Health - PrevHealth;
			DefibFists(BW).ElectroCharge -= 30;
			DefibFists(BW).LastRegen = Level.TimeSeconds + 0.5;
		}
		return;
	}
	
	if (Mover(Other) != None || Vehicle(Other) != None)
		return;

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
	
	if (DefibFists(Weapon).ElectroCharge < 15)
		Dmg *= 0.35;
	
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

	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, KickForce * Dir, HitDT);
	
	if (DefibFists(BW).ElectroCharge >= 30)
		DefibFists(BW).ElectroCharge -= 30;
	DefibFists(BW).LastRegen = Level.TimeSeconds + 0.5;
}

function bool IsValidHealTarget(Pawn Target)
{
	if(Target==None||Target==Instigator)
		return false;

	if(Target.Health<=0)
		return false;
	
	if (!Target.bProjTarget)
		return false;

	if(!Level.Game.bTeamGame)
		return false;

	if(Vehicle(Target)!=None)
		return false;

	return (Target.Controller!=None && Instigator.Controller.SameTeamAs(Target.Controller));
}

defaultproperties
{
     DischargedFireSound=(Sound=Sound'BallisticSounds3.M763.M763Swing',Radius=32.000000,bAtten=True)
     FatiguePerStrike=0.015000
     Damage=45.000000
     DamageHead=45.000000
     DamageLimb=45.000000
     DamageType=Class'BWBPOtherPackPro.DTShockGauntlet'
     DamageTypeHead=Class'BWBPOtherPackPro.DTShockGauntlet'
     DamageTypeArm=Class'BWBPOtherPackPro.DTShockGauntlet'
     KickForce=40000
     bUseWeaponMag=False
     BallisticFireSound=(Sound=SoundGroup'BWAddPack-RS-Sounds.MRS38.RSS-ElectroSwing',Radius=32.000000,bAtten=True)
     bAISilent=True
     FireAnim="PunchL1"
     FireAnimRate=1.250000
     FireRate=0.400000
     AmmoClass=Class'BWBPOtherPackPro.Ammo_DefibCharge'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=384.000000)
     ShakeRotRate=(X=3500.000000,Y=3500.000000,Z=3500.000000)
     ShakeRotTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.050000
}
