//=============================================================================
// Defib Fists Secondary.
//
// Devastating uppercut which can also heal allies.
// by Casey "Xavious" Johnson and Azarael
//=============================================================================
class DefibFistsSecondaryFire extends BallisticMeleeFire;

var bool bCharged;
var BUtil.FullSound DischargedFireSound;

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
	local vector UpwardsKnock;
	local BallisticPawn Target;
	local int PrevHealth;
	
	UpwardsKnock.Z=450;
	Target=BallisticPawn(Other);
	
	if(IsValidHealTarget(Target))
	{
		if (DefibFists(BW).ElectroCharge >= 60)
		{
			PrevHealth = Target.Health;

			Target.GiveAttributedHealth(30, Target.HealthMax, Instigator);
			DefibFists(Weapon).PointsHealed += Target.Health - PrevHealth;
			DefibFists(BW).ElectroCharge -= 60;
			DefibFists(BW).LastRegen = Level.TimeSeconds + 0.5;
			return;
		}
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
	
	if (DefibFists(Weapon).ElectroCharge < 25)
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
	
	if (Pawn(Other) != None && Pawn(Other).bProjTarget)
		Pawn(Other).AddVelocity(UpwardsKnock);
		
	if (DefibFists(BW).ElectroCharge >= 60)
		DefibFists(BW).ElectroCharge -= 60;
	DefibFists(BW).LastRegen = Level.TimeSeconds + 0.5;
}

function DoFireEffect()
{
	if (DefibFists(Weapon).ElectroCharge >= 90)
	{
		DefibFists(Weapon).ElectroShockWave(30, 350, class'DTShockGauntletWave', 50000, Instigator.Location);
		DefibFists(Weapon).ElectroCharge -= 30;
		DefibFistsAttachment(Weapon.ThirdPersonActor).DoWave(true);
	}
	Super(BallisticMeleeFire).DoFireEffect();
}

function bool IsValidHealTarget(Pawn Target)
{
	if(Target==None||Target==Instigator)
		return False;

	if(Target.Health<=0)
		return False;
		
	if (!Target.bProjTarget)
		return false;

	if(!Level.Game.bTeamGame)
		return False;

	if(Vehicle(Target)!=None)
		return False;

	return (Target.Controller!=None&&Instigator.Controller.SameTeamAs(Target.Controller));
}

function MeleeDoTrace (Vector InitialStart, Rotator Dir, bool bWallHitter, int Weight)
{
	local int						i;
	local Vector					End, X, HitLocation, HitNormal, Start, WaterHitLoc, LastHitLocation;
	local Material					HitMaterial;
	local float						Dist;
	local Actor						Other, LastOther;
	local bool						bHitWall;

	// Work out the range
	Dist = TraceRange.Min + FRand() * (TraceRange.Max - TraceRange.Min);

	Start = InitialStart;
	X = Normal(Vector(Dir));
	End = Start + X * Dist;
	LastHitLocation=End;
	Weapon.bTraceWater=true;

	while (Dist > 0)		// Loop traces in case we need to go through stuff
	{
		// Do the trace
		Other = Trace (HitLocation, HitNormal, End, Start, true, , HitMaterial);
		Dist -= VSize(HitLocation - Start);
		if (Level.NetMode == NM_Client && (Other.Role != Role_Authority || Other.bWorldGeometry))
			break;
		if (Other != None)
		{
			LastHitLocation=HitLocation;
			// Water
			if (bWallHitter && ((FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume)))
			{
				if (VSize(HitLocation - Start) > 1)
					WaterHitLoc=HitLocation;
				Start = HitLocation;
				End = Start + X * Dist;
				Weapon.bTraceWater=false;
				continue;
			}
			else
				LastHitLocation=HitLocation;
			// Got something interesting
			if (!Other.bWorldGeometry && Other != LastOther)
			{
				for(i=0;i<SwipeHits.length;i++)
					if (SwipeHits[i].Victim == Other)
					{
						if(SwipeHits[i].Weight < Weight)
						{
							SwipeHits.Remove(i, 1);
							i--;
						}
						else
							break;
					}
				if (i>=SwipeHits.length)
				{
					SwipeHits.Length = SwipeHits.length + 1;
					SwipeHits[SwipeHits.length-1].Victim = Other;
					SwipeHits[SwipeHits.length-1].Weight = Weight;
					SwipeHits[SwipeHits.length-1].HitLoc = HitLocation;
					SwipeHits[SwipeHits.length-1].HitDir = X;
					LastOther = Other;

					if (bWallHitter && Vehicle(Other) != None)
					{
						bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
					}
				}
				if (Mover(Other) == None)
					Break;
			}
			// Do impact effect
			if (Other.bWorldGeometry || Mover(Other) != None)
			{
				if (bWallHitter)
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
				break;
			}
			// Still in the same guy
			if (Other == Instigator || Other == LastOther)
			{
				Start = HitLocation + (X * Other.CollisionRadius * 2);
				End = Start + X * Dist;
				continue;
			}
			break;
		}
		else
			break;
	}
	// Never hit a wall, so just tell the attachment to spawn muzzle flashes and play anims, etc
	if (!bHitWall && bWallHitter)
		NoHitEffect(X, InitialStart, LastHitLocation, WaterHitLoc);
	Weapon.bTraceWater=false;
}

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (DefibFists(BW).ElectroCharge < 10)
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

	if (DefibFists(BW).ElectroCharge < 10)
			Weapon.PlayOwnedSound(DischargedFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

defaultproperties
{
     DischargedFireSound=(Sound=Sound'BallisticSounds3.M763.M763Swing',Radius=32.000000,bAtten=True)
     FatiguePerStrike=0.150000
     bCanBackstab=False
     Damage=70.000000
     DamageHead=70.000000
     DamageLimb=70.000000
     DamageType=Class'BWBPOtherPackPro.DTShockGauntletAlt'
     DamageTypeHead=Class'BWBPOtherPackPro.DTShockGauntletAlt'
     DamageTypeArm=Class'BWBPOtherPackPro.DTShockGauntletAlt'
     KickForce=40000
     bUseWeaponMag=False
     BallisticFireSound=(Sound=SoundGroup'BWAddPack-RS-Sounds.MRS38.RSS-ElectroSwing',Radius=32.000000,bAtten=True)
     bAISilent=True
     PreFireAnim="UppercutPrep"
     FireAnim="Uppercut"
     FireAnimRate=1.500000
     FireRate=1.000000
     AmmoClass=Class'BWBPOtherPackPro.Ammo_DefibCharge'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=384.000000)
     ShakeRotRate=(X=3500.000000,Y=3500.000000,Z=3500.000000)
     ShakeRotTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.050000
}
